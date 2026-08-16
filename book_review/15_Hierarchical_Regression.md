# Chapter 15 — Hierarchical Regression (Chapter_Hierarchical_Regression.qmd)

**Snapshot:** ~3,400 words. Clean, correct, and well-sequenced: nested models properly
defined, the F-for-ΔR² formula actually explained (numerator = gain per parameter,
denominator = noise level), blocks, the fishing warning, and a fully inline APA write-up.
The main gaps are connective tissue: a naming disambiguation grad students genuinely need,
a broken "previous chapter" reference, and the missing sr²=ΔR² callback to the Control
chapter that would tie the trilogy together.

---

### [CH15-P01] "Hierarchical regression" ≠ "hierarchical linear models" — disambiguate or grad students will conflate them
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Hierarchical_Regression.qmd → "What Is Hierarchical Regression?" (search anchor: "The word \"hierarchical\" refers to the hierarchy of models")
- **Problem:** The chapter correctly notes "hierarchical" means the model sequence — but stops short of the warning that matters: in the wider literature, "hierarchical (linear) model" usually means a *multilevel/mixed model*, which this book also teaches (Mixed_Regression and the draft mixed chapters). A grad student searching "hierarchical regression R" will land in lme4 territory and conclude they need random effects to do sequential entry. This is one of psychology's most confusing naming collisions and the book is positioned to defuse it in two sentences.
- **Fix:** Add a short callout: "**Two things called 'hierarchical':** what we're doing here (adding predictors in theory-driven steps — also called *sequential* regression) has nothing to do with *hierarchical linear models*, which are multilevel/mixed models for clustered data (students inside classrooms; that's the Mixed Regression chapter). Same adjective, unrelated ideas. Blame history."
- **Approved:** [x] — IMPLEMENTED 2026-08-16. `callout-note` titled "Two Things Are Called Hierarchical, and This Is Only One of Them", placed after the "hierarchy of models" paragraph. Drafted text used with three changes: em-dashes translated out per VOICE_GUIDE §14; the clustering examples extended to three (classrooms, trials, participants) so the reader can recognise the shape; and the *reason* the collision bites added explicitly, since the item's own diagnosis (searching lands you in `lme4`) was the strongest part and was missing from the drafted text. "Blame history" kept verbatim as the closing punchline. Links to `Chapter_Mixed_Regression.qmd`.

### [CH15-B01] "In the previous chapter" points two chapters back
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Hierarchical_Regression.qmd → "Where We Left Off" (search anchor: "In the previous chapter, we used **multiple regression**")
- **Problem:** In the book order (Multiple Regression → Control → Hierarchical), the "previous chapter" that fit Models 1–3 is two back; the actual previous chapter is Statistical Control. Small, but it's the opening sentence, and readers navigating the web version by sidebar will click the wrong chapter.
- **Fix:** Change to "In the [multiple regression chapter](Chapter_Multiple_Regression_Control.qmd)…" with the link, and add one clause acknowledging the Control chapter ("and the last chapter showed what 'controlling' really does under the hood"). Alternatively, if the ordering recommendation in 00_OVERVIEW.md (Hierarchical directly after Multiple Regression, Control after) is adopted, this fixes itself — coordinate.
- **Approved:** [x ] — ALREADY RESOLVED 2026-08-15, no edit needed. The ordering swap (see the Part 2 note in `00_OVERVIEW.md` §2) took the "fixes itself" branch of this item. Hierarchical now follows Multiple Regression directly, so both of its back-references are true as written: the "Where We Left Off" opener *and* "Recall the Venn diagram from the previous chapter" at the $\Delta R^2$ section, which had the same defect and was not caught by this item. Nothing in this chapter was changed. If you would rather have the explicit link *and* the nod to the Control chapter anyway, say so and I will add it.

