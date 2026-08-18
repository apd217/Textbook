# Chapter 5 — Standard Error (Ch_05_Standard_Error.qmd)

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
- **Location:** Ch_05_Standard_Error.qmd → setup chunk (search anchor: "knitr::opts_chunk$set(echo = FALSE)") and "Brute force solution?" chunk (search anchor: "replicate(NumberofSamples,sample(CTA.Population")
- **Problem:** Global `echo = FALSE` hides every line of code. But this chapter's entire argument is "you could literally do this yourself": draw a sample with `sample()`, repeat it 80 times with `replicate()`, take the SD of the means. Those three lines ARE the concept of a sampling distribution — hiding them converts the book's strongest simulation lesson into pictures that appear by magic. (Same disease as the Probability chapter, CH03-U01; the two should be fixed the same way.) The Week 9 curriculum has students computing SEM by hand and verifying in R — the book should hand them the verification pattern.
- **Fix:** Selectively echo the *sampling* lines, not the plotting boilerplate: (1) the population creation chunk (`rnorm` → round → clamp — it's short and demystifies "the population"); (2) `sample.1 <- sample(CTA.Population, 10)` with `mean()`/`sd()`; (3) the brute-force chunk's three lines (`replicate`, `apply`, and then `sd(Sample.Means)`). Keep every ggplot chunk hidden. Add one sentence before the brute-force code: "Three lines of R replace 80 undergraduates. The Dean will be pleased."
- **Approved:** [X ] — IMPLEMENTED 2026-08-14. Followed Ch3's pattern exactly (global `echo = FALSE`, selective `#| echo: true`). Five chunks now visible: population creation, sample 1, sample 2, the brute-force `replicate`/`apply`, and `sd(Sample.Means)`. Every ggplot chunk was split out into its own hidden chunk, so no plotting boilerplate is echoed. All chunks are now named. DEVIATIONS, all flagged in-file for Alex: (a) sample 2's draw is echoed too, beyond the item's list — it is four lines and it makes the role of `set.seed()` visible, which is the "why don't my numbers match the book" question; (b) echoed code was retabbed to `<-` and spaced (it was `SampleSize = 10` and `sample.1<-sample(...)`) since it is now reader-facing; (c) the drafted Dean sentence is in verbatim but sits back-to-back with the "homework...yeah homework" punchline and spends the Dean two sections before he appears — left an `<!-- ALEX -->` comment offering three ways out; (d) added two new sentences framing the population chunk, because a million simulated commuters otherwise appear with no warning — also flagged for rewrite.

### [CH05-P01] The sampling-distribution SD formula reuses N for "number of samples" right after N meant "people per sample"
- **Priority:** MED
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Ch_05_Standard_Error.qmd → "SD of Distribution of Means" (search anchor: "S_M = \\sqrt{\\frac{\\Sigma (M-M_{Grand})^2}{N-1}}")
- **Problem:** In `$S = \sqrt{\Sigma(X-M)^2/(N-1)}$`, N = 10 people. Two lines later, `$S_M = \sqrt{\Sigma(M-M_{Grand})^2/(N-1)}$` uses N = 80 samples. The "Two Different Counts Are Hiding in This Example" callout later fixes the concept, but the formulas themselves teach the collision. This is precisely the confusion that makes students bomb SEM exam questions (dividing by the wrong count).
- **Fix:** In the S_M formula, replace N with a visually distinct symbol, e.g. $N_{samples}$ (or $k$), and add a parenthetical: "(number of samples — 80 here — not the 10 people inside each sample; see the callout below)". Consider moving the "Two Different Counts" callout up to sit directly beneath this formula instead of its current position in the SEM section.
- **Approved:** [X ] — IMPLEMENTED 2026-08-14. Used $N_{samples}$ (not $k$, which is spoken for later as number of groups/predictors). Both formulas now name their count explicitly: "Here $N$ is the number of people in the sample: 10" under the first, and the $N_{samples}$ = 80 sentence under the second. The "Two Different Counts" callout moved up to sit directly beneath, with one clause added to its last line ("— and that $N$ is back to being the 10 people") so the handoff back to $S/\sqrt{N}$ is explicit. The parenthetical became prose rather than a parenthesis; the closing punchline there is mine and is flagged in-file.

### [CH05-P02] Hard-coded `.957` in the Sample 3 SEM display will silently rot
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_05_Standard_Error.qmd → "What If We Sampled More People?" (search anchor: "\\frac{.957}{\\sqrt{100}}")
- **Problem:** Every other number in the chapter is computed inline (`` `r round(...)` ``), but the displayed SEM formula for Sample 3 hard-codes the SD as .957. If the seed, population, or sample size ever changes, the formula will contradict the computed values beside it — the classic reproducibility failure this book preaches against.
- **Fix:** Replace the hard-coded value with the inline expression (`$S_M = \frac{`r round(SD3,2)`}{\sqrt{100}}$` or equivalent). Verify by rendering that displayed and computed values agree.
- **Approved:** [X ] — IMPLEMENTED 2026-08-14. Renders as $S_M = \frac{0.96}{\sqrt{100}}$ = 0.1, so the old hard-coded .957 was correct to two decimals but is now computed. Also made `SEM3` derive from `SD3` and `SampleSize` instead of recomputing `sd(sample.3)/sqrt(100)` with 100 typed by hand.

### [CH05-U02] Two nearly identical SEM-vs-N plots in a row
- **Priority:** LOW
- **Perspective:** Student + Publisher
- **Effort:** S
- **Location:** Ch_05_Standard_Error.qmd → "Effect of Sample Size" (search anchor: "N_vals <- 10:10000")
- **Problem:** The full-range plot (N to 10,000) and the zoomed plot (N to 400) carry one idea between them: diminishing returns. For a reader with limited attention, two consecutive near-duplicate figures cost a page and dilute the punch; the zoomed one alone (or one figure with a marked "zoom" region) makes the point.
- **Fix:** Either keep only the zoomed 10–400 plot and add one sentence ("past ~400 the curve is basically crawling"), or overlay: full-range plot with a shaded rectangle showing where the second plot zooms. Also note both chunks re-`library(tidyverse)` redundantly — drop the repeats while in there.
- **Approved:** [ X] — IMPLEMENTED 2026-08-14 (option 1). Kept the 10–400 plot only; dropped the redundant `library(tidyverse)` here and in the population-reveal chunk. Also dropped the old `coord_cartesian(ylim = c(0, .2))`, which was clipping the top of the curve — at N=10 the SEM is 0.32, so the steepest and most important part of the curve was being cut off above the panel. The lead-in now says "10 to 400" instead of "10 to 10,000," and the follow-up sentence carries the dropped plot's information inline: going to 10,000 riders buys an SE of 0.01 instead of 0.05.

### [CH05-P03] Sampling people "with replacement" contradicts the story (invisible now, visible after CH05-U01)
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_05_Standard_Error.qmd → sample chunks (search anchor: "sample(CTA.Population, SampleSize, replace = TRUE)")
- **Problem:** The story says "randomly select 10 people"; the code samples with replacement, i.e., the same commuter could be surveyed twice. With N=1,000,000 it changes nothing numerically, but once the code is echoed (CH05-U01) a sharp student will ask, and "with replacement" gets a precise meaning in the Bootstrapping chapter later — better not to muddy it here.
- **Fix:** Change to `replace = FALSE` in the person-sampling chunks (samples 1, 2, 3 and the replicate chunk). Verify rendered numbers barely move and update any inline values that shift (the seed will produce different draws — re-check the "both intervals include the true mean" claim still holds; if not, adjust seeds).
- **Approved:** [ X] — IMPLEMENTED 2026-08-14. All four sampling calls now use `replace = FALSE`. Verified in a standalone script before editing: drawing 10 (or 100) from a population of 1,000,000 gives *bit-identical* results either way for these seeds, so not one number in the chapter moved. M1 = 3.20, M2 = 3.30, M3 = 3.05, empirical SE = 0.34, and both N=10 intervals still contain μ = 3.00. No seeds needed adjusting.

---

**Also done in this pass (approved global items):**

- **G01** (YAML strip): chapter YAML reduced to `title:` only; the dead `fontsize`/`geometry`/`format: pdf` block is gone, and the setup chunk is now one consolidated `opts_chunk$set()` call matching Ch3's.
- **G02** (fig-alt): all seven figures now carry `fig-cap` and `fig-alt`. Captions are the witty half, alt text is literal description, per the item.
- **G05** (code visibility): see CH05-U01. Ch5 now follows the same show-the-statistics/hide-the-plumbing policy as Ch3.
- **G06** (native pipe): four `%>%` swept to `|>`; none remain in this chapter.
- **G08** (inline stats): see CH05-P02. Grepped the chapter — no hard-coded results remain.
- **G12** (deprecated idiom sweep): `geom_errorbarh()` is now **deprecated as of ggplot2 4.0.0** (the review noted it as "still fine"; that is no longer true, and the installed version here is 4.0.3). Replaced with `geom_errorbar(..., orientation = "y")`; `height` became `width`. Output is pixel-identical. **Book-wide note: `geom_errorbarh` should be grepped for in the remaining chapters when G12 runs.**
- **G13** (notation): the N-collision listed under G13 is CH05-P01 above, done.

**Not done (deliberate, for consistency with Ch1–4):** G03 (Short Story already exists here), G04 (self-checks) and G07 (routing callouts) have not been rolled out in any chapter yet and should be done as their own book-wide passes rather than starting here.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; "The Short
Story" exists here ✓ (good).

**Not flagged (deliberate):** The coerced-undergraduate-labor running gag, the Dean's
intervention, and Dorkaos revealing the true population — this is narrative structure doing
real statistical work (single sample → sampling distribution → estimator), and the
CI-interpretation callouts are more correct than most graduate textbooks. The bridge line
into t-tests ("Is this sample consistent with a specific claim?") is exactly the right
cliffhanger — preserve it through any edits.
