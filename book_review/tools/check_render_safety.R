# check_render_safety.R
#
# Run from the project root:
#   Rscript book_review/tools/check_render_safety.R
#
# Two checks that Alex asked for on 2026-08-16, after noticing that arrows and
# superscripts might not survive the PDF build and that the Part 2 chapters had
# drifted into em-dash abuse.
#
# 1. PDF-BREAKING CHARACTERS. The book renders PDF with xelatex in CMU Serif /
#    CMU Sans. Those fonts are missing a handful of common characters, and
#    xelatex drops them SILENTLY: no error, the character just vanishes from the
#    page. The list below is not guesswork, it came from reading the xelatex log
#    for a test document set in the book's own fonts.
#
#      CONFIRMED MISSING   ↔ U+2194   ⇒ U+21D2   ⁴ U+2074
#                          ≠ U+2260   ≤ U+2264   ≥ U+2265   ≈ U+2248
#
#      CONFIRMED SAFE      → ² ³ − × ± • … Δ α β ρ σ μ
#                          smart quotes, en dash, em dash, à é
#
#    Note the traps: the RIGHT arrow is fine but the DOUBLE-HEADED arrow is not,
#    and superscript 2 and 3 are fine but superscript 4 is not. Do not reason
#    from "it looked fine in HTML" or from one character to its neighbours.
#
#    Fixes: use math mode ($\neq$, $\leq$, $\approx$, $\leftrightarrow$), or
#    plain ASCII inside code comments (`<->`), or write it in words.
#
# 2. EM-DASH DENSITY. The house form is `---` (three hyphens), not a literal
#    em-dash character. VOICE_GUIDE §14 bans NEW em-dashes; this measures whether
#    a chapter has drifted. The mature Part 1 chapters run 0.55 to 1.20 per 1000
#    words. Treat anything above about 1.5 as needing a pass.

files <- sort(list.files(".", pattern = "^(Chapter_.*|index)\\.qmd$"))
if (!length(files)) stop("No chapter .qmd files here. Run from the project root.")

bad <- c("↔" = 0x2194, "⇒" = 0x21D2, "⁴" = 0x2074, "≠" = 0x2260,
         "≤" = 0x2264, "≥" = 0x2265, "≈" = 0x2248)

cat("== 1. PDF-breaking characters ==\n")
any_bad <- FALSE
for (f in files) {
  x <- enc2utf8(readLines(f, warn = FALSE, encoding = "UTF-8"))
  for (i in seq_along(x)) {
    ch  <- unlist(strsplit(x[i], ""))
    cps <- vapply(ch, function(z) { k <- utf8ToInt(z); if (is.na(k)) 0L else k }, integer(1))
    hit <- intersect(cps, bad)
    if (length(hit)) {
      any_bad <- TRUE
      cat(sprintf("  %s:%d  %s\n", f, i,
                  paste(sprintf("U+%04X %s", hit, intToUtf8(hit, multiple = TRUE)), collapse = " ")))
      cat("      ", trimws(substr(x[i], 1, 120)), "\n", sep = "")
    }
  }
}
if (!any_bad) cat("  none found\n")

cat("\n== 2. Em-dash density (per 1000 words, prose only) ==\n")
cat(sprintf("  %-42s %7s %8s %9s\n", "chapter", "dashes", "words", "per 1k"))
for (f in files) {
  x <- enc2utf8(readLines(f, warn = FALSE, encoding = "UTF-8"))
  inchunk <- FALSE; keep <- character(0)
  for (ln in x) {
    if (grepl("^```", ln)) { inchunk <- !inchunk; next }
    if (!inchunk) keep <- c(keep, ln)
  }
  s <- paste(keep, collapse = "\n")
  s <- gsub("(?s)<!--.*?-->", " ", s, perl = TRUE)         # HTML comments, incl. ---Alex--- notes
  s <- gsub("^---$", " ", s)                               # the two YAML fences
  s <- gsub("\n---\n", "\n", s)
  s <- gsub("\\|[-: |]+\\|", " ", s)                       # markdown table rules
  n <- lengths(regmatches(s, gregexpr("—", s))) +
       lengths(regmatches(s, gregexpr("(?<![-])---(?![-])", s, perl = TRUE)))
  w <- lengths(regmatches(s, gregexpr("\\S+", s)))
  if (w == 0) next
  rate <- 1000 * n / w
  flag <- if (rate > 1.5) "  <-- high" else ""
  cat(sprintf("  %-42s %7d %8d %9.2f%s\n",
              sub("\\.qmd$", "", f), n, w, rate, flag))
}

cat("\n== 3. Possible hyphenated compounds broken by a dash replace (EYEBALL THESE) ==\n")
# Signature: a --- whose right-hand word is ITSELF hyphenated, e.g. a search and
# replace turning "texting-while-driving" into "texting---while-driving".
# A plain word---word is ordinary house-style em-dash and is not flagged.
# This one has false positives on purpose: "a CSV file---comma-separated values"
# is a legitimate em-dash that happens to precede a hyphenated word. The list is
# short, so read it rather than trusting it.
found <- FALSE
for (f in files) {
  x <- enc2utf8(readLines(f, warn = FALSE, encoding = "UTF-8"))
  hits <- grep("[a-z]---[a-z]+-[a-z]", x)
  for (h in hits) { found <- TRUE; cat(sprintf("  %s:%d  %s\n", f, h, trimws(substr(x[h], 1, 110)))) }
}
if (!found) cat("  none found\n")

invisible(NULL)
