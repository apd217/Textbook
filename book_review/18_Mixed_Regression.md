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
- **Approved:** [x] — IMPLEMENTED 2026-08-16. **Then partly superseded by CH18-U04 below**, which
  cut the 2×4 design entirely, so several of the models this item converted no longer exist. What
  survives: `lmer()` + `lmerTest` is the engine, there is one short `glmmTMB` aside and no other
  mention, and the random-slope models left with the 2×4. Original note follows.
- All 7 `glmmTMB` calls were converted to `lmer()`; the file
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
**Decision: neither.** One chapter, staying last in Part 2.

### [CH18-U04] The altitude jump from 2 levels to a 2×4 with random slopes was too big
- **Priority:** HIGH
- **Perspective:** Student
- **Raised by:** Alex, 2026-08-16, after reading the first restructured draft
- **Problem:** In his words: *"this chapter jumps too fast in complexity... jumping from 2 level
  design to the 2x4 is too much of a jump."* The chapter went from a two-level within-subjects
  on-ramp straight to a 2×4 longitudinal design with correlated random intercepts and slopes.
- **Fix (implemented):** Pivot to a **mixed 2×2** instead: one within-subjects factor (Baseline
  vs Week 6) by one between-subjects factor (Control vs CBT), random intercept only. The 2×4,
  random slopes, continuous-versus-categorical time and `emtrends()` are all cut and left to the
  future mixed-models section.
- **Approved:** [x] — IMPLEMENTED 2026-08-16.
- **The pedagogical call turned out to be a mathematical one.** A random slope is **not
  estimable** with two occasions. `lmer` refuses outright: *"number of observations (=200) <=
  number of random effects (=200) for term (1 + week | participant); the random-effects
  parameters and the residual variance are probably unidentifiable."* Two points determine a
  line exactly, so there is nothing left to separate "this person changed fast" from "this
  measurement was noisy." This is now a `callout-warning` in the chapter, and it is a much
  stronger reason for the split than altitude alone.
- **The 2×2 pays off with a third exact identity**, which makes the chapter's spine three
  *t*-tests deep: the Occasion × Group interaction **is** an independent-samples *t*-test on the
  change scores. Verified: both give $t = -8.35423$, $df = 98$, $p = 4.42529 \times 10^{-13}$,
  estimate $= -5.75243$. So the chapter now shows the mixed model impersonating the paired *t*
  (Part 1) and then the independent *t* (Part 1) in the same file.
- **A fourth demonstration was added that no item asked for**, because the data handed it over:
  running the same 2×2 through `lm()` gives **identical estimates to every printed decimal** and
  badly wrong standard errors. The interaction SE goes from 0.69 to 1.75, and the Control change
  flips from $p < .001$ to $p = .121$. Same numbers, opposite conclusion, and the only difference
  is whether the model was told which rows share a human. This mirrors the paired-*t* chapter's
  "run it wrong on purpose" section deliberately. It also shows what the random intercept
  *cannot* do: the purely between-person coefficient `groupCBT` has the same SE in both models to
  nine decimal places, because there is no repeated measurement inside that comparison.
- **The residual plot now teaches instead of passing.** With a random intercept only, residuals
  are flat against fitted values at baseline ($r = .07$) and clearly trending at Week 6
  ($r = .39$). The cause was run down rather than guessed: it is the omitted random slope, since
  `person_slope` is in the simulation and has had six weeks to act by Week 6 and zero at
  baseline. Residuals correlate $.45$ with `person_slope × week`. **My first two attempts at this
  caption were both wrong** (I claimed the smoother was flat, then that it only wandered at the
  edges), and a shrinkage explanation was tested and rejected before the real one was found. The
  figure is now colored by occasion with a straight-line fit per occasion, and the prose says
  what the trend is and why the chapter cannot fix it.

### [CH18-U05] Check the Model rebuilt on DHARMa; the altitude warning Alex asked for
- **Priority:** HIGH
- **Perspective:** Student
- **Raised by:** Alex, 2026-08-16, after reading the 2×2 draft
- **Problem:** His words: *"check the model part is not exactly right... this is too high level
  section for undergrads and even first time grad students."* The section did bespoke
  residual-versus-fitted analysis and asked the reader to interpret it.
