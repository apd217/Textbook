# Chapter 18 — Mixed Regression: Between People and Within People (Chapter_Mixed_Regression.qmd)

**Snapshot:** ~2,300 words. Statistically the most careful chapter in the book — honest about
Wald z approximations, REML vs. ML for fixed-effect comparisons, missing-data assumptions,
and the sphericity trade. But it has the book's second-worst curriculum collision: **the 343
labs teach `lmer()` from lme4; this chapter teaches `glmmTMB`** — and it skips the Week 10
on-ramp entirely (2-level within-subjects predictor + random intercept ≡ paired t), jumping
straight to a longitudinal random-slopes design. As the *only* active mixed-models chapter,
it currently serves Week 10 students a graduate seminar.

---

### [CH18-U01] The labs use `lmer()`; the book uses `glmmTMB` — students can't reconcile the outputs
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_Mixed_Regression.qmd → "Random Intercepts" (search anchor: "glmmTMB::glmmTMB(")
- **Problem:** The curriculum names the tool three times: Week 10 ("run a within-subjects regression in R using lmer() from the lme4 package"), Week 12 (lmer for within-subjects interactions), Week 13 ("full factorial lmer() model"). Homework and TA materials will all be lmer. The book's only mixed chapter never shows `lmer()` — it uses glmmTMB, whose output differs visibly (z instead of t, no df, different summary layout). A student comparing their lab output to the book will conclude one of them is wrong. glmmTMB is a defensible expert choice, but this book is the course text for a standardized multi-section course.
- **Fix:** Make `lmer()` (lme4 + lmerTest for p-values) the primary engine in this chapter: same models, `lmer(depression ~ week * group + (1 + week | participant), data = mixed_data)`, with lmerTest's Satterthwaite t-tests, which also match what students expect (t and df, like every other chapter). Keep glmmTMB as a clearly labeled aside ("another engine you'll meet in grad school; same model, different plumbing, z instead of t") or move the glmmTMB treatment to the draft Mixed_Inference chapter where the estimation discussion belongs. The current text's careful Wald-z caveats become a short callout about *why* mixed-model p-values are approximations regardless of engine. Verify all inline values after the swap.
- **Approved:** [x]
- **DECIDED BY ALEX, 2026-08-16:** *"I think I want to go back to LMER for this chapter to keep
  it easier."* So this is settled: **`lmer()` becomes the primary engine.** No need to weigh it
  up again, and no need to preserve glmmTMB's prominence.
