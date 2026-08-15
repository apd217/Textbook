# Chapter 20 — P-Values and Multiple Comparisons (Chapter_Multiple_Comparisons.qmd)

**Snapshot:** ~2,500 words. One of the best chapters in the book, period: dead-salmon opener
(properly cited), a correct p-value definition with the misconception list, Gelman & Stern's
significant-here-not-there trap, family definition as scientific judgment, FWER vs. FDR with
an honest power-tradeoff simulation, and a goal→method table. Findings are additions, not
corrections.

---

### [CH20-P01] The applied bridge is missing: emmeans `adjust=` and Tukey, which is what students actually touch
- **Priority:** MED
- **Perspective:** Professor (grad reader) + Student
- **Effort:** M
- **Location:** Chapter_Multiple_Comparisons.qmd → after "Multiple Comparisons in Regression" (search anchor: "use software that can adjust the contrast family explicitly")
- **Problem:** In this book's own pipeline, multiplicity shows up concretely in one place: `pairs(emmeans(...))` after a categorical model — where the Cat-Variables chapter used `adjust="none"` with protected-t reasoning (item CH12-P01), and where emmeans silently defaults to **Tukey** for all-pairwise comparisons. Tukey HSD — the correction psychologists meet most — is never named in this chapter, and the emmeans `adjust=` menu ("tukey", "holm", "none", "fdr") is never shown. The reader learns the theory here and the practice nowhere.
- **Fix:** Add a short section "Where You'll Actually Meet This: emmeans": refit a quick 3-group model (or reuse the distracted-driving data by cross-reference), show `pairs(emm)` with default Tukey vs. `adjust="holm"` vs. `adjust="none"`, and give the decision rule in book voice: all-pairwise after an omnibus → Tukey is built for exactly this; a few planned contrasts → Holm; exactly 3 groups with a significant omnibus F → "none" is the protected-t special case (link back to the categorical-predictors chapter so the two chapters tell one story). Verify by running.
- **Approved:** [ x]

### [CH20-U01] The regression-family example is a commented-out stub
- **Priority:** LOW
- **Perspective:** Student (grad reader)
- **Effort:** S
- **Location:** Chapter_Multiple_Comparisons.qmd → "Multiple Comparisons in Regression" (search anchor: "# Example after fitting a model called model:")
- **Problem:** The only how-to code in the section is a chunk of comments referring to a model that doesn't exist ("a model called model"). Same disease as the centering stub in Chapter 16 — gray pseudo-code where live code would cost five lines.
- **Fix:** Make it real: simulate a quick 6-predictor model (or reuse an existing dataset), extract `coef(summary(model))[, "Pr(>|t|)"]`, show `p.adjust(..., "holm")` and `"BH"` side by side in a small table. If CH20-P01's section is added, this can fold into it.
- **Approved:** [ x]

### [CH20-U02] No Short Story
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Multiple_Comparisons.qmd → end (search anchor: "perform social cognition without preregistration.")
- **Problem:** The closing prose is excellent but unscannable; this chapter's checklist ("a defensible statistical argument uses…") is nearly a recap already. Covered by the cross-cutting item.
- **Fix:** Add `## The Short Story`: p = P(data this weird | H0 + model), never the reverse; significant-vs-not is not a comparison; a family is defined by the claim, before peeking; FWER (Holm ≥ Bonferroni) when any false claim is costly, BH-FDR for exploration; report the method and the family; the salmon was dead the whole time.
- **Approved:** [x ]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Cross-references to coordinate:** CH03-P01 (Probability chapter's salmon aside should cite
@bennett2010 and point here — the citation already exists in references.bib per this chapter);
CH12-P01 (protected-t discussion should point here); CH18-P02 (mixed chapter's salmon
line). This chapter is the hub — make the spokes link to it.

**Not flagged (deliberate):** The FWER growth simulation overlaying theory (quiet
methodological modeling); the "families of one… p-hacking with office supplies" line; the
honest statement that FDR .05 is an expectation over uses, not a per-study guarantee; the
final table mapping goals to defaults. The chapter correctly resists ranking corrections and
instead matches error promises to goals — that framing is worth protecting from any editor
who wants a flowchart.
