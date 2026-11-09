# Post-render step (runs after every `quarto render`; see project: post-render in _quarto.yml).
#
# Some chapters render from _freeze/ without their figures being copied into the
# output folder, so the HTML points at <chapter>_files/figure-html/*.png files that
# do not exist and the plots silently disappear from the website. This script finds
# every image an HTML page references, and if the file is missing from the output
# folder but present in _freeze/<chapter>/figure-html/, copies it over.

out_dir <- Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR", "_book")
if (!dir.exists(out_dir)) quit(save = "no")

pages <- list.files(out_dir, pattern = "\\.html$", full.names = TRUE)

restored <- 0L
unrecoverable <- character()

for (page in pages) {
  html <- paste(readLines(page, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  srcs <- regmatches(html, gregexpr('src="[^"]*_files/figure-html/[^"]*"', html))[[1]]
  if (length(srcs) == 0) next

  srcs <- unique(utils::URLdecode(sub('^src="', "", sub('"$', "", srcs))))
  chapter <- tools::file_path_sans_ext(basename(page))

  for (src in srcs) {
    target <- file.path(out_dir, src)
    if (file.exists(target)) next

    frozen <- file.path("_freeze", chapter, "figure-html", basename(src))
    if (file.exists(frozen)) {
      dir.create(dirname(target), recursive = TRUE, showWarnings = FALSE)
      file.copy(frozen, target, copy.date = TRUE)
      restored <- restored + 1L
    } else {
      unrecoverable <- c(unrecoverable, target)
    }
  }
}

if (restored > 0) {
  message("restore_missing_figures: copied ", restored, " missing figure(s) from _freeze/")
}
if (length(unrecoverable) > 0) {
  warning("restore_missing_figures: ", length(unrecoverable),
          " figure(s) missing and not in _freeze/:\n  ",
          paste(unrecoverable, collapse = "\n  "), call. = FALSE)
}
