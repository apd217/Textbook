# Chapter 13 — Multiple Regression: Statistical Control (Chapter_Multiple_Regression_Control.qmd)

**Snapshot:** ~4,750 words. Excellent chapter — the three-model progression (each predictor
alone, then together), the Ballantine with a numeric region breakdown, the "same anxiety
level" plain-language slope interpretations, and a fully inline-computed APA write-up. This
is the chapter that teaches the book's central intellectual move (conditional slopes), and it
mostly nails it. Findings are refinements, plus one wrong word doing real damage.

---

### [CH13-P01] "The controlled slope is more precise" — wrong word, contradicts the chapter's own care
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Multiple_Regression_Control.qmd → "The Study Hours Slope — Before and After Controlling" (search anchor: "The controlled slope is more precise")
- **Problem:** The chapter is scrupulously careful everywhere else ("not automatically 'truer,' more causal, or less biased"). Then this sentence calls the controlled slope "more precise — it captures only what studying contributes, independent of anxiety." Precision means standard error, and controlled slopes routinely have *larger* SEs than bivariate ones (collinearity inflates them — the very topic of the diagnostics chapter's VIF section). A grad student who absorbs "controlling = more precise" has learned the opposite of the truth about estimation variance.
- **Fix:** Replace with the chapter's own established framing: "The controlled slope answers the conditional question — what studying is associated with among students at the same anxiety level. It is not more 'precise' (its standard error is actually a bit larger — sharing variance costs information); it is an answer to a different, often more useful, question."
- **Approved:** [ x] — IMPLEMENTED 2026-08-15 using the item's framing, split into three short paragraphs because the replacement carries more load than the one sentence it replaces. **Verified the SE claim before writing it** rather than trusting the item: on these predictors the Study Hours SE goes from 0.0902 bivariate to 0.0926 controlled, so "slightly larger" is accurate here. I hedged the general statement to "that is the normal pattern," because the net direction is not guaranteed in principle: adding a predictor both inflates the SE through collinearity and shrinks it through reduced residual variance, and which wins depends on the data. Points forward to variance inflation in the diagnostics chapter. Flagged in-file.

### [CH13-U01] No "Short Story" recap on the book's most conceptually important chapter
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Multiple_Regression_Control.qmd → end (search anchor: "No new imaginary undergraduates will be recruited")
- **Problem:** The chapter ends with the APA write-up and a (very good) routing callout, but no Short Story — and this is the chapter whose one-liners students most need to retain ("a slope in multiple regression carries an invisible 'holding the others constant' clause"). Covered by the cross-cutting recap item, but flagged individually because the recap content here is unusually valuable.
- **Fix:** Add `## The Short Story` before the routing callout: (1) one predictor is never enough because predictors correlate; (2) a multiple-regression slope = unique association, holding the other predictors constant; (3) slopes can shrink, grow, or flip when controls enter — each model answers a different question; (4) R²'s don't add because shared variance (region c) only counts once; (5) adjusted R² charges rent for extra predictors; (6) control is statistical, not causal — design still decides.
- **Approved:** [x ] — IMPLEMENTED 2026-08-15, all six bullets, placed before the routing callout so the callout still closes the chapter. Bullet 2 carries the line the item singled out, that every multiple-regression slope has an invisible "holding the others constant" clause, with the added instruction to read it aloud every time. Bullet 5 explains *why* adjusted $R^2$ can fall, which the chapter demonstrates but never states in one line.

### [CH13-U02] The sjPlot code is hidden — but sjPlot is a named lab tool
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Multiple_Regression_Control.qmd → visualization chunks (search anchor: "plot_model(") 
- **Problem:** All five `plot_model()` chunks are hidden (global `echo=FALSE`, no per-chunk override). The 343 curriculum names sjPlot as the visualization tool students must use for their homework ("visualize in sjPlot", Week 11 HW). This chapter is where `plot_model()` first appears in the book — hiding its code means students meet the tool in lab with no book reference. The calls are short and readable; they're exactly the kind of code this audience can copy.
- **Fix:** Set `echo=TRUE` on the five plot_model chunks. Optionally add two sentences before the first: "`plot_model()` from sjPlot draws predictions straight from a fitted model. `type = \"pred\"` means 'show me predicted values'; `terms` picks which predictor goes on the x-axis." 
- **Approved:** [x ] — IMPLEMENTED 2026-08-15. All `plot_model()` chunks are `echo=TRUE` now, so the tool the Week 11 homework requires is finally visible where it first appears in the book. Added the drafted two sentences on `type = "pred"` and `terms`, plus one on why both panels are locked to the same y-axis with `coord_cartesian()`, since that is the part students drop when they copy the call.

### [CH13-P02] Region c can go negative — one sentence for the grad students
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Multiple_Regression_Control.qmd → "Breaking Down the Venn Diagram Numerically" (search anchor: "region_c <- r2_model1 + r2_model2 - r2_model3")
- **Problem:** The subtraction method taught here (commonality analysis in miniature) can produce a *negative* region c under suppression — at which point the Venn picture stops being drawable and students who try this on their own data will think they made an arithmetic error. The next chapter covers suppression; this chunk should carry the warning label.
- **Fix:** Add one sentence + pointer: "If you try this on your own data and region c comes out *negative*, you didn't break math — you found suppression, where the Venn diagram metaphor officially resigns. The next chapter explains what that means." (CCAW ch. 3 covers this; add the reference for grad readers.)
- **Approved:** [x ] — IMPLEMENTED 2026-08-15 as a `callout-warning`, "If Region c Comes Out Negative, You Found Something." Says they did not break math, names suppression, keeps the "the Venn diagram metaphor officially resigns" joke, points at the next chapter, and cites Cohen, Cohen, West and Aiken chapter 3 for grad readers.

### [CH13-B01] Before/after plot pairs render as four separate full-width figures
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Multiple_Regression_Control.qmd → "Visualizing Multiple Regression" (search anchor: "plot study before")
- **Problem:** The whole point of each pair is the *comparison* (slope before vs. after control), but each plot renders separately, so in PDF they can land on different pages and the shallower-slope difference — which is subtle here — is nearly impossible to see across a page turn.
- **Fix:** Combine each before/after pair into one side-by-side figure (`patchwork`: `p1 + p2`, or `gridExtra::grid.arrange(ncol=2)` as the Power chapter already does), with a shared y-axis. Two figures instead of four; the comparison becomes visible at a glance.
- **Approved:** [ x] — IMPLEMENTED 2026-08-15 with `patchwork` (`p1 + p2`), confirmed installed before use. Four figures became two, each pair side by side on a shared y-axis, so the before/after slope difference is now visible without a page turn. Both combined figures carry captions and alt text. Figure count for the chapter dropped from 7 to 5.

### [CH13-B02] The prediction chunk computes `predicted` but never shows it
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Multiple_Regression_Control.qmd → "Making a Prediction" (search anchor: "predicted <- B0 + B1 * 10 + B2 * 45")
- **Problem:** The echoed chunk assigns `predicted` and stops — the student who runs it sees nothing, then the prose reveals the value via a separately computed inline expression. Tiny, but it teaches "code that doesn't show its answer."
- **Fix:** Add `predicted` (or `round(predicted, 1)`) as the chunk's last line; make the inline text reference `predicted` instead of recomputing.
- **Approved:** [x ] — IMPLEMENTED 2026-08-15. `round(predicted, 1)` is now the chunk's last line, and the prose reads `` `r round(predicted, 1)` `` instead of recomputing `B0 + B1 * 10 + B2 * 45`. Renders as 79.5, same as before.

---

**Done in the same pass (2026-08-15):**

- **G01**: YAML stripped to `title:` only; seven `opts_chunk$set()` calls folded into one.
- **G02**: all 5 figures now carry `fig-alt` (verified: 5 images, 5 alt attributes). The `ballantine-overlap` chunk already had a `fig-cap`, and adding a second one caused a duplicate-key YAML error on the first render, so only the alt text was added there.
- **Opening left alone.** "Why One Predictor Is Never Enough" already opens on a concrete question rather than a definition list, so it passes `VOICE_GUIDE.md` §15 as written.
- **Cross-references from the reorder** are still correct in this chapter: the closing callout routes to Hierarchical first and Control second, and the "next chapter takes apart statistical control" sentence became a plain link back in the reorder commit.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Ordering note (for 00_OVERVIEW):** This chapter and the two that follow (Control,
Hierarchical) form a "statistical control trilogy" that sits *outside* the 343 weekly
topics (the curriculum jumps from categorical predictors in Week 8 to within-subjects
regression in Week 10). They're the strongest grad-prep material in Part 2 — the ordering
question is whether Mixed_Regression should move ahead of them to match the lab sequence.
Discussed in the overview's ordering section.

**Not flagged (deliberate):** The "sorting students into anxiety groups" explanation of
conditioning (the best plain-English rendering of partialling available); the parallel-lines
plot foreshadowing interactions ("this is what additive means") — a perfect setup for
Chapter 16; the decision to report zero-order correlations before controlled slopes in the
APA model write-up. The final callout's "no new imaginary undergraduates will be recruited"
continuity promise is a structural asset — the Control chapter should hold to it.
