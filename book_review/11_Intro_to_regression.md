# Chapter 11 — Linear Regression (Chapter_Intro_to_regression.qmd)

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
- **Location:** Chapter_Intro_to_regression.qmd → "The Ice Cream Model" (search anchor: "summary(Happy.Model.1)")
- **Problem:** The Week 5 lab says: "Students run a simple linear regression using lm(y ~ x) and interpret the full summary() output: intercept, slope, SE, t-value, p-value, R-squared, F. TA walks through each component and its meaning." The book prints the summary and immediately moves to the intercept — Std. Error, t value, Pr(>|t|), Residual standard error, Multiple vs Adjusted R-squared, and the F-statistic line are never named. This output block is the single most-stared-at object in 343; the book should be the Rosetta stone the student uses at 2 a.m.
- **Fix:** After the `summary()` chunk, add a "Reading the Output Without Panic" walkthrough: reproduce the output regions in order with one line each — Call (your formula, echoed back), Residuals (five-number summary of the leftovers), Coefficients table (Estimate = B; Std. Error = the SE of that estimate, same species as SEM from the standard-error chapter; t value = Estimate/SE, the one-sample t-test logic again; Pr(>|t|) = its p-value), Residual standard error (typical size of a miss, in happiness units), Multiple R-squared (defer detail to the R² section below, one sentence here), F-statistic (the whole-model test; with one predictor, F = t² — show it: `(coef t)^2` vs F). An annotated-figure version (screenshot with callout arrows) would be even better for this audience, but prose + pointers is the minimum. This also sets up the hierarchical-regression chapter where F gets its real job.
- **Approved:** [ ]

