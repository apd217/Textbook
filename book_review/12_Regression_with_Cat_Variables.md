# Chapter 12 — Linear Regression with Categorical Variables (Ch_12_Categorical_Regression.qmd)

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
- **Location:** Ch_12_Categorical_Regression.qmd → "Multiple t-tests Problem" (search anchor: "Using regression means we will not increase our type I error in the same way!") and "Testing Differences Between Groups" (search anchor: "pairs(means3, adjust=\"none\")")
- **Problem:** The 14%-error-inflation demo is great. The conclusion drawn from it is wrong as stated: fitting one regression doesn't immunize the follow-up comparisons — the chapter itself then computes all three pairwise tests with `adjust="none"`, which is exactly the three t-tests it just warned about. The real story (and the curriculum's own framing: "EMMs: **protected** t-tests") is Fisher's protected-LSD logic: consult the omnibus F first; only if the model says "the means differ somewhere" do you go looking where — and with exactly 3 groups this controls familywise error, but not beyond 3. The omnibus F sitting at the bottom of `summary(model3)` is never mentioned anywhere in the chapter, so the "protection" has no visible mechanism.
- **Fix:** (1) Soften the claim: regression *organizes* the comparisons under one model and gives you a gatekeeper — it doesn't magically delete the multiple-testing problem. (2) After `summary(model3)`, add a paragraph on the F-statistic line: "this tests whether the three means are all equal — the gate you check before knocking on individual doors." (3) At the `pairs()` call, explain `adjust="none"` deliberately: "we can afford no adjustment here because the omnibus F was significant and there are only three groups — this is called a protected t-test, and the protection expires at k = 3; with more groups, see the Multiple Comparisons chapter." (4) Cross-reference Ch_20_Multiple_Comparisons.qmd. Verify the omnibus F is in fact significant when rendering (it will be, with these effect sizes).
- **Approved:** [ x] — IMPLEMENTED 2026-08-15, all four parts. (1) The claim now reads that regression does not delete the multiple-testing problem, it organizes the comparisons under one model and hands you a gatekeeper. (2) New "The Gate: the Omnibus F" section after `summary(model3)` points at the last line of the output and says what it tests, with the values inline. Verified significant: $F(2, 87) = 51.66$, $p < .001$. It also says what to do when the gate is shut, which is stop. (3) New "About That `adjust=\"none\"`" section names Fisher's protected LSD and stresses that the F was bought *before* any pair was examined. (4) Cross-links `Ch_20_Multiple_Comparisons.qmd`. Added a `callout-important` for the k = 3 expiry, since the item flags it as the part students get wrong and it is a natural exam question.

### [CH12-P02] Hard-coded results throughout — coefficient tables and APA write-ups will silently rot
- **Priority:** HIGH
- **Perspective:** Professor + Publisher
- **Effort:** M
- **Location:** Ch_12_Categorical_Regression.qmd → multiple (search anchors: "The model returns something like:", "$t(58) = -10.21$", "accounted for about 64% of the variability", "about **54% of the variability**")
- **Problem:** Both APA write-ups, both coefficient tables (0.664 / 0.341 / 0.192), the t-test paragraph (t(58) = −10.21, d = −2.64), and both R² percentages are typed by hand. The tell is the hedge "The model returns something like:". Every other chapter computes these inline. One seed tweak, one n change, one R version difference in rounding, and the prose contradicts the output above it — in the chapter students copy for their own project write-ups.
- **Fix:** Convert all hard-coded statistics to inline R expressions (`` `r round(coef(model2)[1], 3)` `` etc.), matching the pattern already used in Chapters 6–8. For the markdown coefficient tables, either generate with `knitr::kable(coef(...))` or keep the table shape with inline values in cells. Verify by rendering and comparing every number against the printed output.
- **Approved:** [x ] — IMPLEMENTED 2026-08-15. Every hard-coded statistic is now an inline expression: both coefficient tables, all six reconstructed group means, the prediction-summary table, both APA write-ups, the follow-up write-up, and both R² percentages. The "The model returns something like:" hedge is gone, since it no longer needs to hedge. Kept the markdown table shapes with inline values in the cells rather than switching to `kable`, so the tables still read as tables in the source.
  **Verified against the printed output after rendering, and every previously typed number reproduced exactly**: $M$ = 1.01/0.66, $SD$ = 0.12/0.14, $t(58) = -10.21$, $d = -2.64$, $b$ = 0.664/0.341/0.192, means 1.005/0.856, $R^2$ = .64 and .54. So the old numbers were right; they were just fragile.

