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
- **Approved:** [x] — IMPLEMENTED 2026-08-16. All 7 `glmmTMB` calls are now `lmer()`; the file
  contains exactly one `glmmTMB` mention, a two-sentence aside inside the new *p*-value callout.
  Every number re-derived from the new fits. **Two defects found by running it that the item did
  not know about:** (a) the prose said "suppose the interaction estimate is about $-1.2$", which
  was the *generating* value in the simulation, not the fitted one, which is $-1.03$; it is now
  inline-computed. (b) `lmer` throws a convergence warning on the categorical-time model that
  `glmmTMB` did not (`max|grad| = 0.0028`, tol `0.002`); fixed with
  `control = lmerControl(optimizer = "bobyqa")`, which converges and agrees with the default fit
  to 3 dp, and the fix is explained in a callout rather than hidden.
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
- **Approved:** [x] — IMPLEMENTED 2026-08-16, and **expanded into the chapter's cold open** with
  Alex's approval mid-session. It is no longer a section before "The Design"; it is the opening
  of the chapter, because it is the identity payoff VOICE_GUIDE §17 calls the strongest move and
  the old opening failed §15 (definition callout plus recap). Numbers re-run before writing:
  $t = 4.33661$, $df = 47$, $p = 7.59724 \times 10^{-5}$, estimate $= 0.78524$, matching in every
  column at 6 significant digits. Went beyond the item's three paragraphs in one place: the ICC
  is computed ($.45$) and connected back to the paired-*t* chapter's $-2rS_1S_2$ term, whose
  sample $r$ is $.46$. **Those two are close but not equal** and the prose says so, because they
  are two estimates of the same quantity rather than one identity.
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
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Dissolved exactly as predicted: `lmerTest` is now
  the main path, so the whole sentence containing the pointer was replaced by the *p*-value
  callout. **The book-wide grep is clean.** The only link from any chapter into a commented-out
  chapter is `Chapter_Mediation.qmd:288` → `Chapter_Moderated_Mediation.qmd`, and Mediation is
  itself commented out of `_quarto.yml`, so no reader can reach it. Nothing to neutralize.

### [CH18-U03] Consider a gentler altitude profile: label the second half "Advanced"
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Mixed_Regression.qmd → "Should Time Be Continuous or Categorical?" (search anchor: "## Should Time Be Continuous or Categorical?")
- **Problem:** For the undergrad who needs Week 10–13 survival, the essential content ends after "Follow Up the Interaction." The remaining sections (continuous vs. categorical time, missing data, model checking) are genuinely valuable grad-prep — the Power chapter solved this exact problem with an explicit unnumbered "Advanced Topics" break, and this chapter should use the same device rather than an opening "Advanced Chapter" banner that scares off the students who *must* read the first half.
- **Fix:** (1) Soften the opening callout: this chapter starts where the paired t ends, and the first half is required 343 material; the second half is labeled. (2) Insert the `# Advanced Topics {.unnumbered}` break (Power-chapter style) before "Should Time Be Continuous or Categorical?". (3) Move the Short Story to just before the break OR keep at end but have the break note say "the Short Story at the end covers everything."
- **Approved:** [x] — IMPLEMENTED 2026-08-16, all three parts. (1) The "Advanced Chapter" banner
  is gone. Its definition and its "all its relatives / provide chairs" joke moved into a
  `callout-note` titled "Where This Chapter Gets Harder, and Where It Does Not", which now sits
  *after* the cold open instead of before everything. (2) `# Advanced Topics {.unnumbered}`
  inserted before "Should Time Be Continuous or Categorical?". (3) Short Story stayed at the end;
  both the callout and the break note say so explicitly.

### [CH18-P02] "28 tests and a dead salmon" — link it
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Mixed_Regression.qmd → "Follow Up the Interaction" (search anchor: "28 tests and a dead salmon")
- **Problem:** Second salmon reference in the book (first in Probability). If CH03-P01 (cite Bennett et al., cross-ref the Multiple Comparisons chapter) is approved, this one should link to the same places so the running gag doubles as navigation.
- **Fix:** Add cross-reference to Chapter_Multiple_Comparisons.qmd and the Bennett citation here too.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. "a dead salmon" now links to
  `Chapter_Multiple_Comparisons.qmd` and carries `[@bennett2010]`. Both verified in the rendered
  HTML: the link resolves to `./Chapter_Multiple_Comparisons.html` and the citation renders as
  "Bennett et al. 2010" with a reference-list entry.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.
**Both done 2026-08-16.** G01: `geometry`, `fontsize` and the whole dead `format: pdf:` block
stripped, leaving only `title`. G02: the chapter had **zero** `fig-alt` *and* zero `fig-cap`;
both figures now have both. The alt text was written against the rendered PNGs, not the code,
which caught a wrong claim: the diagnostic plot's loess smoother is *not* flat, it droops to
about $-1.3$ at the far left, where exactly two observations live. The caption, the alt text and
a new sentence of prose all say so now, because a caption asserting a flat line over a figure
showing a bent one is worse than no caption.
**Also swept:** em-dash density, **3.22 to 0.31** (three dashes, all in Alex's own prose,
recut to commas). Render-safety check reports no PDF-breaking characters.

**Ordering note (for 00_OVERVIEW): ANSWERED BY ALEX, 2026-08-16.** The question was whether to
move this chapter earlier or split it so the Week-10 material sits at its curriculum position.
**Decision: neither, for now.** One chapter, staying last in Part 2, with the CH18-U02 on-ramp
written as a self-contained opening section that could be **lifted into its own chapter later
without a rewrite**. Moving the whole chapter earlier was considered and rejected on a
dependency: Week × Group *is* a continuous-by-categorical interaction, which is Interaction_1's
material, so the CBT half would lean on vocabulary the reader has not met. If the split ever
happens, everything from "Your Paired *t*-Test Was a Mixed Model All Along" through the
"Where This Chapter Gets Harder" callout is the piece that moves, and Ch18 would then need a
new cold open.

**Not flagged (deliberate):** The spaghetti-plot-with-group-means figure ("group averages
sitting on top of actual humans" is the correct religion); the REML/ML switching rule stated
plainly; the missing-data section's MAR honesty; "they are humans, not synchronized microwave
clocks"; the Short Story's "count people, not rows" closer. The statistical care here exceeds
most published tutorials — the fixes are about audience and tooling, not correctness.