### [CH11-U02] Least squares is named nowhere — the "why THIS line?" question is skipped
- **Priority:** HIGH
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_Intro_to_regression.qmd → "Predicted Values and Residuals" (search anchor: "ordinary least squares balances the line through the data")
- **Problem:** Week 5 Class 1 teaches "the least squares criterion: minimizing the sum of squared residuals." The book's only reference is the aside "ordinary least squares balances the line" — the term OLS appears once, undefined, and the reader never learns that the fitted line is *the* line with the smallest possible sum of squared residuals. Without this, the line is arbitrary magic, and later concepts (R², SSresidual in hierarchical model comparison) have no anchor.
- **Fix:** Add a short section "Why This Line and Not Some Other Line?" after the residuals picture: (1) two-sentence idea — draw any line you like, measure its squared vertical misses, add them up; the regression line is the one that makes that total as small as it can possibly be, hence "least squares"; (2) a small demo chunk: compute `sum(residuals(Happy.Model.1)^2)`, then compute the same sum for one or two deliberately wrong lines (e.g., slope 0 — the mean-only model — and a too-steep line), showing the fitted line wins. The mean-only comparison does double duty: it quietly pre-builds the "total vs residual variance" logic used in the R² section two pages later. (3) One sentence on *why squared* (ties back to the variance chapter's deviations-sum-to-zero point, item CH04-U01).
- **Approved:** [ ]

### [CH11-U03] No APA write-up section — the homework is literally "write it up in APA format"
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Intro_to_regression.qmd → before "The Short Story" (search anchor: "## The Short Story")
- **Problem:** Week 5 Class 2 covers "Writing up regression results in APA format: F(1, N-2) = value, p, R-squared, b, SE, beta, t(N-2), p" and the HW is a full APA write-up. Every t-test chapter models its APA paragraph with live inline values; this chapter — the template for all regression reporting to come — has none.
- **Fix:** Add an "APA Style Report" section matching the t-test chapters' pattern, with inline R values: "Ice cream consumption significantly predicted happiness, b = [x], SE = [x], β = [x], t(78) = [x], p [<|=] [x]. The overall model explained [x]% of the variance in happiness, R² = [x], F(1, 78) = [x], p [x]." Follow with the plain-English sentence ("each additional scoop predicted about [x] more happiness points") — the curriculum's communication goal — and one reminder that β here equals the correlation from earlier in the chapter.
- **Approved:** [ ]

### [CH11-P01] The equation block calls Y "predicted value" while the equation contains e
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Intro_to_regression.qmd → "The Regression Equation" (search anchor: "$Y$ = predicted value")
- **Problem:** The displayed model is $Y = B_0 + B_1X + e$ — that's the *observed* Y decomposed into model + error. The bullet list then defines "$Y$ = predicted value," which is wrong for that equation (the predicted value is $\widehat{Y} = B_0 + B_1X$, no e). The residual section later defines $e_i = Y_i - \widehat{Y}_i$ correctly, so the chapter contradicts itself. This exact Y-vs-Ŷ slip is a top-three student confusion in regression and a thing CCAW is fussy about — grad students will carry the sloppy version into that book.
- **Fix:** Show both lines: $Y = B_0 + B_1X + e$ ("what the world does: model plus miss") and $\widehat{Y} = B_0 + B_1X$ ("what the model predicts: no e, because the model doesn't know your dog died"). Fix the bullet: $Y$ = observed value; $\widehat{Y}$ = predicted value; $e$ = the gap between them. Also reconsider "$B_1$ = slope (effect of X)" → "slope (change in prediction per unit of X)" to keep causal language out of the definition list, consistent with the chapter's own causation paragraph.
- **Approved:** [ ]

### [CH11-P02] "Regression assumes interval or ratio scale variables" contradicts the next three chapters
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Intro_to_regression.qmd → "Introduction to Regression" (search anchor: "Regression assumes interval or ratio scale variables.")
- **Problem:** As written, the Note rules out categorical predictors — which is exactly what the following chapter (Regression with Categorical Variables) exists to teach, and the book's whole regression-first thesis depends on. The constraint belongs to the *outcome* (quantitative, for OLS), not the predictors. The Likert aside is good and should stay.
- **Fix:** Reword: "**Note:** The *outcome* in ordinary regression should be interval/ratio-ish (psychologists use Likert scales anyway and mostly get away with it — more on that fight later). Predictors are less picky: next chapters we'll feed regression categorical variables on purpose, and it will thank us."
- **Approved:** [ ]

### [CH11-P03] "You can transform or rescale variables whenever you want" — one word too broad
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Intro_to_regression.qmd → "What didn't change?" (search anchor: "so you can transform or rescale variables whenever you want")
- **Problem:** The claim is stated for "any linear rescaling" and then relaxed to "transform or rescale… whenever you want." Students hear "transform" as including log, square-root, and reciprocal — which change t, p, and the meaning of the model. The correlation chapter made this distinction carefully (linear vs. nonlinear scale changes); this sentence undoes it.
- **Fix:** "These don't change under any *linear* rescaling — adding constants, multiplying by constants, z-scoring. (Nonlinear transformations — logs, squares — are a different animal: they change the model itself, as the correlation chapter showed with ice-cream⁴.)"
- **Approved:** [ ]

### [CH11-B01] Unrounded inline slope prints ~15 decimal places
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Intro_to_regression.qmd → "Slope" (search anchor: "The slope is `r Happy.Model.1$coefficients[2]`")
- **Problem:** Every other inline value in the book is wrapped in `round(, 2-3)`; this one isn't, so the rendered sentence reads "The slope is 0.768493…" at full precision — a visual glitch in the chapter that teaches the book's most important single number.
- **Fix:** Wrap in `round(..., 3)`. While there, grep this chapter for other bare inline coefficients.
- **Approved:** [ ]

---

**Global items that also apply here:** chapter YAML residue (note: this one says 10pt where
others say 11pt — more evidence the per-chapter YAML is dead weight); missing `fig-alt`;
Short Story ✓ present.

**Not flagged (deliberate):** Chapter length — this is close to the right size for its slot;
the three additions above (~500 words) are curriculum debt, not bloat. The residuals-as-
vertical-mistakes figure with filled/hollow points is the best residual picture I've seen in
an intro text. "Heterogeneity may be a clue, not merely a violation" is a professor-grade
insight smuggled into an undergrad chapter — keep. The five-questions assumptions framing
should be reused verbatim by the diagnostics chapter.
