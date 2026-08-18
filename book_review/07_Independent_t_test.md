# Chapter 7 — Independent Samples t-Test (Ch_08_Independent_t.qmd)

**Snapshot:** ~950 words — the leanest core chapter, which mostly works because Chapter 6
built the hypothesis-testing machinery. The CTA storyline continuing from the Standard Error
chapter is excellent narrative economy. But this chapter has the book's sharpest
**book-vs-lab mismatch**: the curriculum teaches the pooled test with
`t.test(y ~ group, var.equal = TRUE)` and hand-computed pooled SE, while the book leads
Welch-first with vector syntax (`x=`, `y=`) and mocks equal-variance assumptions as "ancient
ritual." Welch *is* the better default — but the book is the standardized text for a
multi-section course whose labs and exams do the pooled version. Students will notice their
book and their lab disagree.

---

### [CH07-U01] Book teaches Welch + vector syntax; the lab teaches pooled + formula syntax
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Ch_08_Independent_t.qmd → Step 4 (search anchor: "CTA.t.test <- t.test(x = CTA.Experimental,")
- **Problem:** 242 Week 11 lab: students verify a hand-computed pooled t against `t.test(outcome ~ group, data = df, var.equal = TRUE)`. The book: (a) never shows formula syntax, though the data frame `CTA.df` is literally built two steps later for the plot — the natural `t.test(Liking ~ Condition, data = CTA.df)` is sitting right there; (b) never runs `var.equal = TRUE`, so a student can't reproduce their lab's numbers from the book's example; (c) the hand-formulas shown (pooled SE, pooled df) belong to the test the book *doesn't run* — the displayed formulas and the displayed output don't correspond.
- **Fix:** Restructure Steps 3–4 to run both, in lab-compatible syntax: (1) build `CTA.df` first (move the data-frame chunk up); (2) run `t.test(Liking ~ Condition, data = CTA.df, var.equal = TRUE)` labeled "the classical (pooled) test — this matches your hand calculation and your lab"; (3) run the same call without `var.equal` labeled "Welch — R's default, and the better habit"; (4) show the outputs side by side and note the df change (58 vs. Welch's fractional df) in one sentence. Keep the "ancient ritual" joke but aim it correctly: the ritual isn't *computing* the pooled test (the lab does that to show the machinery), it's *forcing* equal variances in real research when you don't have to.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. `CTA.df` moved up into Step 2; both tests now run in formula syntax (`Liking ~ Condition`), pooled first labeled as matching the hand calculation and the lab, then Welch. **Found a trap while doing it:** the two `Condition` levels sort alphabetically, so Control becomes group 1 and the formula version returns $t = -10.21$ where the old vector call returned $+10.21$. That would have silently inverted the sign of every downstream number including the APA paragraph. Fixed by explicitly setting factor levels with Experimental first, matching how Step 1 already defines $\mu_1$ and $\mu_2$, with a code comment saying why. Also verified and stated a nice fact: with equal n the pooled and Welch $t$ are *identical* here (10.2133); only df differs (58 vs 57.09). Side-by-side sentence uses inline values.

### [CH07-U02] No assumptions section — the curriculum names them, the exam will too
- **Priority:** HIGH
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Ch_08_Independent_t.qmd → after Step 4 (search anchor: "we should not force equal variances merely because an ancient statistics ritual")
- **Problem:** Week 11 Class 1–2 teach: independence of observations (why each participant's data must not influence another's), random assignment as what makes groups comparable, normality, and homogeneity of variance. The chapter covers homogeneity implicitly (via Welch) and skips the rest entirely. Independence is the assumption that actually kills studies (friends recruited together, classroom clusters) and it never appears. There's also no mention of random assignment — the thing that licenses the causal reading of this design.
- **Fix:** Add a compact section `## What This Test Assumes` (~200 words + no code): (1) **Independence** — each rider answers alone; if you survey five friends traveling together, you have one opinion wearing five coats (and this assumption's violation is the reason mixed models exist — one-sentence forward pointer to the within-subjects/lmer chapter); (2) **Random assignment** — the reason the groups are comparable at baseline is that chance built them, so the 7-minute schedule is the only systematic difference; without it you have a quasi-experiment and weaker causal claims; (3) **Normality-ish** — with n=30 per group the CLT does heavy lifting; look at the histograms anyway; (4) **Equal variances** — only if you use the pooled test; Welch shrugs.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. New `## What This Test Assumes` section placed after Step 4, before the visual reporting step. Four assumptions, ~230 words, no code, ordered by how dangerous they are rather than by tradition. Independence gets the most space and reuses the "one opinion wearing five coats" image from the voice guide, closing with a forward pointer to mixed models. Random assignment is framed as the thing that licenses the causal sentence. Normality notes the CLT is doing the work at n = 30. Equal variances is one line ending in "Welch shrugs."

### [CH07-U03] Formulas are shown but never computed by hand — breaking the Ch6 pattern the lab depends on
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_08_Independent_t.qmd → Step 3–4 (search anchor: "S^2_p =  \\frac{SS_1 + SS_2}{df_1 + df_2}")
- **Problem:** Chapter 6 computes t by hand and then verifies with `t.test()` — the exact workflow of the Week 11 lab. This chapter displays three formulas and then hands everything to R. The one hand-calculation present (Cohen's d, Step 7) proves the pattern works here. A student practicing for the "compute pooled SE by hand" lab gets no worked model.
- **Fix:** Add a short visible chunk between the formulas and `t.test()`: compute `SS1`, `SS2`, `Sp2`, `SE_pooled`, and `t_by_hand <- (M1 - M2) / SE_pooled` (~6 lines, reusing M1/M2/S1/S2 — note they're currently defined in Step 7; move those four lines up here). Then the `var.equal = TRUE` output (per CH07-U01) confirms the hand value. One sentence: "Same number. The machine just types faster."
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. Visible chunk added between the formulas and `t.test()` computing `SS1`, `SS2`, `Sp2`, `SE_pooled`, and `t_by_hand`. `M1`/`M2`/`S1`/`S2` moved up here from Step 7 as the item specified, so Step 7 now just takes `sqrt(Sp2)` instead of recomputing the pooled variance a second way. Verified the hand value equals `var.equal = TRUE` exactly (10.2133). Closing line is the drafted "Same number. The machine just types faster."

### [CH07-U04] Two stacked histograms invite a comparison they make hard
- **Priority:** LOW
- **Perspective:** Student + Publisher
- **Effort:** S
- **Location:** Ch_08_Independent_t.qmd → Step 2 (search anchor: "hist(CTA.Control, xlab=\"CTA Liking (1-7)\"")
- **Problem:** The two base-R histograms share an xlim but render as two separate full-width figures, so the "already you should see separation" claim asks the reader to hold one distribution in memory while scrolling. An overlaid or faceted plot makes the separation self-evident — and this is the book's first two-group comparison, the picture that defines what "a group difference" looks like.
- **Fix:** Replace with a single figure: either `par(mfrow=c(2,1))` with shared axes (minimal change) or one ggplot with `fill = Condition`, `alpha = 0.5`, overlaid histograms/densities using the `CTA.df` data frame (which CH07-U01 moves up anyway). Keep the "eyeballing is not a test" line — it's the right caution.
- **Approved:** [X ] — IMPLEMENTED 2026-08-14 (approved mid-session). Replaced the two base-R histograms with one ggplot: overlaid histograms on a shared axis, `position = "identity"`, `alpha = 0.5`, filled by Condition, using the `CTA.df` that CH07-U01 moved up. Kept the "eyeballing is not a test" line and added one sentence pointing at the overlap band, since this is the book's first two-group comparison and "the piles sit in different places" is the idea worth planting. Colors chosen to stay distinguishable in greyscale for the PDF.

### [CH07-B01] Bar-plot-with-error-bars: add the raw dots
- **Priority:** LOW
- **Perspective:** Publisher + Professor
- **Effort:** S
- **Location:** Ch_08_Independent_t.qmd → Step 5 (search anchor: "add = \"mean_ci\"")
- **Problem:** The mean+CI bar plot ("dynamite plot") is the standard psych figure, and teaching it is defensible — but it hides distributions, and this book everywhere else preaches "look at the data." ggpubr makes the fix one argument.
- **Fix:** Change to `add = c("mean_ci", "jitter")` (or `add = c("mean_ci", "dotplot")`), so raw ratings show through the bars, with one caption sentence: "The bars are the summary; the dots are the humans." Keeps the APA-familiar form and models the better habit.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. `add = c("mean_ci", "jitter")` plus the drafted caption. One extra fix beyond the item: with `palette = "grey"` the Control bar rendered near-black and swallowed its own black dots, so the palette is now `c("grey80", "grey60")`. Checked the rendered figure to confirm the dots are visible on both bars.

### [CH07-P01] Cohen's d uses pooled SD next to a Welch test — fine, but say so; and give grads the Glass's Δ pointer
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_08_Independent_t.qmd → Step 7 (search anchor: "Sp <- sqrt(((n-1)*S1^2 + (n-1)*S2^2) / (2*n - 2))")
- **Problem:** Reporting pooled-SD d alongside a Welch test is standard practice, but the chapter just did a paragraph on *not* assuming equal variances and then silently pools them for the effect size. A sharp student will catch the tension; a grad student needs one more sentence (when variances differ substantially, standardizing by the control group's SD — Glass's Δ — answers a cleaner question).
- **Fix:** Add two sentences after the d calculation: "Yes, we just pooled the variances for d right after refusing to pool them for the test. The effect size is descriptive — pooling gives a reasonable yardstick when the spreads are similar, as here. If the spreads are very different, standardize by the control group's SD instead (Glass's Δ) — CCAW discusses when this matters." 
- **Approved:** [ x] — IMPLEMENTED 2026-08-14 as a `callout-note` ("Yes, We Just Pooled the Variances We Refused to Pool") rather than two bare sentences, so the tension is named in the title instead of buried. Says why the two numbers have different jobs (inference protects itself, description just needs a yardstick), shows the two SDs inline so the reader can check "as here" is true, and gives Glass's $\Delta$ with the question it actually answers. Dropped the CCAW reference since the item's drafted text pointed at material outside this book.

### [CH07-U05] Missing end-of-chapter recap and routing
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_08_Independent_t.qmd → end (search anchor: "The p-value cannot tell the reader how far apart the groups are.")
- **Problem:** Chapter 6 ends with both a Short Story and a "Which t-Test Comes Next?" routing callout; this chapter ends on a callout with neither. The paired-t chapter is next and the natural router ("what if the same person rides both schedules?") writes itself. Also fix the Step 2 heading typo "## Step 2: collect the Data" → "Collect".
- **Fix:** Add `## The Short Story` (5 bullets: two groups → difference of means over SE of the difference; Welch default; random assignment carries the causal load; d in pooled-SD units; CI + effect size beat a lone p) and a short routing callout: same-people-twice → paired t-test chapter; more than two groups or continuous predictors → regression is coming for you in Part 2. Fix the heading capitalization while in the file.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. Added `## The Short Story` (5 bullets, including one on formula-syntax level order, since that is the trap CH07-U01 exposed) and a "Which Test Comes Next?" callout routing to the paired-t chapter and forward to regression. Fixed the Step 2 heading capitalization.

---

**Also done in this pass (approved global items):**

- **G01** (YAML strip): reduced to `title:` only; setup consolidated into one `opts_chunk$set()`.
- **G02** (fig-alt): both figures carry `fig-cap` and `fig-alt`; all chunks named.
- **G05** (code visibility): the Step 2 data-generation chunk is now echoed, per the note in this file's globals section. Two `rnorm()` calls are the whole experiment and were hidden.

**Em-dash discipline (Alex's standing request):** no em-dashes introduced in any of the new prose, including the assumptions section, the Glass's delta callout, the Short Story, and the routing callout.

---

**Global items that also apply here:** chapter YAML residue; `fig-alt`; code-visibility
(this chapter's global `echo=FALSE` is overridden per-chunk where it matters, so it's mostly
fine — but the Step 2 data-generation chunk should be visible for the same reason as CH05-U01:
`rnorm(n, 3, 1)` twice IS the design).

**Not flagged (deliberate):** Chapter brevity — do not fatten this into Chapter 6's length;
the additions above total ~400 words and one section. The "declined our invitation to be
manipulated with set.seed(343)" line and the February bus-stop aside are keepers. Leading
with Welch as the *recommended* test is correct statistics — the fix is bridging to the lab's
pooled version, not demoting Welch.
