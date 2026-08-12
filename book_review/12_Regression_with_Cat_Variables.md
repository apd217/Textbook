# Chapter 12 — Linear Regression with Categorical Variables (Chapter_Regression with Cat Variables.qmd)

**Snapshot:** ~2,900 words. Strong curriculum alignment (Week 8's dummy coding, reference
groups, 2-level ≡ t-test, k−1 dummies, emmeans) with a good running example. Two substantive
problems: the chapter claims regression sidesteps the multiple-comparisons problem and then
runs unadjusted pairwise tests two pages later without ever mentioning the omnibus F that
supplies the actual "protection"; and the numeric results (coefficient tables, APA write-ups,
R² percentages) are **hard-coded prose numbers**, not inline R — one seed change and every
write-up silently lies.

---

### [CH12-P01] "Regression means we will not increase our Type I error" — then the chapter runs `pairs(..., adjust="none")`
- **Priority:** HIGH
- **Perspective:** Professor
- **Effort:** M
- **Location:** Chapter_Regression with Cat Variables.qmd → "Multiple t-tests Problem" (search anchor: "Using regression means we will not increase our type I error in the same way!") and "Testing Differences Between Groups" (search anchor: "pairs(means3, adjust=\"none\")")
- **Problem:** The 14%-error-inflation demo is great. The conclusion drawn from it is wrong as stated: fitting one regression doesn't immunize the follow-up comparisons — the chapter itself then computes all three pairwise tests with `adjust="none"`, which is exactly the three t-tests it just warned about. The real story (and the curriculum's own framing: "EMMs: **protected** t-tests") is Fisher's protected-LSD logic: consult the omnibus F first; only if the model says "the means differ somewhere" do you go looking where — and with exactly 3 groups this controls familywise error, but not beyond 3. The omnibus F sitting at the bottom of `summary(model3)` is never mentioned anywhere in the chapter, so the "protection" has no visible mechanism.
- **Fix:** (1) Soften the claim: regression *organizes* the comparisons under one model and gives you a gatekeeper — it doesn't magically delete the multiple-testing problem. (2) After `summary(model3)`, add a paragraph on the F-statistic line: "this tests whether the three means are all equal — the gate you check before knocking on individual doors." (3) At the `pairs()` call, explain `adjust="none"` deliberately: "we can afford no adjustment here because the omnibus F was significant and there are only three groups — this is called a protected t-test, and the protection expires at k = 3; with more groups, see the Multiple Comparisons chapter." (4) Cross-reference Chapter_Multiple_Comparisons.qmd. Verify the omnibus F is in fact significant when rendering (it will be, with these effect sizes).
- **Approved:** [ ]

### [CH12-P02] Hard-coded results throughout — coefficient tables and APA write-ups will silently rot
- **Priority:** HIGH
- **Perspective:** Professor + Publisher
- **Effort:** M
- **Location:** Chapter_Regression with Cat Variables.qmd → multiple (search anchors: "The model returns something like:", "$t(58) = -10.21$", "accounted for about 64% of the variability", "about **54% of the variability**")
- **Problem:** Both APA write-ups, both coefficient tables (0.664 / 0.341 / 0.192), the t-test paragraph (t(58) = −10.21, d = −2.64), and both R² percentages are typed by hand. The tell is the hedge "The model returns something like:". Every other chapter computes these inline. One seed tweak, one n change, one R version difference in rounding, and the prose contradicts the output above it — in the chapter students copy for their own project write-ups.
- **Fix:** Convert all hard-coded statistics to inline R expressions (`` `r round(coef(model2)[1], 3)` `` etc.), matching the pattern already used in Chapters 6–8. For the markdown coefficient tables, either generate with `knitr::kable(coef(...))` or keep the table shape with inline values in cells. Verify by rendering and comparing every number against the printed output.
- **Approved:** [ ]

### [CH12-U01] The lab's central discussion question — "why do the t-values match?" — is never explicitly answered
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Regression with Cat Variables.qmd → "The Same Analysis Using Regression" (search anchor: "model2 <- lm(RT ~ Condition, data = dat2)")
- **Problem:** The Week 8 lab has students run the t-test and the regression side by side and discuss *why* the t and p match. The chapter runs both and asserts equivalence in the Short Story, but never puts the two t-values next to each other or explains the identity (the dummy slope *is* the mean difference; its SE *is* the pooled-SE of that difference; therefore slope/SE *is* the pooled t — same arithmetic in a different costume). The one component students must connect is left implicit.
- **Fix:** After `summary(model2)`, add a two-sentence comparison with inline values: "Look at the ConditionTexting row: t = [inline], p = [inline]. Now look back at the t-test: t = [inline] (sign flipped — subtraction order), same p. Not similar. *Identical.* The regression slope is the mean difference, its SE is the pooled standard error, and dividing one by the other is precisely what the t-test did." Note the equivalence requires `var.equal = TRUE` (which the chapter correctly used — one sentence saying so closes the loop with the Welch discussion in Chapter 7).
- **Approved:** [ ]

