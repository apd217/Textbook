# Chapter 26 — R Help and Review: Tidyverse Without Tears (Ch_38_Tidyverse_Review.qmd)

**Snapshot:** ~1,900 words. Excellent appendix — five verbs, group-then-summarise,
`across()`, pipe-vs-plus distinction, correct boxplot anatomy, and (only the second chapter
to do this) **practice exercises with collapsible solutions**. Together with Chapter 14's
"Four Questions," this is the proof-of-concept for the book-wide self-check item. Findings
are trivia.

---

### [CH26-U01] Solutions use comma-as-AND right after the chapter taught `&`
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_38_Tidyverse_Review.qmd → solutions callout (search anchor: "filter(sleep_hours < 6, caffeine_mg >= 200)")
- **Problem:** The `filter()` section teaches `&` for AND; the solutions use the comma shorthand without comment. Both are correct, but the struggling reader who just memorized `&` will wonder if the comma is different magic.
- **Fix:** One sentence in the solutions or at first use: "Inside `filter()`, a comma means the same thing as `&` — every condition must be true." 
- **Approved:** [x] — IMPLEMENTED 2026-08-17 at first use rather than in the solutions, so the
  reader has it before the surprise. It shows the comma form of the exact filter they just
  read, says it returns the same rows, and warns that both forms appear later including in
  the solutions.

### [CH26-B01] The pipe policy stated here should be enforced (or at least declared) book-wide
- **Priority:** MED
- **Perspective:** Publisher + Student
- **Effort:** M (book-wide)
- **Location:** Ch_38_Tidyverse_Review.qmd → "The Native Pipe" (search anchor: "eventually update the rest of the book")
- **Problem:** This chapter teaches `|>` and openly admits earlier chapters still use `%>%` (they do — Distro_Moments, Standard_Error, CatVariables, and others). The admission is charming but the inconsistency is real: students copying from Chapter 4 and Chapter 26 will mix pipes without knowing whether it matters. This is the anchor for the cross-cutting pipe item in 00_OVERVIEW.md.
- **Fix (cross-cutting):** Pick `|>` (the stated direction), sweep the book (`grep '%>%'`), and add two sentences to R_Basics introducing the pipe early with the note that `%>%` in the wild means the same thing. If a full sweep is too disruptive, at minimum move this chapter's "%>% is the old one, same idea" explanation into R_Basics so students meet the explanation *before* they meet the inconsistency.
- **Approved:** [x] — IMPLEMENTED 2026-08-17. **Alex chose the full sweep** over the
  cheaper move-the-explanation option when asked. G06 is now closed.

  **32 occurrences in 4 chapters**, not the wider spread the item expected:
  `Distro_Moments` 18, `CatXCat_Interaction` 10, `Interaction_1` 2,
  `Regression with Cat Variables` 2. **`Standard_Error` had none**, so that part of the
  item was already stale.

  **Every occurrence was inspected before anything was replaced**, because `%>%` and `|>`
  are *not* unconditionally interchangeable: the native pipe rejects the bare
  `x %>% f` form and does not take magrittr's `.` placeholder. All 32 were of the safe
  `x %>% f(...)` shape, so a literal replace was sound. Both forms are absent from the
  book, which is the only reason this was mechanical.

  **Verified by output, not by rendering alone.** All four chapters plus `R_Basics` and
  this one re-render clean, and a word-diff of each chapter's
  `_freeze/*/execute-results/html.json` shows the *only* changes are the pipe characters
  themselves and the source hash. Every computed number, table and figure is byte-identical.

  **R_Basics gained a `## The Pipe: |>` section** after Packages, per the item: read it as
  "then", a runnable two-line example on the `study` data frame the chapter already built,
  and the note that `%>%` in the wild means the same thing. The pipe was previously first
  explained in `Distro_Moments` (chapter 4); that explanation stays, at first use, and now
  reads `|>`.

  The two surviving `%>%` in the book are both deliberate: the R_Basics note and this
  chapter's, and both exist to teach the reader what the old symbol means.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

### Done alongside the items, 2026-08-17

- **G01 (YAML strip): DONE.** `fontsize`, `geometry` and the `format: pdf:` block removed.
- **G02 (`fig-alt`): DONE**, all five figures including the one in the collapsible
  solutions. Each was written against the rendered PNG. The `geom_col` figure's alt text
  explains the **missing 100 mg bar**, which is not a plotting failure: in this simulated
  sample zero of the 44 students at that dose reported hearing colors, so the bar has
  height zero and nothing is drawn. A sighted reader can infer that; a screen-reader user
  could not.
- **G05b: DONE, and this chapter had the block.** The hidden `setup` chunk carried
  `library(dplyr)` and `library(ggplot2)`. Deleted per Alex's 2026-08-17 answer. The trap
  here was that the chapter's *visible* `library()` chunk was marked `eval: false`, so
  deleting the hidden block alone would have broken every chunk in the file. The visible
  chunk now actually evaluates and carries a line of lead-in saying so.
- **Chunk names: DONE**, 20 anonymous chunks named, and the five stale `unnamed-chunk-*`
  figures dropped from `_freeze`.
- **Em-dash density: 0.82 → 0.76**, both the floor.
- **`Ch_02_R_Basics` is at 2.03 per 1k and above target.** It was already above target
  (2.21) before this session; the number moved only because the new pipe section added
  words. **The new prose contains no em-dashes.** Flagging it because it is a Part 1
  chapter and nobody is authorized to sweep it, and it is not on the known list, which
  previously named only `Distro_Moments` and `Introduction`.

**Not flagged (deliberate):** "Do not reinstall the sofa every morning"; the `=` vs `==`
"destroyed entire afternoons" warning; `.groups = "drop"` explained as ghost-possession
prevention; geom_col vs geom_bar; the closing "the software is obedient; you still have to
be the adult in the room." The practice-with-collapsible-solutions section is the template
for the cross-cutting self-check item — reuse its exact structure ("Try these before
looking…" + collapsible "Solutions, because suffering has limits").
