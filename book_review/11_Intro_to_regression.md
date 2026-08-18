# Chapter 11 — Linear Regression (Ch_11_Intro_Regression.qmd)

**Snapshot:** ~1,850 words. Tight, readable, good assumptions framing ("not personality
tests"), excellent residuals visualization, and the standardized-slope-equals-r payoff is
exactly the bridge the curriculum wants. But measured against 343 Week 5 — the week this
chapter serves — three load-bearing pieces are missing: the **least-squares criterion** (why
THIS line), an **annotated walkthrough of `summary()` output** (the explicit lab skill), and
an **APA write-up** (the explicit homework). And the equation block mislabels Y as "predicted
value" while including the error term.

---

### [CH11-U01] `summary()` output is dumped, never decoded — but decoding it IS the Week 5 lab
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Ch_11_Intro_Regression.qmd → "The Ice Cream Model" (search anchor: "summary(Happy.Model.1)")
- **Problem:** The Week 5 lab says: "Students run a simple linear regression using lm(y ~ x) and interpret the full summary() output: intercept, slope, SE, t-value, p-value, R-squared, F. TA walks through each component and its meaning." The book prints the summary and immediately moves to the intercept — Std. Error, t value, Pr(>|t|), Residual standard error, Multiple vs Adjusted R-squared, and the F-statistic line are never named. This output block is the single most-stared-at object in 343; the book should be the Rosetta stone the student uses at 2 a.m.
- **Fix:** After the `summary()` chunk, add a "Reading the Output Without Panic" walkthrough: reproduce the output regions in order with one line each — Call (your formula, echoed back), Residuals (five-number summary of the leftovers), Coefficients table (Estimate = B; Std. Error = the SE of that estimate, same species as SEM from the standard-error chapter; t value = Estimate/SE, the one-sample t-test logic again; Pr(>|t|) = its p-value), Residual standard error (typical size of a miss, in happiness units), Multiple R-squared (defer detail to the R² section below, one sentence here), F-statistic (the whole-model test; with one predictor, F = t² — show it: `(coef t)^2` vs F). An annotated-figure version (screenshot with callout arrows) would be even better for this audience, but prose + pointers is the minimum. This also sets up the hierarchical-regression chapter where F gets its real job.
- **Approved:** [x ] — IMPLEMENTED 2026-08-15. New "Reading the Output Without Panic" section walks Call, Residuals, all four Coefficients columns, Residual standard error, R-squared, and F, in output order. Std. Error is tied back to the SEM from the standard error chapter, and t to the one-sample t logic, as the item asked. $F = t^2$ is demonstrated with a runnable chunk rather than asserted (44.559 both ways) and pointed forward to hierarchical regression. Residual df is connected to the $N-2$ explanation now living in Chapter 10. Added a `callout-tip`, "The Two Numbers Everyone Skips," because the item's real point is that a p-value cannot distinguish a precise slope from a sloppy one. Prose plus pointers, no annotated screenshot.

### [CH11-U02] Least squares is named nowhere — the "why THIS line?" question is skipped
- **Priority:** HIGH
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Ch_11_Intro_Regression.qmd → "Predicted Values and Residuals" (search anchor: "ordinary least squares balances the line through the data")
- **Problem:** Week 5 Class 1 teaches "the least squares criterion: minimizing the sum of squared residuals." The book's only reference is the aside "ordinary least squares balances the line" — the term OLS appears once, undefined, and the reader never learns that the fitted line is *the* line with the smallest possible sum of squared residuals. Without this, the line is arbitrary magic, and later concepts (R², SSresidual in hierarchical model comparison) have no anchor.
- **Fix:** Add a short section "Why This Line and Not Some Other Line?" after the residuals picture: (1) two-sentence idea — draw any line you like, measure its squared vertical misses, add them up; the regression line is the one that makes that total as small as it can possibly be, hence "least squares"; (2) a small demo chunk: compute `sum(residuals(Happy.Model.1)^2)`, then compute the same sum for one or two deliberately wrong lines (e.g., slope 0 — the mean-only model — and a too-steep line), showing the fitted line wins. The mean-only comparison does double duty: it quietly pre-builds the "total vs residual variance" logic used in the R² section two pages later. (3) One sentence on *why squared* (ties back to the variance chapter's deviations-sum-to-zero point, item CH04-U01).
- **Approved:** [ x] — IMPLEMENTED 2026-08-15 as "Why This Line and Not Some Other Line?", placed straight after the residuals picture. All three parts are in. The demo races the fitted line (SS = 220.3) against the mean-only model (346.2), a too-steep slope of 1.5 (745.3), and a too-flat slope of 0.3 (412.6); verified by running before writing. The why-squared sentence uses the deviations-sum-to-zero argument: a criterion that totals zero for every possible line cannot choose between lines. The mean-only number is deliberately left ringing at the end of the section and picked up again in the $R^2$ section, which now opens by calling $R^2$ "that race expressed as a proportion."

### [CH11-U03] No APA write-up section — the homework is literally "write it up in APA format"
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_11_Intro_Regression.qmd → before "The Short Story" (search anchor: "## The Short Story")
- **Problem:** Week 5 Class 2 covers "Writing up regression results in APA format: F(1, N-2) = value, p, R-squared, b, SE, beta, t(N-2), p" and the HW is a full APA write-up. Every t-test chapter models its APA paragraph with live inline values; this chapter — the template for all regression reporting to come — has none.
- **Fix:** Add an "APA Style Report" section matching the t-test chapters' pattern, with inline R values: "Ice cream consumption significantly predicted happiness, b = [x], SE = [x], β = [x], t(78) = [x], p [<|=] [x]. The overall model explained [x]% of the variance in happiness, R² = [x], F(1, 78) = [x], p [x]." Follow with the plain-English sentence ("each additional scoop predicted about [x] more happiness points") — the curriculum's communication goal — and one reminder that β here equals the correlation from earlier in the chapter.
- **Approved:** [x ] — IMPLEMENTED 2026-08-15 as "APA Style Report" before the Short Story. Every value inline. Adds an `apa.dec()` helper so $\beta$ and $R^2$ print without the leading zero (.60 and .364), which `round()` alone got wrong. Includes the plain-English sentence, the four teaching notes, and the β-equals-r reminder. **Two additions beyond the item:** the $\beta$ is recomputed from a standalone standardized model so the block survives a reader jumping straight here from the homework, and a `callout-warning` was added because the drafted paragraph hard-codes "p < .001" and students copy example write-ups verbatim. Flagged in-file for Alex.

### [CH11-P01] The equation block calls Y "predicted value" while the equation contains e
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_11_Intro_Regression.qmd → "The Regression Equation" (search anchor: "$Y$ = predicted value")
- **Problem:** The displayed model is $Y = B_0 + B_1X + e$ — that's the *observed* Y decomposed into model + error. The bullet list then defines "$Y$ = predicted value," which is wrong for that equation (the predicted value is $\widehat{Y} = B_0 + B_1X$, no e). The residual section later defines $e_i = Y_i - \widehat{Y}_i$ correctly, so the chapter contradicts itself. This exact Y-vs-Ŷ slip is a top-three student confusion in regression and a thing CCAW is fussy about — grad students will carry the sloppy version into that book.
- **Fix:** Show both lines: $Y = B_0 + B_1X + e$ ("what the world does: model plus miss") and $\widehat{Y} = B_0 + B_1X$ ("what the model predicts: no e, because the model doesn't know your dog died"). Fix the bullet: $Y$ = observed value; $\widehat{Y}$ = predicted value; $e$ = the gap between them. Also reconsider "$B_1$ = slope (effect of X)" → "slope (change in prediction per unit of X)" to keep causal language out of the definition list, consistent with the chapter's own causation paragraph.
- **Approved:** [ x] — IMPLEMENTED 2026-08-15. Both equations are now shown, $Y = B_0 + B_1X + e$ labelled "what the world does: model, plus miss" and $\widehat{Y} = B_0 + B_1X$ labelled "what the model predicts," with the drafted dog line. Bullets corrected to observed / predicted / residual, and $B_1$ is now "change in prediction per one-unit increase in X" with the causal wording removed. Added two sentences naming the hat as the distinction and warning it keeps mattering into the mixed models, since this is the review's stated top-three confusion.

### [CH11-P02] "Regression assumes interval or ratio scale variables" contradicts the next three chapters
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_11_Intro_Regression.qmd → "Introduction to Regression" (search anchor: "Regression assumes interval or ratio scale variables.")
- **Problem:** As written, the Note rules out categorical predictors — which is exactly what the following chapter (Regression with Categorical Variables) exists to teach, and the book's whole regression-first thesis depends on. The constraint belongs to the *outcome* (quantitative, for OLS), not the predictors. The Likert aside is good and should stay.
- **Fix:** Reword: "**Note:** The *outcome* in ordinary regression should be interval/ratio-ish (psychologists use Likert scales anyway and mostly get away with it — more on that fight later). Predictors are less picky: next chapters we'll feed regression categorical variables on purpose, and it will thank us."
- **Approved:** [ x] — IMPLEMENTED 2026-08-15 using the drafted rewrite, em-dashes translated per VOICE_GUIDE §14. The constraint now sits on the outcome, the Likert aside survives, and the forward pointer to categorical predictors is in.

### [CH11-P03] "You can transform or rescale variables whenever you want" — one word too broad
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_11_Intro_Regression.qmd → "What didn't change?" (search anchor: "so you can transform or rescale variables whenever you want")
- **Problem:** The claim is stated for "any linear rescaling" and then relaxed to "transform or rescale… whenever you want." Students hear "transform" as including log, square-root, and reciprocal — which change t, p, and the meaning of the model. The correlation chapter made this distinction carefully (linear vs. nonlinear scale changes); this sentence undoes it.
- **Fix:** "These don't change under any *linear* rescaling — adding constants, multiplying by constants, z-scoring. (Nonlinear transformations — logs, squares — are a different animal: they change the model itself, as the correlation chapter showed with ice-cream⁴.)"
- **Approved:** [ x] — IMPLEMENTED 2026-08-15. "Whenever you want" is gone; the claim is now scoped to *linear* rescaling and names the three cases. The nonlinear caveat is a second paragraph rather than a parenthesis, and it calls back to the ice-cream⁴ demo, which is still in Chapter 10 and now carries a caption saying exactly what was done to that axis.

### [CH11-B01] Unrounded inline slope prints ~15 decimal places
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_11_Intro_Regression.qmd → "Slope" (search anchor: "The slope is `r Happy.Model.1$coefficients[2]`")
- **Problem:** Every other inline value in the book is wrapped in `round(, 2-3)`; this one isn't, so the rendered sentence reads "The slope is 0.768493…" at full precision — a visual glitch in the chapter that teaches the book's most important single number.
- **Fix:** Wrap in `round(..., 3)`. While there, grep this chapter for other bare inline coefficients.
- **Approved:** [ x] — IMPLEMENTED 2026-08-15. Wrapped in `round(, 3)`. Grepped the chapter: this was the only bare one, every other inline value was already rounded. The new APA section uses the `apa.dec()` helper instead, since $\beta$ and $R^2$ need the leading zero dropped rather than just rounding.

---

**Global items that also apply here:** chapter YAML residue (note: this one says 10pt where
others say 11pt — more evidence the per-chapter YAML is dead weight); missing `fig-alt`;
Short Story ✓ present.

**Done in the same pass (2026-08-15):**

- **G01**: YAML stripped to `title:` only, the stray `10pt` included. Seven `opts_chunk$set()` calls folded into one.
- **G02**: all 5 figures now carry `fig-cap` and `fig-alt` (verified in the rendered HTML: 5 images, 5 alt attributes). The three diagnostic plots previously had neither, which made them the "hanging figures" problem Alex flagged in Chapter 10.
- Two anonymous chunks named (`correlation-first`, `correlation-again`).
- **Opening rewritten** per `VOICE_GUIDE.md` §15. The chapter opened on "Many psychological studies ask: how does X predict Y?", which is abstract before it is concrete. It now opens by collecting on Chapter 10's closing complaint: correlation threw the units away on purpose, and regression puts them back, answering in points per hour rather than in a number trapped between −1 and +1. This also uses the fact that both chapters run on ice cream and happiness, which was an unused continuity thread.
- **Short Story** gained two bullets, for least squares and for the `summary()` reading skill.

**Not flagged (deliberate):** Chapter length — this is close to the right size for its slot;
the three additions above (~500 words) are curriculum debt, not bloat. The residuals-as-
vertical-mistakes figure with filled/hollow points is the best residual picture I've seen in
an intro text. "Heterogeneity may be a clue, not merely a violation" is a professor-grade
insight smuggled into an undergrad chapter — keep. The five-questions assumptions framing
should be reused verbatim by the diagnostics chapter.