### [CH12-U01] The lab's central discussion question — "why do the t-values match?" — is never explicitly answered
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_12_Categorical_Regression.qmd → "The Same Analysis Using Regression" (search anchor: "model2 <- lm(RT ~ Condition, data = dat2)")
- **Problem:** The Week 8 lab has students run the t-test and the regression side by side and discuss *why* the t and p match. The chapter runs both and asserts equivalence in the Short Story, but never puts the two t-values next to each other or explains the identity (the dummy slope *is* the mean difference; its SE *is* the pooled-SE of that difference; therefore slope/SE *is* the pooled t — same arithmetic in a different costume). The one component students must connect is left implicit.
- **Fix:** After `summary(model2)`, add a two-sentence comparison with inline values: "Look at the ConditionTexting row: t = [inline], p = [inline]. Now look back at the t-test: t = [inline] (sign flipped — subtraction order), same p. Not similar. *Identical.* The regression slope is the mean difference, its SE is the pooled standard error, and dividing one by the other is precisely what the t-test did." Note the equivalence requires `var.equal = TRUE` (which the chapter correctly used — one sentence saying so closes the loop with the Welch discussion in Chapter 7).
- **Approved:** [x ] — IMPLEMENTED 2026-08-15 as its own section, "Why Are the t-values the Same?", placed immediately after `summary(model2)` so the reader hits it before anything else. Both t-values inline (10.21 and −10.21), the sign flip explained as subtraction order, and the drafted "Not similar. *Identical.*" kept verbatim. The three-part identity is spelled out: slope is the mean difference, its SE is the pooled SE, dividing them is the t-test. The `var.equal = TRUE` condition is named and tied back to the Welch discussion in Chapter 7.

### [CH12-U02] The write-ups omit F and df — the curriculum's APA format requires them
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_12_Categorical_Regression.qmd → "APA Regression Write up" (search anchor: "accounted for about 64% of the variability") and "APA Write-Up" (search anchor: "about **54% of the variability**")
- **Problem:** Week 8's stated format: "reporting F, R-squared, b, SE, t, and p for each predictor." Both write-ups report b, SE, p and a variance percentage but never the R² symbol, the F statistic, its df, or the t values. Students will mirror the book's incomplete template on graded work.
- **Fix:** Extend both write-ups to the full format (inline values, per CH12-P02): "…, R² = .64, F(1, 58) = [x], p < .001" (two-level) and "R² = .54, F(2, 87) = [x], p < .001" (three-level), and add t(df) to each coefficient clause. Keep the plain-English closing sentences — they're the part most books forget.
- **Approved:** [x ] — IMPLEMENTED 2026-08-15. Both write-ups now carry the full format. Two-level: $R^2 = .64$, $F(1, 58) = 104.31$, with $t(58)$ added to the coefficient clause. Three-level: $R^2 = .54$, $F(2, 87) = 51.66$, with $t(87)$ on both coefficient clauses. The follow-up write-up gained $t(87)$ too. In the three-level version I moved the model-level sentence to the *front* of the paragraph, ahead of the reference-group explanation, because that is the order the omnibus-F-then-follow-ups logic now teaches. Plain-English closers kept.

### [CH12-U03] `relevel()` is in the lab; the chapter only shows `factor(levels=)`
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_12_Categorical_Regression.qmd → "Important" (search anchor: "dat2$Condition <- factor(dat2$Condition,")
- **Problem:** The Week 8 lab description says "setting factor levels with relevel()". The chapter teaches only `factor(levels = c(...))`. Both are worth knowing (factor for initial setup, relevel for switching reference after the fact), and the Short Story's punchline ("changing the reference group changes the labels, not the people") currently has no code demonstrating it.
- **Fix:** After the three-level model, add a mini-demo: `dat3$Condition2 <- relevel(dat3$Condition, ref = "Texting")`, refit, show the coefficient table now expresses everything relative to Texting, and point out the fitted means/R²/F are unchanged — turning the callout's claim into something the student *watches happen*. ~6 lines + 3 sentences.
- **Approved:** [ x] — IMPLEMENTED 2026-08-15 as "Changing the Reference Group" after the three-level means. `relevel(dat3$Condition, ref = "Texting")`, refit, and the coefficient table now reads relative to Texting, with the sign flip on No Distraction explained (being undistracted is faster than texting, so the coefficient is negative). Then a second chunk prints $R^2$ and $F$ side by side for both models to show they are identical, which is the "watches happen" the item asked for. Verified before writing: both match to six decimals.