- **Fix (implemented):** Rebuilt on **DHARMa**: `simulateResiduals()` then `plotQQunif()` and
  `plotResiduals(form = occasion)`. Plus a `callout-warning` saying plainly that mixed models are
  an enormous area, that their diagnostics are a research area rather than a checklist, that two
  plots are the minimum and not the standard, and that the honest advice is a graduate course.
  It also tells the reader the material is hard and that struggling is the material's fault.
- **Approved:** [x] — IMPLEMENTED 2026-08-16.
- **Do not use `plot(sim_res)` on a 2×2.** With only four distinct fitted values DHARMa
  rank-transforms the predictions and labels the axis `0.145299145299145`. Call `plotQQunif()`
  and `plotResiduals()` separately so both panels are legible. This is why the chapter does it
  the long way; it is not a style preference.
- **DHARMa seeds internally**, verified by simulating twice and comparing, so the printed test
  values are stable across renders and safe to write prose about. Values: KS $p = .0541$,
  dispersion $p = .216$, outlier $p = .41647$, all `n.s.`
- **Alex then cut the interpretation of those tests** and replaced it with "ignore them for now",
  and cut the list of things the section skips. Both deliberate: he is protecting the altitude.
  The plot still prints the three *p*-values, so the text now shows numbers and says to ignore
  them, which is his call and is consistent with the hand-waving register of the REML callout.
- **Also his instruction:** "When Two Occasions Are Not Enough" became **"When Your Design
  Outgrows This Chapter"**, carrying his concession that for balanced complete designs with
  several within-subjects factors, old-school RM ANOVA is genuinely *easier* than the mixed
  model, with the price named (complete data, and sphericity, which is vacuous at two occasions
  and real from three up).

### [CH18-F01] Link the RM ANOVA lecture when it ships
- **Priority:** MED
- **Perspective:** Publisher
- **Status:** OPEN, waiting on Alex's file
- Alex said he would put his repeated-measures ANOVA lecture into the advanced section. The last
  paragraph of `Chapter_Mixed_Regression.qmd` already says "there is a review of it in the
  advanced sections of this book" **with no hyperlink, on purpose**, because the chapter does not
  exist yet and CH18-P01 in this same chapter was exactly that bug. **Add the link when it
  ships.** Alex deleted the in-file `---Alex---` reminder, so this item is now the only record.

### [CH18-DUP01] `Chapter_Mixed_Designs.qmd` overlaps this chapter and is uncommitted
- **Priority:** HIGH
- **Perspective:** Publisher
- **Status:** FLAGGED FOR ALEX, not resolved
- **Problem:** The working-tree copy of `Chapter_Mixed_Designs.qmd` (commented out of
  `_quarto.yml`) contains **the same structure this chapter now has**: a chocolate paired-*t*
  on-ramp using the identical `set.seed(343)` simulation, a "Mixed 2-by-2: Week 0 vs. Week 6"
  section, and an Advanced Topics half holding the 2×4. If both ever ship, the book runs the same
  on-ramp twice and carries two different CBT studies (`seed 346 / n = 96 / Symptoms / Therapy`
  versus this chapter's `seed 3436 / n = 100 / depression / CBT`).
- **Its provenance is unexplained.** The committed version is a different, shorter chapter titled
  "Advanced Mixed Models III". The working-tree version is **uncommitted**, has an mtime of
  2026-08-17 00:02, which is *after* the 23:28 Ch18 commit, and reuses sentences written for Ch18
  that day verbatim ("Those are not two answers that happen to agree. They are one answer,
  printed twice."). It was not written by this session.
- **Alex chose to merge into `Chapter_Mixed_Regression.qmd`** rather than adopt it, so this
  chapter borrowed two things from it deliberately: the CatXCat bridge table and the
  change-score identity. **The file itself was left untouched and uncommitted.** It still needs a
  decision, and because it is not in git it could be lost.

**Not flagged (deliberate):** The spaghetti-plot-with-group-means figure ("group averages
sitting on top of actual humans" is the correct religion); the REML/ML switching rule stated
plainly; the missing-data section's MAR honesty; "they are humans, not synchronized microwave
clocks"; the Short Story's "count people, not rows" closer. The statistical care here exceeds
most published tutorials — the fixes are about audience and tooling, not correctness.
