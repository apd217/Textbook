# Chapter 17 — Categorical-by-Categorical Interactions: The 2×2 (Chapter_CatXCat_Interaction.qmd)

**Snapshot:** ~5,300 words, deliberately parallel to Chapter 16 (same study, same structure,
same APA scaffolding) — that parallelism is the chapter's best feature, and the
"difference of differences" development with cell-mean reconstruction tables is textbook-
grade. Main issues: the extreme-groups split needs a "do not do this at home" label, the
friends-vs-closeness DV confusion carries over from Chapter 16, and the promised ANOVA
cameo (preface: "ANOVA gets a brief appearance") still never happens.

---

### [CH17-P01] The extreme-groups split is used without the "never do this to real data" warning
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → "The Data" (search anchor: "we focus on the **extremes of the niceness distribution**")
- **Problem:** The chapter dichotomizes a continuous predictor (keep <2 and >8, discard the middle 120 students) to manufacture a 2×2. As a *teaching device* this is defensible and even clever — but dichotomizing continuous variables is one of the most-cited methodological sins in psychology (MacCallum, Zhang, Preacher & Rucker, 2002), and students *will* imitate what the book does. The closing comparison table notes "less statistical power" but never says "this is a demonstration, not a recommendation."
- **Fix:** Add a callout at the point of the split: "**Why we're allowed to do this (and you're mostly not):** I am butchering a perfectly good continuous variable to teach you the 2×2 framework, because the 2×2 is how half of psychology structures its experiments. Doing this to *real* continuous data — median splits, extreme groups — throws away information, shrinks power, and can create phantom effects. If your variable is continuous, use the previous chapter's model. [cite MacCallum et al. 2002; add to references.bib]." The end-of-chapter comparison table then reinforces rather than introduces the point.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. `callout-warning` titled "Why We Are Allowed to Do This, and You Are Mostly Not", placed at the split. `@maccallum2002` added to `references.bib` and confirmed resolving in the rendered HTML. Went slightly further than the item: the point is now also **planted in the new chapter opening** and **paid off twice more** (in the Cohen's *d* discussion, where the underpowered stay-in comparison is the concrete cost, and in The Short Story). Used the real number throughout: the filter keeps 81 of 200, so 119 students are discarded, not "120 or so".

### [CH17-P02] DV identity confusion (friends vs. closeness) — same sweep as CH16-P01
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → throughout (search anchors: "Predicted New Friends", "more friends than their equally disagreeable counterparts", "M_Friends")
- **Problem:** Same bug as Chapter 16 (which shares the dataset): the DV is a 0–100 closeness thermometer, but axis labels say "Predicted New Friends" and interpretations count friends ("about 25 more friends"). Notably the first-look plot and APA figure here already use "Friendship Closeness (0–100)" — so the chapter disagrees with itself panel to panel.
- **Fix:** Apply the CH16-P01 sweep to this chapter in the same pass (they must be fixed together since the story is shared). ~8 instances here.
- **Approved:** [x] — IMPLEMENTED 2026-08-16, identically to CH16-P01 and in the same session. `NewFriends` → `Closeness`, `M_Friends`/`SD_Friends` → `M_Close`/`SD_Close`, all four "Predicted New Friends" axis labels → "Predicted Closeness (0-100)", every "N more friends" → "N points". The two chapters now agree with each other and with themselves.

### [CH17-P03] "In regression (unlike ANOVA), unequal cell size is handled automatically" — slight strawman
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → "The Data" (search anchor: "this unequal cell size is handled automatically")
- **Problem:** ANOVA *is* regression under the hood; unequal n doesn't invalidate ANOVA — it makes the factors non-orthogonal, which is why the Type I/II/III sums-of-squares fight exists. As written, the sentence gives students a fuzzy "ANOVA can't do unequal n" meme they'll repeat to an ANOVA-loving professor and lose.
- **Fix:** Reword: "Unequal cells are no problem for the regression estimates. (Classic ANOVA arithmetic assumes balanced cells; with unequal n the ANOVA world descends into a fight about 'Types of sums of squares' that regression coefficients let you skip. If you ever meet Type III SS in the wild, that's what the fight was about.)" — which also quietly pays one installment of the preface's ANOVA promise.
- **Approved:** [x] — IMPLEMENTED 2026-08-16 using the drafted wording, with a forward pointer added ("we will see it happen later in this chapter") because CH17-U01 now makes it happen for real rather than leaving it as a parenthetical.

### [CH17-U01] The factorial-ANOVA bridge is asserted, never shown — and the preface promised an ANOVA cameo
- **Priority:** MED
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_CatXCat_Interaction.qmd → "Comparison" section (search anchor: "maps directly onto the two-way factorial ANOVA framework")
- **Problem:** The preface promises "ANOVA gets a brief appearance so you know what it is when someone inflicts it on you." With Chapter_Advanced_Contrasts_ANOVA.qmd commented out of the book, that appearance currently never happens — and this 2×2 chapter is its natural home. Students leaving 343 will meet "2×2 ANOVA, F(1, 76) = …" in every article they read; the book should show them, once, that it's the same model.
- **Fix:** Add a short section or collapsible callout "The ANOVA Costume": run `anova(Model.2)` (or `car::Anova` if Alex prefers — note the unequal-n caveat from CH17-P03), show the two main-effect Fs and the interaction F, and point out the interaction F here equals the t² of B3 from the regression. Three sentences of prose: "When a paper reports a 2×2 ANOVA, this is the table they mean. Same model, same data, same interaction test — regression just hands you the cell means and comparisons with less ceremony. Now you know what it is when someone inflicts it on you." (Coordinate with whether Advanced_Contrasts_ANOVA eventually ships; if it does, cross-reference instead of duplicating.)
- **Approved:** [x] — IMPLEMENTED 2026-08-16 as `## The ANOVA Costume`, placed before the Comparison section. Confirmed `Chapter_Advanced_Contrasts_ANOVA.qmd` is still commented out of `_quarto.yml`, so this is currently the book's only ANOVA appearance and the preface's promise is otherwise unpaid.
- **Verified, not asserted:** interaction $F = 126.9$ and $t_3^2 = 126.9$ render as the same number. An early draft would have missed by 0.01 because the `t3` already in scope is pre-rounded to 2 dp; the chunk now squares the unrounded *t*, with a comment saying why.
- **CORRECTED 2026-08-16, same day, on Alex's instruction: this section used Type II and should have used Type III.** He was right, and the reason is the whole point of the section: psychology's ANOVA tables are Type III, because SPSS `GLM` defaults to Type III and the discipline ran on SPSS for thirty years. Type II was the statistically tidier choice and the pedagogically wrong one, since a student reading a real paper is looking at Type III. The section now teaches all three types, says explicitly that Type III is what psychology uses and why, and keeps Type II only as the middle column of the comparison table.
- **Alex changed `type = 2` to `type = 3` in the code, which introduced two defects that had to be caught.** Recording both, because they will recur anywhere in this book that reaches for Type III:
  1. **`car::Anova(type = 3)` inserts an `(Intercept)` row**, so every positional index silently shifts by one. The inline values were pulling `[1]`, `[2]`, `[3]` and would have printed the Intercept's *F* as NiceGroup's, NiceGroup's as GoingOut's, and GoingOut's as the interaction's. Every number in the comparison table would have been wrong, and nothing would have errored. All indexing is now **by row name**, with a comment saying why.
  2. **Type III is invalid with R's default dummy coding.** `Model.2` uses `contr.treatment`, which is exactly what makes $B_1$ and $B_2$ readable as simple effects and is correct for the rest of the chapter. Ask `Anova(type = 3)` for main effects on that model and R answers without complaint, but the answers are not main effects: it returned $F = 2.27$ for NiceGroup and $F = 9.24$ for GoingOut, which are just $B_1^2$ and $B_2^2$, the simple-effect *t*-tests in disguise (verified: $t^2 = 2.27$ and $9.24$). Fixed by fitting `Model.2.sum` with `contr.sum` purely for the Type III table, leaving `Model.2` untouched so nothing else in the chapter moves. There is now a `callout-warning` teaching this trap, since it is the single most common way people get Type III wrong.
  - Correct values, verified: Type I / II / III are 174.70 / 139.83 / **175.40** for NiceGroup, 246.88 / 246.88 / **242.94** for GoingOut, and 126.90 in all three for the interaction.
  - **Note for the prose, which nearly got oversold:** Type I and Type III land close together here while Type II sits well below both. That ordering is a fact about this dataset, not a rule, and the text now says so rather than claiming the estimates "fan out".
- **Went beyond the item, deliberately: added the sums-of-squares section.** Because the cells are unequal, `anova()` (Type I) and `car::Anova(type = 2)` genuinely disagree here, and the disagreement is instructive rather than hypothetical: NiceGroup is $F = 174.7$ sequentially but $139.83$ under Type II, while GoingOut is $246.88$ under both (it was entered second, so it was already adjusted) and the interaction is $126.9$ under both. That turns CH17-P03's parenthetical into a demonstration the reader watches happen, and it lands on the preface's actual thesis about regression versus ANOVA. **Judgment call flagged for Alex:** this uses `car::` (namespaced, no new `library()` call, and `car` is already installed), which is a package the chapter did not previously touch. The item explicitly offered `car::Anova` as an option, so this is within scope, but it is worth a look.

### [CH17-U02] No Short Story
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → end (search anchor: "you have described two results but have not tested an interaction.")
- **Problem:** Covered by the cross-cutting recap item; raw material is the (excellent) closing callout plus the comparison table.
- **Fix:** Add `## The Short Story`: 2×2 = four cells, four coefficients; B0 = reference cell; B1/B2 = simple effects at the other variable's reference; B3 = difference of differences; follow up with `pairs()` within levels + Cohen's d; and the prior-chapter comparison table's punchline (continuous version uses all the data — prefer it when you can).
- **Approved:** [x] — IMPLEMENTED 2026-08-16. `## The Short Story` with six bullets, closing on the comparison table's punchline stated in the concrete: the cleaner 2 × 2 cost 119 of 200 students.

---

### [CH17-B01] Two numeric claims that the data contradict (found and fixed 2026-08-16)
- **Priority:** HIGH | **Effort:** S | **Perspective:** Professor
- Neither was in the original review. Both were caught by running the chapter's own code before writing about it.
- **(a) "Low Nice students have similar friendship scores whether they go out or not (both around 15)."** They are not both around 15. The cell means are **16.0 (stay in) and 22.6 (go out)**, and that gap is $B_2 = 6.65$, $p = .003$, which the chapter itself reports as significant two sections later. The sentence contradicted the chapter's own $B_2$ interpretation. Rewritten to give all four real cell means (about 16 and 23 for Low Nice, about 19 and 60 for High Nice) and to point out that the difference of differences is already visible in the raw means.
- **(b) "$d = 0.45$ — a negligible effect."** By Cohen's conventions 0.45 is small-to-medium, not negligible, and calling a non-significant result "negligible" conflates *not detected* with *not there*. Rewritten to separate the two claims and to make the underpowered stay-in cell ($n = 46$) the concrete cost of the dichotomization from CH17-P01. The go-out $d = 5.52$ was labelled "a large effect"; it is over five standard deviations, so the text now says so and warns that effects like this come from simulated data, not personality research.

### [CH17-U04] Contrast coding and designs beyond 2 × 2: pointer here, content in the advanced chapter
- **Priority:** MED | **Effort:** S here, L in the advanced chapter | **Perspective:** Professor
- **Alex's question, 2026-08-16:** should Ch17 gain an advanced section teaching ANOVA coding
  schemes and how to pass them into `lm()` via `contrasts`, plus a warning about designs
  bigger than 2 × 2? Or should that live in an advanced chapter with only a pointer here?
- **DECIDED: pointer here, content in the advanced chapter.** Agreed with Alex's own instinct,
  and there is a stronger reason than either of us had at the time: **`Chapter_Advanced_Contrasts_ANOVA.qmd`
  already exists.** It is 195 lines, titled "Advanced: Contrasts and ANOVA as Regression Wearing
  an Older Hat", and it is commented out of `_quarto.yml` rather than unwritten. It already has
  `## Dummy Coding`, `## Planned Contrasts`, `## Deviation or Effect Coding` (which already
  demonstrates `contrasts(x) <- contr.sum(3)`, exactly the mechanic Alex wanted taught), plus
  `## Contrast Weights Are a Hypothesis` and `## Estimability`. Its running example is a
  **three-level** factor, so it is already the natural home for the beyond-2 × 2 warning too.
  The job is finishing and un-commenting that chapter, not writing a new one.
- **Implemented here:** a `callout-note`, "Two Doors We Are Walking Past, On Purpose", placed
  immediately after the Type III section because that is where `contrasts = list(...)` appears
  and is otherwise handed to the reader unexplained. It names the two doors (coding schemes as
  a family; anything bigger than 2 × 2) and dismisses undergraduates explicitly.
- The beyond-2 × 2 warning is specific rather than vague, because the specifics are the point:
  a three-level factor enters as two columns, the interaction becomes $(a-1)(b-1)$ coefficients
  instead of one, there is no single "difference of differences" number to report, and
  follow-up comparisons need multiplicity control.
- **Deliberately no hyperlink**, because the target is commented out of `_quarto.yml` and a
  cross-reference to a chapter not in the book will not resolve. **When that chapter ships,
  turn the last line of the callout into a real link.**
- **Also check for duplication when it ships:** the advanced chapter has a `## Why $F=t^2$`
  section that overlaps with this chapter's "The ANOVA Costume". Ch17's version is the
  concrete one ($t^2 = 126.9 = F$ on real output) and should probably stay; the advanced
  chapter's should become the general proof. Note the advanced file also has a literal em-dash
  in that heading and has never been through the dash sweep, since it is not in the book.
- **Alex has offered his prior graduate lecture material for this.** It should go into
  `Chapter_Advanced_Contrasts_ANOVA.qmd`, and it is expansion material rather than a starting
  point. That chapter deserves its own session.

### [CH17-U03] IV/DV inventory and the quasi-experimental caveat (added and implemented 2026-08-16)
- **Priority:** MED | **Effort:** S | **Perspective:** Student + Professor
- **Alex's instruction**, covering Chapters 16 and 17 together: the chapters never say the
  designs are **between subjects**, never re-establish the **IV/DV** distinction now that
  there are two IVs, and never make the point that **regression does not care whether an IV
  was randomly assigned or merely observed** while the causal interpretation cares enormously.
- **Fix as implemented:** a parallel `callout-note` in each chapter, matching the structural
  parallelism the review asks future edits to preserve. Ch16 gets "Two IVs, One DV, and Nobody
  Measured Twice" after the study description; Ch17 gets "Same Two IVs, Same One DV, Still
  Nobody Measured Twice" after the 2 × 2 design table, written as a shorter callback.
- Both make the same three points: one DV and two IVs, with two IVs named as the precondition
  for an interaction existing at all; every student contributing exactly one row, with
  repeated measures pointed forward to a later chapter; and the causal point, made concrete
  by the fact that **neither IV in this study was assigned**. Nobody was randomised into
  being agreeable and nobody was sent to parties, so this is a quasi-experiment whose
  arithmetic is identical to an experiment's. Both callouts land on that: the design decides
  what you may conclude, the arithmetic never does.
- This also sets up Chapter 18 (Mixed Regression), where "nobody measured twice" stops being true.

---

**Global items that also apply here:** chapter YAML residue (this file also has the extra
`html:` block like Ch16); missing `fig-alt`.

**G01 status:** DONE 2026-08-16. YAML stripped to `title:` only, including the extra `html:` block.

**G02 status:** DONE 2026-08-16. All 5 figures carry `fig-alt`, and the four that had no
caption got one. Alt text written against computed cell means, not guessed.

**Em-dash sweep:** DONE 2026-08-16. **5.35 → 0.20 per 1000 words**, which is the floor.
This was the last outstanding chapter on the list. 21 dashes removed, cut per §14 to a
colon, comma, or full stop depending on what the second half was doing. `Chapter_Distro_Moments`
at 6.45 is now the only chapter above target, and it is Part 1 and finished.

**Opening:** Alex chose a light touch here rather than a full cold open, on the grounds that
this file's "what changes / what stays the same" scaffolding is deliberate (see Not flagged,
below). Only the recap paragraphs that used to open the chapter moved into second position,
under a new `## The Design Psychology Cannot Stop Running`. The scaffolding sections are
untouched.

**Not flagged (deliberate):** The "What changes / what stays the same" opening (ideal
scaffolding for a book that promises to stop re-explaining); both algebraic framings of the
difference-of-differences with the "which story you want to tell" guidance; `eff_size()`
with model sigma (correct, modern emmeans practice most instructors don't know); the
closing callout. The deliberate structural parallelism with Chapter 16 should be preserved
by any future edit — these two chapters teach as a matched pair.