### [CH12-B01] Duplicated sections and stacked headings — cleanup pass
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_12_Categorical_Regression.qmd → three spots (search anchors: "### Connecting the Model to the Means", "### Extracting the Means", "### Extracting the Model-Estimated Means")
- **Problem:** (1) "### Connecting the Model to the Means" is an empty heading immediately followed by "### Reconstructing the Group Means…" — stacked stubs. (2) The three-level section runs `emmeans(model3, ~ Condition)` twice under two different headings ("Extracting the Means" and, 20 lines later, "Extracting the Model-Estimated Means" — which also re-`library(emmeans)`). Reader sees the same output twice with no acknowledgment. (3) Typo: "(for, with multiple predictors or interactions)" → "(for example, with multiple predictors or interactions)" (search: "(for, with"). (4) Redundant sentence pair in "Dummy Coding": "This process is called dummy coding. The most common coding scheme is dummy coding…" — merge.
- **Fix:** Delete the stub heading; merge the two duplicate emmeans sections into one (keep the first, fold the "These values represent…" sentence into it); fix the typo; merge the redundant dummy-coding sentences. Structure only, no content changes.
- **Approved:** [ x] — IMPLEMENTED 2026-08-15, all four. Stub heading deleted. The two duplicate emmeans sections are merged into one, but note the merge went the *other* way than the item suggested: I kept the later "Extracting the Model-Estimated Means" heading and moved it up to where the first one sat, because that title is the more accurate of the two and the second copy's redundant `library(emmeans)` needed removing anyway. Typo fixed. Dummy-coding sentences merged into one.

### [CH12-P03] A d of 2.64 with no wink — the Power chapter's "simulated data lies politely" rule applies here
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_12_Categorical_Regression.qmd → "APA write up" (search anchor: "$d = -2.64$")
- **Problem:** The Power chapter has a whole callout about not letting simulated effect sizes calibrate intuitions (its CTA d ≈ 2 gets explicitly mocked). This chapter reports d = −2.64 deadpan. Texting-and-driving RT effects in the real literature are large but not *that* large (meta-analytic estimates are closer to d ≈ 0.5–1). One sentence keeps the two chapters honest with each other.
- **Fix:** Add one sentence after the write-up: "A d of 2.6 should make you suspicious by now — real texting-while-driving effects are large (this is why it's illegal) but not science-fiction large; I built this simulation to make the pictures pretty. See the Power chapter's warning about simulated effect sizes."
- **Approved:** [ x] — IMPLEMENTED 2026-08-15 as a `callout-warning`, "A d of 2.6 Should Be Making You Suspicious," directly under the t-test write-up. Uses the item's substance: real texting effects are large (which is why it is illegal) but not science-fiction large, published estimates sit closer to 0.5 to 1, and the simulation was built to make the pictures come out clean. Closes on "simulated data lies politely," which is the Power chapter's own phrase, so the two chapters now use the same handle.

---

**Done in the same pass (2026-08-15):**

- **G01**: YAML stripped to `title:` only (this one also carried a stray `10pt`); eight `opts_chunk$set()` calls folded into one.
- **G02**: both emmeans bar plots now carry `fig-cap` and `fig-alt` (2 images, 2 alt attributes in the render). They previously had neither, so they were hanging figures in Alex's sense.
- **All 12 anonymous chunks named.** This chapter was the worst offender in Part 2.
- **Opening added.** The chapter began cold on "Distracted Driving." It now opens by collecting on Chapter 11's promise that predictors are less picky than outcomes, poses the genuinely strange question (you cannot multiply "Texting" by 0.34), and previews the payoff that the t-test was a regression all along.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; the emmeans
bar plots would benefit from the same raw-data-dots treatment as CH07-B01 (optional).

**Not flagged (deliberate):** The Number-2-pencils etymology joke for "marginal" (it's
actually correct etymology wearing a clown suit — ideal); the predicted-values walkthrough
reconstructing each group mean by hand (repetitive on purpose, and the repetition is the
pedagogy); the 1−(1−α)^j inflation demo (reused later by Multiple Comparisons — check
consistency when reviewing that chapter).