- **How to read "to keep it easier."** He is optimising for the undergraduate reading the
  chapter, not for engine coverage. Default to the item's own recommendation, biased simple:
  `lmer()` + `lmerTest` throughout, Satterthwaite *t* and df so the output looks like every
  other chapter in the book; glmmTMB reduced to **at most** a short labelled aside ("another
  engine you will meet in graduate school, same model, different plumbing, *z* instead of *t*")
  or dropped from this chapter entirely and left to `Chapter_Mixed_Inference.qmd`, which is
  where the estimation discussion belongs and which is currently commented out anyway. If you
  find yourself writing a long glmmTMB comparison, you have misread the instruction.
- The chapter's careful Wald-*z* caveats should not be deleted, they should shrink into one
  callout about *why* mixed-model *p*-values are approximations regardless of engine. That
  statistical care is listed under "Not flagged (deliberate)" at the bottom of this file and is
  the chapter's best quality.
- **There are 7 `glmmTMB` calls.** Every one of them changes the printed output, so every
  inline number and every sentence describing output is in scope. `z` becomes `t`, and df
  appear where there were none. Grep the chapter for "z" in prose after the swap.

### [CH18-U02] Week 10's actual lesson is missing: 2-level within-subjects predictor ≡ paired t, shown in lmer
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_Mixed_Regression.qmd → before "The Design" (search anchor: "## The Design")
- **Problem:** Week 10's lab: "TA compares the lmer() output to the paired t-test output from 242: same t-value, same p-value, just presented differently. Discussion: What is a random intercept, and why do we need it?" The book never does this anywhere. The paired-t chapter ends by routing readers here; this chapter's first model is already a 2×4 longitudinal design with random slopes. The single most important on-ramp — *your paired t-test was secretly a mixed model* — is skipped, and it's the one thing every 343 student must do for homework.
- **Fix:** Add an opening section "Your Paired t-Test Was a Mixed Model All Along": reuse the chocolate-fixation data from the paired-t chapter (same simulation code, seed 343 — continuity is free), fit `lmer(fixation ~ condition + (1 | participant), data = paired_long)`, and put its condition t-value side by side with the paired t-test's t — identical. Three paragraphs: (1) the random intercept is each person's own baseline, which is what "each person is their own control" means in equation form; (2) fixed effect = the average chocolate effect, the thing the t-test tested; (3) why this scales where difference scores can't (3+ occasions, missing rows, between-person predictors) — which hands off to the CBT design that currently opens the chapter. ~350 words + 2 chunks.
- **Approved:** [x]
- **VERIFIED 2026-08-16, before implementation, at the end of the 16+17 session.** The item's
  central claim is true and the identity is exact, so the section can be built on it. Details
  confirmed by running it: the paired-t chapter uses `set.seed(343)`, `n <- 48`, and the object
  names `paired_wide` / `paired_long` that this item assumes, with `condition` factor levels
  labelled "No chocolate" and "Chocolate". Fitting
  `lmer(fixation ~ condition + (1 | participant), data = paired_long)` against
  `t.test(paired_wide$chocolate, paired_wide$no_chocolate, paired = TRUE)` gives **the same
  numbers to six decimals**: $t = 4.336614$, $df = 47$ (Satterthwaite), $p = 7.5972 \times 10^{-5}$,
  estimate $= 0.78524$. The estimate is the mean *difference*, i.e. the chocolate effect in
  seconds of fixation. `lme4`, `lmerTest`, `glmmTMB` and `emmeans` are all installed.
  **Re-run before writing prose anyway.** Three separate items in this review turned out to be
  wrong about their own numbers; this one is right, which is why it is worth recording that it
  was checked rather than trusted.
- Note `Chapter_Paired_t_test.qmd:317` already links here, so this section lands exactly where
  a reader following that pointer arrives.

### [CH18-P01] Broken forward reference: "the later inference chapter" is commented out of the book
- **Priority:** MED
- **Perspective:** Professor + Publisher
- **Effort:** S
- **Location:** Chapter_Mixed_Regression.qmd → "Read the Model Without Panic" (search anchor: "the later inference chapter shows the deliberate `lmerTest` detour")
- **Problem:** The text promises a "later inference chapter" (Chapter_Mixed_Inference.qmd), which is commented out of `_quarto.yml`. Web readers get a promise pointing at nothing. (Same class of problem to watch for book-wide: references into the disabled draft chapters.)
- **Fix:** If CH18-U01 is adopted, this sentence largely dissolves (lmerTest becomes the main path). Otherwise reword to "a future chapter (in progress)" or drop the pointer. Also grep all active chapters for links to commented-out chapters (Mixed_Foundations, Mixed_Inference, GLM, Mediation, EFA…) and neutralize each — logged as a cross-cutting item too.
- **Approved:** [ x]

### [CH18-U03] Consider a gentler altitude profile: label the second half "Advanced"
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Mixed_Regression.qmd → "Should Time Be Continuous or Categorical?" (search anchor: "## Should Time Be Continuous or Categorical?")
- **Problem:** For the undergrad who needs Week 10–13 survival, the essential content ends after "Follow Up the Interaction." The remaining sections (continuous vs. categorical time, missing data, model checking) are genuinely valuable grad-prep — the Power chapter solved this exact problem with an explicit unnumbered "Advanced Topics" break, and this chapter should use the same device rather than an opening "Advanced Chapter" banner that scares off the students who *must* read the first half.
- **Fix:** (1) Soften the opening callout: this chapter starts where the paired t ends, and the first half is required 343 material; the second half is labeled. (2) Insert the `# Advanced Topics {.unnumbered}` break (Power-chapter style) before "Should Time Be Continuous or Categorical?". (3) Move the Short Story to just before the break OR keep at end but have the break note say "the Short Story at the end covers everything."
- **Approved:** [ x]

### [CH18-P02] "28 tests and a dead salmon" — link it
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Mixed_Regression.qmd → "Follow Up the Interaction" (search anchor: "28 tests and a dead salmon")
- **Problem:** Second salmon reference in the book (first in Probability). If CH03-P01 (cite Bennett et al., cross-ref the Multiple Comparisons chapter) is approved, this one should link to the same places so the running gag doubles as navigation.
- **Fix:** Add cross-reference to Chapter_Multiple_Comparisons.qmd and the Bennett citation here too.
- **Approved:** [ x]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Ordering note (for 00_OVERVIEW):** The curriculum needs this chapter's first half *before*
the interaction chapters (Week 10 precedes Weeks 11–13), but the book currently places it
last in Part 2. Recommendation discussed in the overview: either move it before
Interaction_1, or split — the new paired-t-≡-lmer on-ramp (CH18-U02) could live at
Part 2's Week-10 position while the CBT longitudinal material stays put as the advanced
finale. The second option preserves this chapter's excellent arc.

**Not flagged (deliberate):** The spaghetti-plot-with-group-means figure ("group averages
sitting on top of actual humans" is the correct religion); the REML/ML switching rule stated
plainly; the missing-data section's MAR honesty; "they are humans, not synchronized microwave
clocks"; the Short Story's "count people, not rows" closer. The statistical care here exceeds
most published tutorials — the fixes are about audience and tooling, not correctness.
