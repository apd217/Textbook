# Chapter 4 — Distributions and their Moments (Chapter_Distro_Moments.qmd)

**Snapshot:** ~4,200 words. One of the strongest chapters: real Census data as the hook, the
cookie-dough SD dot plot is publication-quality teaching, the Alex-vs-Emma z-score payoff is
perfect, and it *has* a "Short Story" recap (the pattern other chapters should copy). The
issues are mostly code-level: a mean computed from bin **upper bounds** while the caption
claims midpoints, a fragile `map2` simulation idiom that teaches bad practice, and a missing
`qnorm()`/`quantile()` to match the Week 5 lab.

---

### [CH04-P01] Income figure: code computes the "mean" from bin upper bounds, caption says midpoints
- **Priority:** HIGH
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → income figure chunk (search anchor: "mean_income <- weighted.mean(")
- **Problem:** `weighted.mean(df$upper, df$households, na.rm = TRUE)` weights the bin **upper** bounds, biasing the mean upward — yet the code computes `midpoint` two lines earlier and never uses it, and the figure caption states "Mean and median are approximated using bin midpoints." In the chapter that teaches "the mean can mislead you," the mean shown is itself miscomputed relative to its own caption. Students are also asked to reason about "mean = 123K" in the Think-about-it question, so the number propagates into the text.
- **Fix:** Change to `weighted.mean(df$midpoint, df$households, na.rm = TRUE)`. Re-render; update the hard-coded "mean = 123K" in the Think-about-it question (and the Week 4 lab talking point of ~$123K if it shifts materially — the curriculum quotes ~$123K, so check which number the class expects). Also: the mode line is hard-coded at 30000 while the question text says "mode = 32.5K" — make code and text agree. Verify by running.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12. Mean now uses midpoints: **$110K** (was a biased $123K from upper bounds). Mode is now computed, not hard-coded — and this exposed a second bug: Census bins are unequal width, so the largest *count* is a wide high-income bin ($275K). Fixed by using households per dollar of bin width (density), which gives **$32K**, matching the original text and the curriculum's ~$30K. All three numbers are now inline. Median $80K unchanged. NOTE: $110K is below the curriculum's ~$123K talking point because the open-ended $200k+ bin has no midpoint and gets dropped; added a paragraph explaining this so the book and the TA do not appear to disagree.

### [CH04-P02] MRT simulation uses a fragile self-join idiom that will silently corrupt data if two groups share an n
- **Priority:** HIGH
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → "Step 1: Simulate the population distributions" (search anchor: "mutate(data = map2(n, mean,")
- **Problem:** `map2(n, mean, ~rnorm(.x, mean = .y, sd = params$sd[params$n == .x]))` looks up each group's SD by matching on **n**. It works today only because the four n's happen to be unique; if any two groups had equal n it would return a vector of SDs and recycle garbage, silently. Worse, this chunk is explicitly presented as "see what R can do" showcase code — students and grad students will copy it. The clean idiom is a three-argument map.
- **Fix:** Replace with `mutate(data = pmap(list(n, mean, sd), rnorm))` (and `unnest(data)` as-is). Same output, same seed behavior, teaches the right pattern. Verify by running; the summary check table should match the published values as before.
- **Approved:** [x ] — IMPLEMENTED 2026-08-12 (`pmap(list(n, mean, sd), rnorm)`; simulated group means/SDs still match the published Peters values)

### [CH04-U01] Curriculum wants "why N−1" — the chapter asserts it without the intuition
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_Distro_Moments.qmd → "Moment 2: Spread" (search anchor: "we divide by $N - 1$ instead of $N$")
- **Problem:** 242 Week 5 Class 1 explicitly teaches "why squaring eliminates negatives and why we divide by N−1." The book's entire treatment is one sentence ("to get an unbiased estimate. This is called degrees of freedom."). Two gaps: (a) why squaring — never stated (the deviations-sum-to-zero fact isn't mentioned anywhere); (b) why N−1 — asserted, not shown. This is one of the two or three most-asked questions in any intro course, and the book's answer is a shrug.
- **Fix:** Add a short subsection or callout after the sample-variance formula: (1) deviations from the mean always sum to zero — show it in 3 lines of R with a tiny vector (`sum(x - mean(x))`), which motivates squaring; (2) the "last deviation isn't free" intuition: once you know the mean and N−1 deviations, the last one is determined — you only have N−1 independent pieces of information, hence dividing by N−1; (3) optionally a 5-line simulation showing that dividing by N systematically underestimates the population variance across 10,000 samples (this is the empirical proof, very much in this book's simulate-everything spirit). Keep under ~200 words + one chunk.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (two new subsections. "Why Square the Deviations?" shows `sum(x - mean(x))` returning exactly zero. "Why Divide by N−1 and Not N?" gives the last-deviation-isn't-free intuition, then proves it: 10,000 samples from a population with variance 25 give 21.80 dividing by N and 24.91 dividing by N−1.)

### [CH04-U02] Missing `qnorm()`/`quantile()` — the lab teaches both directions, the book teaches one
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → "Finding Probability from Z-scores" (search anchor: "pnorm(2) - pnorm(1)")
- **Problem:** The Week 5 lab uses "pnorm() & quantile() in R to find corresponding area under the curve and percentile ranks." The chapter teaches `pnorm()` (score → percentile) but never the inverse (percentile → score): no `qnorm()`, no `quantile()`. The inverse direction is what real decisions use (test cutoffs, "top 10%" — both named in the curriculum) and it's the direction students find harder.
- **Fix:** Add a short subsection "Going the Other Way" after the pnorm examples: `qnorm(.90)` = the z-score that cuts off the top 10%; convert back to raw units (M + z·S) with the cognitive-score example (e.g., "what score do you need to be in the top 10%? 100 + 1.28×15 ≈ 119"); then `quantile(Normal.Sample.1, .90)` on the simulated population to show the empirical version agrees. Three code lines, ~100 words.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (new "Going the Other Way" subsection: `qnorm(.90)`, converted to raw units (119 points), then `quantile()` on the simulated population, with a note that when the two disagree the data wins)

