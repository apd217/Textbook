# Chapter 26 — R Help and Review: Tidyverse Without Tears (Chapter_Tidyverse_Review.qmd)

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
- **Location:** Chapter_Tidyverse_Review.qmd → solutions callout (search anchor: "filter(sleep_hours < 6, caffeine_mg >= 200)")
- **Problem:** The `filter()` section teaches `&` for AND; the solutions use the comma shorthand without comment. Both are correct, but the struggling reader who just memorized `&` will wonder if the comma is different magic.
- **Fix:** One sentence in the solutions or at first use: "Inside `filter()`, a comma means the same thing as `&` — every condition must be true." 
- **Approved:** [x ]

### [CH26-B01] The pipe policy stated here should be enforced (or at least declared) book-wide
- **Priority:** MED
- **Perspective:** Publisher + Student
- **Effort:** M (book-wide)
- **Location:** Chapter_Tidyverse_Review.qmd → "The Native Pipe" (search anchor: "eventually update the rest of the book")
- **Problem:** This chapter teaches `|>` and openly admits earlier chapters still use `%>%` (they do — Distro_Moments, Standard_Error, CatVariables, and others). The admission is charming but the inconsistency is real: students copying from Chapter 4 and Chapter 26 will mix pipes without knowing whether it matters. This is the anchor for the cross-cutting pipe item in 00_OVERVIEW.md.
- **Fix (cross-cutting):** Pick `|>` (the stated direction), sweep the book (`grep '%>%'`), and add two sentences to R_Basics introducing the pipe early with the note that `%>%` in the wild means the same thing. If a full sweep is too disruptive, at minimum move this chapter's "%>% is the old one, same idea" explanation into R_Basics so students meet the explanation *before* they meet the inconsistency.
- **Approved:** [ x]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Not flagged (deliberate):** "Do not reinstall the sofa every morning"; the `=` vs `==`
"destroyed entire afternoons" warning; `.groups = "drop"` explained as ghost-possession
prevention; geom_col vs geom_bar; the closing "the software is obedient; you still have to
be the adult in the room." The practice-with-collapsible-solutions section is the template
for the cross-cutting self-check item — reuse its exact structure ("Try these before
looking…" + collapsible "Solutions, because suffering has limits").
