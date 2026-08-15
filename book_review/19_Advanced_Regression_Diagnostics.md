# Chapter 19 — Advanced: Regression Diagnostics (Chapter_Advanced_Regression_Diagnostics.qmd)

**Snapshot:** ~1,350 words, grad/advanced audience (correctly labeled). Conceptually careful
(leverage ≠ influence, screening thresholds ≠ deletion warrants, hat matrix for the brave)
and admirably free of ritualism ("do not test normality and surrender"). Notably, this
chapter's YAML is already clean (title only) — it's the template for the global YAML fix.
Main gaps: the chapter *tells* more than it *shows* in the second half — no `vif()` call, no
HC-standard-error one-liner, and the refit-without-the-outlier comparison it preaches is
never demonstrated.

---

### [CH19-P01] The chapter's own sermon — "compare conclusions with and without" — is never demonstrated
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Chapter_Advanced_Regression_Diagnostics.qmd → after the Cook's distance plot (search anchor: "not whom to throw into the statistical volcano.")
- **Problem:** Participant 60 is built, flagged in two plots, and moralized about ("If one person reverses the entire result, that instability is part of the result") — but the payoff never happens: the model is never refit without them, so the reader never sees how much the coefficients actually move. The one thing a grad student will do in practice (sensitivity refit) is the one thing not modeled.
- **Fix:** Add a short chunk: `TherapyModel.60 <- update(TherapyModel, data = TherapyData[-60, ])` and a two-row coefficient comparison (kable or `rbind(coef(...))`), with 2–3 sentences interpreting the shift and repeating the rule: report both, don't silently pick the flattering one. Verify by running.
- **Approved:** [ x]

### [CH19-P02] VIF gets a formula but no R — add the one-liner
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Chapter_Advanced_Regression_Diagnostics.qmd → "Multicollinearity" (search anchor: "VIF_j=\\frac{1}{1-R_j^2}")
- **Problem:** Every other diagnostic in the chapter has a plot or computation; multicollinearity gets only algebra. The reader leaves without knowing `car::vif(TherapyModel)` exists — the single command they'll actually use — or what magnitude should worry them.
- **Fix:** Add `car::vif(TherapyModel)` with output and two sentences: conventional worry thresholds (5–10) are folklore, not law; what matters is whether the inflated SEs damage the question being asked. Optional: one line simulating two r = .9 predictors to show a VIF ≈ 5 in action. (Also connects back to CH13-P01's "controlled slopes cost precision" point — cross-reference it.)
- **Approved:** [ x]

### [CH19-P03] Heteroscedasticity fixes are named but not shown — give grads the sandwich
- **Priority:** LOW
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Chapter_Advanced_Regression_Diagnostics.qmd → "When the Variance Changes" (search anchor: "reporting heteroscedasticity-consistent standard errors")
- **Problem:** HC standard errors are recommended twice, but the reader is never shown how — and this is the fix they'll need most often (it's also CCAW-adjacent material). One chunk closes the loop.
- **Fix:** Add: `lmtest::coeftest(TherapyModel, vcov = sandwich::vcovHC(TherapyModel, type = "HC3"))` with one sentence ("same slopes, more honest SEs when the spread misbehaves") and a pointer that `performance::check_model()` bundles most of this chapter's plots into one call — worth knowing even if the hand-built versions teach better.
- **Approved:** [ x]

### [CH19-B01] Cross-link the intro chapter's "five questions," fix the vague mixed-models pointer, bullet the Short Story
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Advanced_Regression_Diagnostics.qmd → three spots (search anchors: "## Advanced Topic: Who Is This For?", "in the graduate mixed-model section", "## The Short Story")
- **Problem:** (1) The Intro-to-Regression chapter frames assumptions as five questions; this chapter re-derives the same list without referencing it — a free continuity win missed. (2) "We will do that in the graduate mixed-model section" — vague; Chapter_Mixed_Regression.qmd is active and linkable. (3) The Short Story here is a paragraph while every other chapter uses bullets — trivial inconsistency, but this is the recap format students learn to scan. (4) Typo: workflow step 4 "inspect" is lowercase (search: "4. inspect Q–Q behavior").
- **Fix:** (1) Open with "In the Intro to Regression chapter we asked five questions about the line; this chapter is those questions with a magnifying glass" + link. (2) Link the mixed chapter. (3) Convert Short Story to 4–5 bullets. (4) Capitalize.
- **Approved:** [x ]

---

**Global items that also apply here:** missing `fig-alt`. (YAML already clean — use this
file as the target state for the global YAML item.)

**Not flagged (deliberate):** "Residuals should not organize a protest" and "driving the
statistical bus" as plot titles; the hat-matrix section placed at the end where only the
willing will find it; the refusal to hand out hard VIF/Cook cutoffs as laws. The
"Deleting the Problem Is Not Diagnosing the Problem" callout is the ethical core of the
chapter — protect it.