### [CH04-P03] Deprecated `..density..` ggplot idiom (appears 3× here, check book-wide)
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → "Step 2: Visualize the distributions" (search anchor: "aes(y = ..density..)")
- **Problem:** `..density..` was deprecated in ggplot2 3.4 (2022) in favor of `after_stat(density)`. Warnings are suppressed so the book renders clean, but students who copy this into fresh sessions see deprecation warnings and think they broke something — the exact anxiety this book works to prevent. Also a freshness signal to any instructor evaluating the book.
- **Fix:** Replace all `..density..` with `after_stat(density)` in this chapter, then `grep` the whole book for `\.\.[a-z]+\.\.` and fix remaining instances in one pass. Verify by rendering.
- **Approved:** [x ] — IMPLEMENTED 2026-08-12 (3 instances here; book-wide grep confirms no `..density..` remains anywhere, so G12's ggplot half is done)

### [CH04-P04] Alex's z-score uses 12.75 in code but 12.74 in text
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → "Step 4: Z-score to probability" (search anchor: "Z.Alex <- (10 - 12.75) / 4.87")
- **Problem:** The prose and table give M = 12.74 for males in social sciences; the code uses 12.75. The answer barely moves, but this is the worked example students will re-do by hand to check themselves — and their hand answer won't match the book's output.
- **Fix:** Change code to `(10 - 12.74) / 4.87`; re-render and confirm the "28.6%" prose still matches the new output (it becomes ~28.7% — update the sentence).
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (code now uses 12.74; prose percentile is inline and renders 28.7%. Emma's 61.75% was also hard-coded — made inline too, renders 61.8%.)

### [CH04-P05] "The four moments" framing: acceptable, but give grads the one-line footnote
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → "Moments" (search anchor: "Four numbers capture the important features")
- **Problem:** Calling mean/variance/skewness/kurtosis "the four moments" is standard teaching shorthand, but technically the mean is the first raw moment, variance the second central moment, and skew/kurtosis are *standardized* third/fourth moments. A grad student who repeats "kurtosis is the fourth moment" in a CCAW-adjacent seminar will get corrected. One sentence protects them.
- **Fix:** Add a one-line collapse-style note or footnote: "Pedantic fine print for graduate students: strictly, these are the first raw moment, second central moment, and standardized third and fourth moments. Nobody at a party cares, but a comprehensive exam might."
- **Approved:** [x ] — IMPLEMENTED 2026-08-12 (collapsible note under the Moments heading)

### [CH04-B01] Income figure chunk uses invalid chunk options; historical-sidenote framing worth a second look
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → income chunk header (search anchor: "{r, width = 6.5, height = 3, echo=FALSE}") and "### Historical sidenote" (search anchor: "top marginal tax rate")
- **Problem:** (a) `width`/`height` aren't knitr options (`fig.width`/`fig.height` are) — silently ignored, so the figure renders at global size; someone will "adjust" these someday and be confused. (b) The historical sidenote ("Imagine that money went back into schools…") is a good distribution-reasoning prompt but carries a light editorial flavor; this book is the standardized text across multiple instructors' sections, so a more neutral framing ("Suppose a policy substantially reduced top incomes — predict what happens to mean, median, mode and why") keeps the same pedagogy with zero risk of a colleague objecting.
- **Fix:** (a) Change to `fig.width=6.5, fig.height=3`. (b) Optional, Alex's call: reframe the sidenote prompt neutrally as above; the prediction exercise (the valuable part) is unchanged.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (a: chunk now named with proper `fig.width`/`fig.height` plus fig-cap and fig-alt. b: reframed as "A sidenote for the curious" — a policy that reduces top incomes, with an explicit note that it is a distribution question and the reasoning runs the same backward. Added a third Think-about-it question about which number a politician would quote.)

### [CH04-B02] External data dependency `hinc01.xlsx` — document it
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Distro_Moments.qmd → income chunk (search anchor: "read_excel(\"hinc01.xlsx\"")
- **Problem:** The chapter reads `hinc01.xlsx` from the project root (file exists — verified). It's the only external data file in the early chapters; if the repo is published to GitHub without it, or Census reshapes the sheet, the book stops rendering at Chapter 4. The row/column magic numbers (`raw[8, 3:43]`, `raw[10, 3:43]`) are brittle by nature.
- **Fix:** Add a code comment in the chunk stating the source (Census HINC-01, year, URL) and that rows 8/10 hold bin labels/counts for that vintage. Ensure `hinc01.xlsx` is committed to the repo (add to git, not .gitignore). No behavior change.
- **Approved:** [x ] — IMPLEMENTED 2026-08-12 (source comment names Census HINC-01 and explains rows 8/10; `hinc01.xlsx` confirmed tracked in git since the initial commit)

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt` on all figures.

**Not flagged (deliberate):** The cookie-dough unipolar-scale digression (it quietly teaches
survey design, which is 343 Week 2 material — a free preview). The "Advanced Code Has
Arrived Early" callout is exactly how to license complexity for this audience. The Short
Story recap here is the book's best; use it as the template for the cross-cutting recap item.