### [CH12-U02] The write-ups omit F and df — the curriculum's APA format requires them
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Regression with Cat Variables.qmd → "APA Regression Write up" (search anchor: "accounted for about 64% of the variability") and "APA Write-Up" (search anchor: "about **54% of the variability**")
- **Problem:** Week 8's stated format: "reporting F, R-squared, b, SE, t, and p for each predictor." Both write-ups report b, SE, p and a variance percentage but never the R² symbol, the F statistic, its df, or the t values. Students will mirror the book's incomplete template on graded work.
- **Fix:** Extend both write-ups to the full format (inline values, per CH12-P02): "…, R² = .64, F(1, 58) = [x], p < .001" (two-level) and "R² = .54, F(2, 87) = [x], p < .001" (three-level), and add t(df) to each coefficient clause. Keep the plain-English closing sentences — they're the part most books forget.
- **Approved:** [ ]

### [CH12-U03] `relevel()` is in the lab; the chapter only shows `factor(levels=)`
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Regression with Cat Variables.qmd → "Important" (search anchor: "dat2$Condition <- factor(dat2$Condition,")
- **Problem:** The Week 8 lab description says "setting factor levels with relevel()". The chapter teaches only `factor(levels = c(...))`. Both are worth knowing (factor for initial setup, relevel for switching reference after the fact), and the Short Story's punchline ("changing the reference group changes the labels, not the people") currently has no code demonstrating it.
- **Fix:** After the three-level model, add a mini-demo: `dat3$Condition2 <- relevel(dat3$Condition, ref = "Texting")`, refit, show the coefficient table now expresses everything relative to Texting, and point out the fitted means/R²/F are unchanged — turning the callout's claim into something the student *watches happen*. ~6 lines + 3 sentences.
- **Approved:** [ ]

### [CH12-B01] Duplicated sections and stacked headings — cleanup pass
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Regression with Cat Variables.qmd → three spots (search anchors: "### Connecting the Model to the Means", "### Extracting the Means", "### Extracting the Model-Estimated Means")
- **Problem:** (1) "### Connecting the Model to the Means" is an empty heading immediately followed by "### Reconstructing the Group Means…" — stacked stubs. (2) The three-level section runs `emmeans(model3, ~ Condition)` twice under two different headings ("Extracting the Means" and, 20 lines later, "Extracting the Model-Estimated Means" — which also re-`library(emmeans)`). Reader sees the same output twice with no acknowledgment. (3) Typo: "(for, with multiple predictors or interactions)" → "(for example, with multiple predictors or interactions)" (search: "(for, with"). (4) Redundant sentence pair in "Dummy Coding": "This process is called dummy coding. The most common coding scheme is dummy coding…" — merge.
- **Fix:** Delete the stub heading; merge the two duplicate emmeans sections into one (keep the first, fold the "These values represent…" sentence into it); fix the typo; merge the redundant dummy-coding sentences. Structure only, no content changes.
- **Approved:** [ ]

### [CH12-P03] A d of 2.64 with no wink — the Power chapter's "simulated data lies politely" rule applies here
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Regression with Cat Variables.qmd → "APA write up" (search anchor: "$d = -2.64$")
- **Problem:** The Power chapter has a whole callout about not letting simulated effect sizes calibrate intuitions (its CTA d ≈ 2 gets explicitly mocked). This chapter reports d = −2.64 deadpan. Texting-and-driving RT effects in the real literature are large but not *that* large (meta-analytic estimates are closer to d ≈ 0.5–1). One sentence keeps the two chapters honest with each other.
- **Fix:** Add one sentence after the write-up: "A d of 2.6 should make you suspicious by now — real texting-while-driving effects are large (this is why it's illegal) but not science-fiction large; I built this simulation to make the pictures pretty. See the Power chapter's warning about simulated effect sizes."
- **Approved:** [ ]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; the emmeans
bar plots would benefit from the same raw-data-dots treatment as CH07-B01 (optional).

**Not flagged (deliberate):** The Number-2-pencils etymology joke for "marginal" (it's
actually correct etymology wearing a clown suit — ideal); the predicted-values walkthrough
reconstructing each group mean by hand (repetitive on purpose, and the repetition is the
pedagogy); the 1−(1−α)^j inflation demo (reused later by Multiple Comparisons — check
consistency when reviewing that chapter).
