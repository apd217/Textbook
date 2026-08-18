# Italicize the remaining APA statistical symbols in PROSE ONLY.
#
#   Rscript italicize_stats.R          dry run, prints every proposed change
#   Rscript italicize_stats.R --write  actually writes
#
# Companion to italicize_tF.R, which did *t* and *F* on 2026-08-16. Alex
# approved extending the convention to p, r, M, SD, N, n and df on 2026-08-17,
# at the same time he approved the APA formatting table in Ch_37_Reporting.
#
# SCOPE, deliberately narrow. Only two shapes are touched:
#
#   1. A symbol immediately before a comparator:  p = .03   r < .5   N = 222
#      This is the only context where a bare letter is unambiguously a
#      statistic. Bare `p` and bare `r` in running prose are NOT sweepable:
#      the same survey that killed the bare-t sweep applies here, and "r"
#      alone is a letter that turns up everywhere.
#   2. The hyphenated compound `p-value` / `p-values`, matching the shape
#      italicize_tF.R already swept for t and F.
#
# Protected and never edited: YAML front matter, fenced code chunks, #| chunk
# option lines (fig-alt especially, where markdown is not parsed and asterisks
# would be read aloud), inline `code` spans, $inline math$, $$display math$$.
# Inside math these symbols are already italic, so math needs nothing.
#
# NOT swept, on purpose: Greek letters, and CI/ANOVA/OR-style word
# abbreviations. See "The APA Formatting Rules Nobody Tells You" in
# Ch_37_Reporting for the rule this implements.

args  <- commandArgs(trailingOnly = TRUE)
write <- "--write" %in% args

files <- sort(list.files(".", pattern = "^(Ch_.*|index)[.]qmd$"))

symbols <- "(p|r|M|SD|N|n|df)"

subst <- function(s) {
  # symbol sitting immediately in front of = < >, e.g. "p = .03", "N = 222"
  s <- gsub(paste0("(?<![\\w*.])", symbols, "(?=\\s*[=<>])"),
            "*\\1*", s, perl = TRUE)
  # the p-value compound, same shape italicize_tF.R used for t and F
  s <- gsub("(?<![\\w*])p-(values?)\\b", "*p*-\\1", s, perl = TRUE)
  s
}

# IMPORTANT, and this is why italicize_tF.R got away with a simpler version:
# inline code spans must be masked BEFORE math spans are looked for. A line like
#
#   $t(`r tl$df`) =$ `r round(x, 2)`, $p < .001$
#
# contains a `$` *inside* backticks (`tl$df`). Scan for `$...$` first and the
# math matcher pairs the wrong dollars, leaves the real `$p < .001$` exposed,
# and the sweep writes `$*p* < .001$`, which renders as literal asterisks
# inside math. Found by auditing the dry run against
# Ch_12_Categorical_Regression.qmd, twice. Mask code, then math.
code_re <- "`[^`]*`"
math_re <- "([$][$].*?[$][$])|([$][^$]+[$])"

mask_spans <- function(ln, re) {
  m <- gregexpr(re, ln, perl = TRUE)[[1]]
  if (m[1] == -1) return(list(txt = ln, st = integer(0), len = integer(0)))
  st <- as.integer(m); len <- attr(m, "match.length")
  masked <- ln
  for (k in seq_along(st)) {
    substr(masked, st[k], st[k] + len[k] - 1L) <- strrep("\1", len[k])
  }
  list(txt = masked, st = st, len = len)
}

apply_outside_protected <- function(ln) {
  a <- mask_spans(ln, code_re)          # code first
  b <- mask_spans(a$txt, math_re)       # then math, on the code-masked text
  protected <- rbind(cbind(a$st, a$len), cbind(b$st, b$len))
  if (!nrow(protected)) return(subst(ln))
  protected <- protected[order(protected[, 1]), , drop = FALSE]
  out <- ""; pos <- 1L
  for (k in seq_len(nrow(protected))) {
    s <- protected[k, 1]; l <- protected[k, 2]
    if (s < pos) next
    if (s > pos) out <- paste0(out, subst(substr(ln, pos, s - 1L)))
    out <- paste0(out, substr(ln, s, s + l - 1L))
    pos <- s + l
  }
  if (pos <= nchar(ln)) out <- paste0(out, subst(substr(ln, pos, nchar(ln))))
  out
}

total <- 0L; touched <- 0L
for (f in files) {
  x <- enc2utf8(readLines(f, warn = FALSE, encoding = "UTF-8"))
  orig <- x
  inchunk <- FALSE; inmath <- FALSE; incomment <- FALSE; yaml_fences <- 0L
  for (i in seq_along(x)) {
    ln <- x[i]
    if (grepl("^---\\s*$", ln) && yaml_fences < 2L) { yaml_fences <- yaml_fences + 1L; next }
    if (yaml_fences < 2L) next                       # inside YAML front matter
    if (grepl("^\\s*```", ln)) { inchunk <- !inchunk; next }
    if (inchunk) next
    if (grepl("^\\s*#[|]", ln)) next                 # chunk options incl. fig-alt
    if (grepl("^\\s*[$][$]\\s*$", ln)) { inmath <- !inmath; next }
    if (inmath) next
    # Callout fences carry a title= attribute. Quarto parses that attribute as
    # an attribute, not as markdown, so asterisks would show up literally.
    if (grepl("^\\s*:::", ln)) next
    # ---Alex--- notes and any other HTML comment never reach the reader, and
    # they run to several lines, so track the block rather than the delimiters.
    if (incomment) { if (grepl("-->", ln)) incomment <- FALSE; next }
    if (grepl("<!--", ln)) { if (!grepl("-->", ln)) incomment <- TRUE; next }
    new <- apply_outside_protected(ln)
    if (!identical(new, ln)) x[i] <- new
  }
  changed <- which(orig != x)
  if (length(changed)) {
    touched <- touched + 1L
    n <- sum(lengths(regmatches(x[changed], gregexpr("[*](p|r|M|SD|N|n|df)[*]", x[changed])))) -
         sum(lengths(regmatches(orig[changed], gregexpr("[*](p|r|M|SD|N|n|df)[*]", orig[changed]))))
    total <- total + n
    cat(sprintf("\n%s  (%d lines, %d symbols)\n", f, length(changed), n))
    for (i in changed) {
      cat("   - ", trimws(substr(orig[i], 1, 150)), "\n", sep = "")
      cat("   + ", trimws(substr(x[i],    1, 150)), "\n", sep = "")
    }
    if (write) writeLines(x, f, useBytes = TRUE)
  }
}
cat(sprintf("\n== %s: %d symbols across %d files ==\n",
            if (write) "WROTE" else "DRY RUN", total, touched))
