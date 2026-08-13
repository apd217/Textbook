# Chapter 5 — Standard Error (Chapter_Standard_Error.qmd)

**Snapshot:** ~3,000 words. The CTA-survey story arc (one sample → doubt → 80 coerced
undergrads → CLT → "just use math") is the best standard-error narrative I've seen in an
intro book, and the CI-misinterpretation callouts (Hoekstra) are exactly right. Two real
issues: all simulation code is hidden in the one chapter where the simulation IS the
concept, and the sampling-distribution SD formula reuses N for a different count than the
N used two formulas earlier.

---

### [CH05-U01] The chapter's simulations are invisible — echo the sampling code
- **Priority:** HIGH
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_Standard_Error.qmd → setup chunk (search anchor: "knitr::opts_chunk$set(echo = FALSE)") and "Brute force solution?" chunk (search anchor: "replicate(NumberofSamples,sample(CTA.Population")
- **Problem:** Global `echo = FALSE` hides every line of code. But this chapter's entire argument is "you could literally do this yourself": draw a sample with `sample()`, repeat it 80 times with `replicate()`, take the SD of the means. Those three lines ARE the concept of a sampling distribution — hiding them converts the book's strongest simulation lesson into pictures that appear by magic. (Same disease as the Probability chapter, CH03-U01; the two should be fixed the same way.) The Week 9 curriculum has students computing SEM by hand and verifying in R — the book should hand them the verification pattern.
- **Fix:** Selectively echo the *sampling* lines, not the plotting boilerplate: (1) the population creation chunk (`rnorm` → round → clamp — it's short and demystifies "the population"); (2) `sample.1 <- sample(CTA.Population, 10)` with `mean()`/`sd()`; (3) the brute-force chunk's three lines (`replicate`, `apply`, and then `sd(Sample.Means)`). Keep every ggplot chunk hidden. Add one sentence before the brute-force code: "Three lines of R replace 80 undergraduates. The Dean will be pleased."
- **Approved:** [X ]

### [CH05-P01] The sampling-distribution SD formula reuses N for "number of samples" right after N meant "people per sample"
- **Priority:** MED
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_Standard_Error.qmd → "SD of Distribution of Means" (search anchor: "S_M = \\sqrt{\\frac{\\Sigma (M-M_{Grand})^2}{N-1}}")
- **Problem:** In `$S = \sqrt{\Sigma(X-M)^2/(N-1)}$`, N = 10 people. Two lines later, `$S_M = \sqrt{\Sigma(M-M_{Grand})^2/(N-1)}$` uses N = 80 samples. The "Two Different Counts Are Hiding in This Example" callout later fixes the concept, but the formulas themselves teach the collision. This is precisely the confusion that makes students bomb SEM exam questions (dividing by the wrong count).
- **Fix:** In the S_M formula, replace N with a visually distinct symbol, e.g. $N_{samples}$ (or $k$), and add a parenthetical: "(number of samples — 80 here — not the 10 people inside each sample; see the callout below)". Consider moving the "Two Different Counts" callout up to sit directly beneath this formula instead of its current position in the SEM section.
- **Approved:** [X ]

### [CH05-P02] Hard-coded `.957` in the Sample 3 SEM display will silently rot
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Standard_Error.qmd → "What If We Sampled More People?" (search anchor: "\\frac{.957}{\\sqrt{100}}")
- **Problem:** Every other number in the chapter is computed inline (`` `r round(...)` ``), but the displayed SEM formula for Sample 3 hard-codes the SD as .957. If the seed, population, or sample size ever changes, the formula will contradict the computed values beside it — the classic reproducibility failure this book preaches against.
- **Fix:** Replace the hard-coded value with the inline expression (`$S_M = \frac{`r round(SD3,2)`}{\sqrt{100}}$` or equivalent). Verify by rendering that displayed and computed values agree.
- **Approved:** [X ]

### [CH05-U02] Two nearly identical SEM-vs-N plots in a row
- **Priority:** LOW
- **Perspective:** Student + Publisher
- **Effort:** S
- **Location:** Chapter_Standard_Error.qmd → "Effect of Sample Size" (search anchor: "N_vals <- 10:10000")
- **Problem:** The full-range plot (N to 10,000) and the zoomed plot (N to 400) carry one idea between them: diminishing returns. For a reader with limited attention, two consecutive near-duplicate figures cost a page and dilute the punch; the zoomed one alone (or one figure with a marked "zoom" region) makes the point.
- **Fix:** Either keep only the zoomed 10–400 plot and add one sentence ("past ~400 the curve is basically crawling"), or overlay: full-range plot with a shaded rectangle showing where the second plot zooms. Also note both chunks re-`library(tidyverse)` redundantly — drop the repeats while in there.
- **Approved:** [ X]

### [CH05-P03] Sampling people "with replacement" contradicts the story (invisible now, visible after CH05-U01)
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Standard_Error.qmd → sample chunks (search anchor: "sample(CTA.Population, SampleSize, replace = TRUE)")
- **Problem:** The story says "randomly select 10 people"; the code samples with replacement, i.e., the same commuter could be surveyed twice. With N=1,000,000 it changes nothing numerically, but once the code is echoed (CH05-U01) a sharp student will ask, and "with replacement" gets a precise meaning in the Bootstrapping chapter later — better not to muddy it here.
- **Fix:** Change to `replace = FALSE` in the person-sampling chunks (samples 1, 2, 3 and the replicate chunk). Verify rendered numbers barely move and update any inline values that shift (the seed will produce different draws — re-check the "both intervals include the true mean" claim still holds; if not, adjust seeds).
- **Approved:** [ X]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; "The Short
Story" exists here ✓ (good).

**Not flagged (deliberate):** The coerced-undergraduate-labor running gag, the Dean's
intervention, and Dorkaos revealing the true population — this is narrative structure doing
real statistical work (single sample → sampling distribution → estimator), and the
CI-interpretation callouts are more correct than most graduate textbooks. The bridge line
into t-tests ("Is this sample consistent with a specific claim?") is exactly the right
cliffhanger — preserve it through any edits.
