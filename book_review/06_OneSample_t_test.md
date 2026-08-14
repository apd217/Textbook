# Chapter 6 — One Sample t-Test (Chapter_OneSample_t_test.qmd)

**Snapshot:** ~4,300 words. The bones are strong (four-step hypothesis-testing framework,
Guinness callout, signal-detection framing for Cohen's d, correct p-value caveats), but this
chapter shows its lecture-slide ancestry more than any chapter so far: stub headings,
orphaned bullets, unexplained examples, and a **broken payoff** — the APA-package output the
text refers to ("the d thing at the end") is commented out, so the text discusses output the
reader never sees. This chapter is also where Chapter 1's "real definition of statistical
significance" IOU should be paid, and it currently isn't, explicitly.

---

### [CH06-P01] The `apa()` output is commented out, but the next sentence refers to it
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "One-sample t-test in APA format" (search anchor: "#apa(Kids.t.test)")
- **Problem:** The chunk loads `library(apa)` and then the actual call `apa(Kids.t.test)` is commented out — presumably to dodge a render error. The very next line says "Wait what is the d thing at the end?" — referring to the Cohen's d in output that does not appear. The reader sees nothing, then is asked to be curious about part of the nothing. This is the hinge sentence that motivates the whole Effect Sizes section, and it's dangling.
- **Fix:** Either (a) uncomment `apa(Kids.t.test)` and fix whatever made it fail (verify by running — likely the apa package's output format in Quarto; `apa::t_apa(Kids.t.test)` may be the working call), or (b) drop the apa package and show the hand-built APA sentence (which already exists later at "APA Style Report") here instead, with the d visibly present, keeping the "wait, what is the d thing?" hook. Option (b) removes a dependency and is more robust; the later APA section then becomes the polished repeat. Either way the sentence must point at output the reader can actually see.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14 via **option (b)**, and option (a) turns out to be impossible. Ran it: the `apa` package errors with "`cohens_d` does currently not support t-tests with mu != 0. Please substract mu before passing the values to `t.test`" — which is presumably why it was commented out in the first place. Making it work would mean subtracting 50 before calling `t.test()`, destroying the $\mu = 50$ teaching point. So: dropped `library(apa)`, built the APA line by hand with inline values, and kept the "wait, what is the $d$ thing" hook now pointing at a visible $d$. Renders as $t(35) = 4.18$, $p < .001$, 95% CI [51.56, 54.51], $d = 0.70$.

### [CH06-P02] Pay off Chapter 1's IOU: give the formal p-value definition here, in a box
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "Test Statistic Result" (search anchor: "we can see our exact p-value which is well below")
- **Problem:** Chapter 1 explicitly promises a "real definition" of statistical significance "after you learn some probability theory." The clean definition currently lives in a side remark in the Probability chapter; this chapter — the first actual hypothesis test — uses p-values without ever formally defining one. The Short Story says what p is *not* (good) but the chapter never crisply says what it *is* at the moment of first use.
- **Fix:** Add a `callout-important` box at first p-value use: "**The p-value, actually defined (the IOU from Chapter 1):** the probability of getting a test statistic this far from the null value — or farther — *if* the null hypothesis and the model's assumptions were true. It is a statement about the data under an assumption, not about the probability the hypothesis is true." Then one sentence connecting to the shaded-tails figure already in the chapter (the p-value is the area beyond your observed t, both tails). Cross-reference back to Chapter 1's IOU so the promise-payoff loop closes (pairs with item CH01-P01).
- **Approved:** [x ] — IMPLEMENTED 2026-08-14. Added a `callout-important` titled "The p-Value, Actually Defined (That IOU from Chapter 1)" right after the first exact-p-value sentence. It names the Chapter 1 promise, gives the definition, points back at the shaded tails in the critical-region figure directly above it, and closes with the three things a p-value is not. Placed before the confidence-interval sentence so the definition arrives before the reader has to use it.

### [CH06-U01] Hypotheses are never written symbolically — the curriculum and the exam will
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "Non-directional Hypothesis" (search anchor: "Chocolate chip cookies do not change children's level")
- **Problem:** 242 Week 9 teaches "Setting up null (H0: mu = mu0) and alternative hypotheses (H1: mu != mu0)." The book states hypotheses only in words. Students then meet $H_0: \mu = \mu_0$ notation on centrally written exams with no bridge from the book. The words-first approach is right; the symbols just need to appear beside them.
- **Fix:** After each verbal hypothesis pair, add the symbolic version: non-directional $H_0: \mu = 50$, $H_1: \mu \neq 50$ (using the cookie study's actual 50); directional $H_0: \mu \le 50$, $H_1: \mu > 50$. One line each, immediately after the existing prose versions.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. Both symbolic pairs added under their verbal versions: directional $H_0: \mu \le 50$ / $H_1: \mu > 50$, non-directional $H_0: \mu = 50$ / $H_1: \mu \neq 50$, preceded by one line naming $\mu$ and saying where the 50 comes from. Kept deliberately joke-free (this is the one spot where the book should look exactly like the exam), with a note to Alex marking where a joke could go instead.

### [CH06-U02] Type I / Type II examples are named but never explained
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "Type I Error" (search anchor: "Testing zinc or ColdEase on colds")
- **Problem:** "**Example:** Testing zinc or ColdEase on colds using self-report as a measure of improvement." — and that's it. The reader must already understand Type I error to see why this is an example of it (colds resolve anyway + self-report bias → "improvement" that isn't the treatment). Same for kava tea under Type II (real but small calming effect + noisy stress measures + small n → missed). These are good examples with their explanations amputated. The Week 10 curriculum leans on concrete scenarios (courtroom analogy) — the book should carry its share.
- **Fix:** Give each example two sentences of mechanism, e.g. Type I: "Colds get better on their own, and people who paid for zinc lozenges want to believe. A study can 'detect' improvement that is really regression to the mean plus wishful self-report — rejecting a true null." Type II: "Kava may genuinely reduce stress a little, but with ten stressed undergraduates and a noisy mood scale, the study can't hear the signal — failing to reject a false null." Also consider adding the courtroom analogy the TAs will use in lab (false conviction = Type I, false acquittal = Type II) so book and lab speak the same language.
- **Approved:** [x ] — IMPLEMENTED 2026-08-14. Both examples got their mechanism restored (zinc: colds end on their own plus hopeful self-report, so the study "detects" the cold ending on schedule; kava: a real but small effect, ten undergraduates, a noisy mood scale). Each closes by naming which null did what. Added the courtroom callout the TAs use, and linked it forward from the Judge Dredd polygraph passage already in the Probability chapter so the book has one image for this, not two unconnected ones.

### [CH06-P03] Causal overclaim in the decision rules for a design with no control group
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "Make a Decision" (search anchor: "the treatment has *likely* caused a difference")
- **Problem:** "Reject the null… indicates that the treatment has *likely* caused a difference between the population and the sample." In this design every child got cookies and the comparison is a hypothesized population value — rejecting H0 says the sample is inconsistent with μ=50, not that cookies caused anything (maybe these 36 kids differ from the population in other ways; there's no random assignment, no control). The chapter's own "Important Note" section makes exactly this point earlier, so the decision rule contradicts the chapter's best paragraph. Also the parenthetical "(See Bayesian Statistics)" dangles — there is no Bayesian chapter to see.
- **Fix:** Reword to: "This indicates the sample mean is farther from the hypothesized value than random sampling error can comfortably explain. Whether the *cookies* did it is a design question, not a statistics question — see the Important Note above." Delete or replace "(See Bayesian Statistics)" with a pointer to the Bayes section of the Probability chapter if the falsification-asymmetry point is kept.
- **Approved:** [ ] — NOT IMPLEMENTED (box left unchecked). Flagged inline in the chapter with an `<!-- ALEX -->` comment anyway, since the causal wording and the "(See Bayesian Statistics)" pointer both sit two lines apart and both are one-line fixes whenever you want them.

### [CH06-P04] Code hygiene: object named `sample`, constant added via `rnorm(n, mean=2, sd=0)`, stray `var.equal` in a one-sample test
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → data-generation chunk (search anchor: "kids.1<-sample+rnorm(n,mean=2,sd=0)")
- **Problem:** Three teaching-by-example problems in one chunk: (1) an object is named `sample`, shadowing the base function `sample()` used on the previous line — a classic student footgun the book itself should not model; (2) adding a constant effect via `rnorm(n, mean=2, sd=0)` is a zero-variance normal draw — obscure where `+ 2` is transparent (or `sd` > 0 if individual variability in the effect was intended — as written it's pure constant); (3) the `t.test()` call passes `var.equal = FALSE`, an argument that does nothing in a one-sample test and teaches students to cargo-cult arguments they don't understand.
- **Fix:** Rename `sample` → `kids.sample`; replace `+ rnorm(n, mean=2, sd=0)` with `+ 2` and a comment `# every kid gets a 2-point cookie boost (the true effect)`; drop `var.equal` (and `conf.level = 0.95`, which is the default, unless Alex wants it explicit for teaching — then keep with a comment). Verify by running; inline stats should be unchanged (same seed, same values).
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. `sample` renamed to `kids.sample`; `+ rnorm(n, mean=2, sd=0)` replaced with `+ 2` and the drafted comment; `var.equal` dropped; `conf.level` kept with a comment noting it is the default. Verified with `identical()` against the old code before editing: TRUE, so every inline statistic in the chapter is unchanged (M = 53.035, SD = 4.356, t = 4.181). Also split the data generation out of the histogram chunk and named both.

### [CH06-B01] Slide-deck residue: stub headings and orphaned fragments
- **Priority:** MED
- **Perspective:** Publisher + Student
- **Effort:** M
- **Location:** Chapter_OneSample_t_test.qmd → multiple (search anchors: "### State the Hypothesis" [empty stub directly above "### The Null Hypothesis"], "### Sample Experiment", "Estimation of Variance:  we will never know")
- **Problem:** The chapter's midsection is visibly converted lecture slides: `### State the Hypothesis` is an empty heading whose only content is the next heading; `### Sample Experiment` likewise; the "Why the t-Distribution?" section is three bullets where the third ("Degrees of Freedom…") has lost its bullet and runs on; "Adjusting the Critical Region" has a list that will render as a run-on because there's no blank line before the `-` items. In the web format the TOC/sidebar will show duplicate-feeling stubs. It reads like a deck, not a book — and this is the chapter students will read most desperately (night before Exam 1).
- **Fix:** One editorial pass over the section from "4 steps for hypothesis testing" through "The Impact of Sample Size": delete the two stub headings (promote their children), restore the broken bullet, add blank lines before lists (grep the chapter for `:\n-` patterns), and convert single-bullet "sections" into ordinary paragraphs. No content changes — structure only. Verify by rendering and eyeballing the HTML TOC.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. Deleted both stub headings (`### State the Hypothesis`, `### Sample Experiment`) and promoted their children. Restored the lost bullet on Degrees of Freedom. Added the missing blank line before the "Adjusting the Critical Region" list so it stops rendering as a run-on. Fixed the "Estimation of Variance:  we will never know … ($\sigma$). so we must" punctuation. Structure only, no content changed. Verified the HTML TOC no longer shows the two empty stubs.

### [CH06-U03] Typo sweep — this chapter has the densest cluster so far
- **Priority:** MED
- **Perspective:** Student + Publisher
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → multiple (search anchors below)
- **Problem / Fix (list):**
  - "It just tells you that is not probably not due the chance" → "It just tells you the result is probably not due to chance" (search: "not probably not due the chance") — double negative currently says the opposite of what's meant.
  - "Here is plot for kids.1" → "Here is a plot of kids.1" (search: "Here is plot for kids.1")
  - "Here is  an example of our the boundaries shift" → "Here is how the boundaries shift" (search: "example of our the boundaries")
  - "another way of telling our results is greater than chance" → "another way of seeing that our result is bigger than chance alone would produce" (search: "telling our results is greater")
  - "We don't need as much of a \"safety buffer." → close the quote (search: "safety buffer.")
  - "which we expect to have a random but generally positive effect" — as written this describes the DV having an effect; presumably the cookies have the effect on the DV (search: "random but generally positive effect").
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. All six fixed as drafted. Also dropped the stray "Reduced Uncertainty:" label that turned that same sentence into a double colon.

### [CH06-P05] Signal detection origin: radar, not "the invention of the radio"
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "Effect Sizes" (search anchor: "created during the invention of the radio and radar")
- **Problem:** SDT's canonical origin is WWII-era radar operators (Tanner, Swets, Green; 1950s psychophysics) — "invention of the radio" (1890s–1900s) is the wrong era and will make a psychophysicist wince. The story is worth keeping; just aim it right.
- **Fix:** "…borrowed from signal detection theory, developed for radar operators in World War II who had to decide whether that blip was a plane or noise." One sentence, and it's a better story anyway.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14 using the drafted sentence verbatim.

### [CH06-U04] The two d-formulas differ without comment (σ of noise vs. S of the treated sample)
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_OneSample_t_test.qmd → "Cohen's $d$" (search anchor: "d = \\frac{M_{H1}-\\mu_{H0}}{S_{H1}}")
- **Problem:** The SDT display divides by $\sigma_{(Noise)}$; the applied Cohen's d divides by $S_{H1}$ (the treated sample's SD). The "implicit assumption" note about equal σs technically licenses the swap, but the reader is left to make that connection alone, and in the one-sample test you only *have* the one SD. One sentence would close the gap.
- **Fix:** After the Cohen's d formula add: "We divide by the sample's SD because it's the only SD we have — and under the equal-spread assumption above, it's also our best guess at the noise." 
- **Approved:** [ x] — IMPLEMENTED 2026-08-14. Sentence added directly under the Cohen's $d$ formula, naming the swap explicitly: SDT divides by $\sigma_{(Noise)}$, we divide by the sample's own SD because it is the only one we have, and the equal-spread assumption above licenses it.

---

**Also done in this pass (approved global items):**

- **G01** (YAML strip): reduced to `title:` only; setup chunk consolidated into one `opts_chunk$set()` call. Global `echo = TRUE` kept, since this chapter is meant to show its code.
- **G02** (fig-alt): all eight figures now carry `fig-cap` and `fig-alt`, and every chunk is named. The four effect-size chunks also had their `fig.width`/`fig.height` moved from the chunk header into `#|` options.
- **G06** (native pipe): the one `%>%` in the kable chunk swept to `|>`.
- **G08** (inline stats): both APA lines now render $d = 0.70$ rather than `0.7`. The raw `round(x, 2)` was dropping the trailing zero, which is wrong in a report students copy as a model for graded work; now wrapped in `format(..., nsmall = 2)`.

**Em-dash reduction (Alex's request, 2026-08-14):** the chapter had seven em-dashes; five were the explanatory-dash pattern and were rewritten as commas, colons, or full stops. The two survivors are legitimate: the elephant dialogue and the parable attribution. No new em-dashes were introduced anywhere in this pass, including inside the new callouts.

**Not done (consistent with Ch1–5):** G03 (Short Story present ✓), G04 (self-checks) and G07 (routing callout already present here, and it is the model other chapters should copy).

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; Short Story ✓ present.

**Not flagged (deliberate):** The elephant parable placement (before the formal logic) is
good sequencing; the Guinness/Gosset callout is the right length; the four overlapping-curves
effect-size figures are worth their page cost because "even huge effects overlap" is the
single most misunderstood fact about effect sizes; and the "Which t-Test Comes Next?" 
routing callout at the end is a pattern OTHER chapters should copy (see cross-cutting notes).