### [CH15-P02] Missing callback: ΔR² here *is* the sr² from the Control chapter
- **Priority:** MED
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_Hierarchical_Regression.qmd → "The Change in R²: What Are We Measuring?" (search anchor: "$$\\Delta R^2 = R^2_{\\text{Model 3}} - R^2_{\\text{Model 1}} = \\text{Region } b$$")
- **Problem:** The Control chapter proved sr² = ΔR² with these *identical* data and made it the centerpiece ("the main reason semi-partial correlation matters"). This chapter re-derives ΔR² = region b and never mentions the connection. The trilogy's payoff — three chapters, one identity — is left on the table, and the t-vs-F connection hides with it (with one added predictor, the model-comparison F equals the squared t of that predictor in the full model — the single most exam-relevant fact here).
- **Fix:** Two additions: (1) after the region-b equation, one sentence: "You met this exact quantity in the Control chapter wearing a different name — the squared semi-partial correlation. sr² = ΔR², same region, same number." (2) After the anova output, a two-line demo: `summary(Model.3)$coefficients["Anxiety","t value"]^2` vs. `anova_result$F[2]` — "when you add exactly one predictor, the comparison F is the square of that predictor's t in the full model. Two tests, one fact." Verify by running.
- **Approved:** [x] — IMPLEMENTED 2026-08-16, with one deviation. **The direction is flipped.** The item asks for a *callback* ("you met this in the Control chapter"), but the Part 2 reorder made Control the chapter that comes *next*, so it is now a forward pointer: "This quantity has a second name, and you are going to meet it in the next chapter." Control's existing "This also equals the change in $R^2$" line now carries the callback end of the pair, so the trilogy still closes, just at the other end. Second deviation, smaller: the item implies the two chapters share the *number*, and they do not. This chapter residualizes Anxiety on Study Hours ($sr^2 = .067$); Control residualizes Study Hours on Anxiety ($sr^2 = .110$). Same identity, different predictor, different value. The prose claims only the identity and the .067 is inline-computed, not typed.
  Part (2) implemented as a new `### This F Is a t You Have Already Met` subsection after the `anova()` walkthrough, with the two-line demo. **Verified by running:** `t_squared 8.858143`, `F_from_anova 8.858143`. Added the boundary condition the item did not mention, that the identity dies as soon as a block of two or more predictors goes in at once.

### [CH15-U01] No Short Story, no self-check
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Hierarchical_Regression.qmd → end (search anchor: "finally hand you an asterisk.")
- **Problem:** Ends on the APA notes + one callout. The four-step "Logic in Plain Language" section is 90% of a Short Story already; it just isn't at the end where a cramming student looks.
- **Fix:** Add `## The Short Story` after the APA section: nested = simpler model lives inside bigger one; ΔR² = new unique variance (region b, = sr²); F-test asks whether the gain beats noise; order comes from theory, decided before peeking; report each step, ΔR², F, then final-model slopes. Covered by the cross-cutting recap item — flagged because the raw material is already written mid-chapter.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. `## The Short Story` added at the end of the file, after the "Order Must Come from the Question" callout. Six bullets, following the item's list, in the style of Ch4/Ch8/Ch14. Two additions to the drafted content: the $F = t^2$ fact (it is the most exam-relevant thing in the chapter and it is new here), and adjusted $R^2$ as the sanity check (the mid-chapter material covers it and a cramming student would otherwise miss it). No self-check questions added; those belong to G04 and need Alex's questions.

**Global items also implemented in this chapter, 2026-08-16:** G01 (YAML stripped to `title:` only, matching Ch10–13); G02 (`fig-alt` on the stacked-bar figure, plus the `fig-cap` it was missing entirely — README lesson 3, it was a hanging figure); em-dash sweep, 26 prose dashes to 0, density 9.48 to the 0.30 floor. This was the "worst in the book" chapter named in `README_FOR_IMPLEMENTER.md`.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; the `cat()`
based "tables" are consistent with Ch13 but a `kable` would render better in PDF (optional,
book-wide style call).

**Not flagged (deliberate):** The stacked-bar variance-decomposition figure (better than the
Venn for showing magnitudes — consider cross-referencing it from Ch13); "the Small/Medium/
Large Sorting Hat" line; the blocks section's covariates-first pattern (this is exactly how
students will run their honors theses); the fishing warning with the 20-comparisons
arithmetic. The APA write-up is the best model write-up in the book so far.
