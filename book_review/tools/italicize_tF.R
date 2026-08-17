# Italicize the t and F in hyphenated statistic compounds, in PROSE ONLY.
#
#   Rscript italicize_tF.R          dry run, prints every proposed change
#   Rscript italicize_tF.R --write  actually writes
#
# Deliberately does NOT touch bare t / bare F. The survey showed those are
# dominated by false positives: "don't", and F inside multi-line $$ math.
#
# Protected and never edited: YAML front matter, fenced code chunks, #| chunk
# option lines (fig-alt especially, where markdown is not parsed and asterisks
# would be read aloud), inline `code` spans, $inline math$, $$display math$$.

args  <- commandArgs(trailingOnly = TRUE)
write <- "--write" %in% args

files <- sort(list.files(".", pattern = "^(Chapter_.*|index)\\.qmd$"))

stat_words <- "(tests?|statistics?|values?|distributions?|ratios?|scores?)"

# lookbehind blocks *t-test and **t-test so we never nest emphasis
subst <- function(s) {
  s <- gsub(paste0("(?<![\\w*])t-", stat_words, "\\b"), "*t*-\\1", s, perl = TRUE)
  s <- gsub(paste0("(?<![\\w*])F-", stat_words, "\\b"), "*F*-\\1", s, perl = TRUE)
  s
}

protect_re <- "(`[^`]*`)|(\\$\\$[^$]*\\$\\$)|(\\$[^$]*\\$)"

apply_outside_protected <- function(ln) {
  m <- gregexpr(protect_re, ln, perl = TRUE)[[1]]
  if (m[1] == -1) return(subst(ln))
  st <- as.integer(m); len <- attr(m, "match.length")
  out <- ""; pos <- 1L
  for (k in seq_along(st)) {
    if (st[k] > pos) out <- paste0(out, subst(substr(ln, pos, st[k] - 1L)))
    out <- paste0(out, substr(ln, st[k], st[k] + len[k] - 1L))
    pos <- st[k] + len[k]
  }
  if (pos <= nchar(ln)) out <- paste0(out, subst(substr(ln, pos, nchar(ln))))
  out
}

total <- 0L; touched <- 0L
for (f in files) {
  x <- enc2utf8(readLines(f, warn = FALSE, encoding = "UTF-8"))
  orig <- x
  inchunk <- FALSE; inmath <- FALSE; yaml_fences <- 0L
  for (i in seq_along(x)) {
    ln <- x[i]
    if (grepl("^---\\s*$", ln) && yaml_fences < 2L) { yaml_fences <- yaml_fences + 1L; next }
    if (yaml_fences < 2L) next                       # inside YAML front matter
    if (grepl("^\\s*```", ln)) { inchunk <- !inchunk; next }
    if (inchunk) next
    if (grepl("^\\s*#\\|", ln)) next                 # chunk options incl. fig-alt
    # multi-line display math: a line that is exactly $$ toggles the block
    if (grepl("^\\s*\\$\\$\\s*$", ln)) { inmath <- !inmath; next }
    if (inmath) next
    new <- apply_outside_protected(ln)
    if (!identical(new, ln)) x[i] <- new
  }
  changed <- which(orig != x)
  if (length(changed)) {
    touched <- touched + 1L
    n <- sum(lengths(regmatches(x[changed], gregexpr("\\*[tF]\\*-", x[changed])))) -
         sum(lengths(regmatches(orig[changed], gregexpr("\\*[tF]\\*-", orig[changed]))))
    total <- total + n
    cat(sprintf("\n%s  (%d lines, %d symbols)\n", f, length(changed), n))
    for (i in head(changed, 3)) {
      cat("   - ", trimws(substr(orig[i], 1, 96)), "\n", sep = "")
      cat("   + ", trimws(substr(x[i],    1, 96)), "\n", sep = "")
    }
    if (length(changed) > 3) cat("     ... and", length(changed) - 3, "more lines\n")
    if (write) writeLines(x, f, useBytes = TRUE)
  }
}
cat(sprintf("\n== %s: %d symbols across %d files ==\n",
            if (write) "WROTE" else "DRY RUN", total, touched))
