# Chapter 10 — Covariance and Correlation (Chapter_Covariance and Correlation.qmd)

**Snapshot:** ~2,800 words. The variance → covariance → correlation progression matches the
Week 7 curriculum beat-for-beat, and the scale-change series (add constant / z-score /
nonlinear) is a genuinely good teaching sequence. But this chapter has the heaviest
lecture-slide residue in the book — rhetorical questions that are never answered on the page
("Why is it the same number?", "What does this mean?"), one **wrong-variable code bug**
(`var(Z)` where `var(A)` is meant), and a formula bullet that states a perfect-correlation
identity as if it were general. It also pointedly refuses to give Cohen's r benchmarks that
the curriculum (and the centrally written exam) teach.

---

### [CH10-P01] Code bug: "No Relationship" section computes `var(Z)` instead of `var(A)`
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_Covariance and Correlation.qmd → "No Relationship" (search anchor: "A = c(2,5,3,1,4)")
- **Problem:** The section introduces variable `A`, then the visible, echoed chunk runs `var(X); var(Z)` — showing the variance of `Z` from the *previous* section while claiming to check A's variance. It happens to print 2.5 (same value), so nobody caught it, but the code is wrong on the page students are told to run. Two lines later the "Why Zero?" walkthrough calls the same variable "Y" ("Old: X=…, Y=2,5,3,1,4") — three names for one variable in half a page.
- **Fix:** Change `var(Z)` → `var(A)` in that chunk; rename "Y" → "A" in the "Why Zero?" deviations walkthrough. Verify by rendering.
- **Approved:** [x] — IMPLEMENTED 2026-08-15. Both halves done. The chunk now prints `var(X)` and `var(A)`, and the rendered output confirms 2.5 and 2.5 with `cov(X,A)` = 0. The "Why Zero?" walkthrough now says A throughout, and the closing line reads "no linear relationship between X and A" instead of X and Y.

### [CH10-U01] Rhetorical lecture prompts are never answered on the page
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_Covariance and Correlation.qmd → "Identical Variables" and following sections (search anchors: "Why is it the same number?", "- What does this mean?", "Variances haven't changed?")
- **Problem:** These are Alex's lecture beats — in class, he asks and then *tells them*. On the page, "What's Cov(xy)? … Why is it the same number?" is followed by the next heading. A confident reader shrugs; the struggling reader assumes they missed something and rereads (the exact behavior this book exists to prevent). There are at least five dangling prompts in this stretch: "Why is it the same number?", "What does this mean?" (×2), and two "Variances haven't changed?" fragments (which also read as broken sentences).
- **Fix:** After each prompt, add the 1–3 sentence answer, e.g. for "Why is it the same number?": "Because covariance of a variable *with itself* is just variance — look at the variance formula above: it's already written as $\Sigma(X-M_X)(X-M_X)/(n-1)$. Replace one of those X's with a perfect copy called Y and nothing changes. Variance is self-covariance; that's the punchline of this whole chapter." For the "What does this mean?" after the negative-covariance plot: point at the downhill pattern and the sign. Convert "Variances haven't changed?" fragments into statements ("Notice the variances haven't changed — we only reshuffled the pairing."). Optionally use collapsible callouts (`collapse="true"`, titled "Think first, then click") to preserve the think-first pedagogy in HTML while still delivering answers.
- **Approved:** [x] — IMPLEMENTED 2026-08-15. All five prompts now answer themselves on the page. "Why is it the same number?" gets the drafted self-covariance answer, pointing back at the third form of the variance formula and closing on "Variance is covariance with yourself." Both "Variances haven't changed?" fragments became statements that also say *why* (reversing or reshuffling five numbers does not change their spread). Both "What does this mean?" prompts now lead into their plot with a sentence naming the pattern.
  **DEVIATION:** used plain prose, not collapsible callouts. Two reasons: `collapse` does nothing in the PDF, so the two formats would diverge, and VOICE_GUIDE §0 favours the blunter option. Easy to convert later if you want the think-first version.

### [CH10-U02] The book refuses r benchmarks; the curriculum and exam teach them
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Covariance and Correlation.qmd → "Correlations" (search anchor: "Universal small, medium, and large labels are rarely useful.")
- **Problem:** 242 Week 7 Class 2 explicitly teaches "Interpreting r: direction, magnitude, Cohen's benchmarks (.10 small, .30 medium, .50 large)" — and exams are centrally developed across sections. The book's only comment is that universal labels "are rarely useful." That's a defensible scholarly position that will cost students exam points. The d chapters found the right compromise: give the table, then the "conventions, not laws" callout. This chapter should do the same.
- **Fix:** Add the standard table (r = .10 small / .30 medium / .50 large, cite Cohen 1988) immediately followed by the skepticism the chapter already has — ideally reusing the "These Adjectives Are Conventions, Not Laws" framing from the Power chapter with an r-specific example ("a .10 correlation between a cheap screening question and later dropout can be worth millions; a .45 correlation between two questionnaires that share half their items is worth nothing"). Keep the crud-factor Meehl paragraph right after — it's the perfect chaser.
- **Approved:** [x] — IMPLEMENTED 2026-08-15. The .10/.30/.50 table is in, cited to @cohen1988, introduced with "you will be expected to know these" so the exam relevance is explicit. Directly beneath it sits a `callout-warning` reusing the Power chapter's exact title, "These Adjectives Are Conventions, Not Laws," and opening by naming that callback, since Power now sits at position 7 and the reader has met it. The r-specific example is the drafted one: .10 screening question versus .45 between two questionnaires sharing half their items. The old "rarely useful" bullet is gone, its surviving clause folded into the callout's last line. Meehl's crud factor still follows immediately.

### [CH10-P02] Covariance Review states the perfect-correlation identity as if general
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Covariance and Correlation.qmd → "Covariance Review" (search anchor: "When the variances of X and Y aren't equal, $Cov(xy)=\\sqrt{Var(x) * Var(y)}$")
- **Problem:** As bulleted, "When the variances of X and Y aren't equal, Cov(xy)=√(Var(x)·Var(y))" reads as a general fact. It's true only when the relationship is *perfect* (it's the Cauchy–Schwarz upper bound, |Cov| ≤ √(VarX·VarY), with equality at r = ±1). A student who memorizes the bullet as written has learned something false; a grad student misses the one genuinely useful nugget here — that this bound is *why* r is trapped between −1 and +1.
- **Fix:** Rewrite the bullet pair: "When the relationship is perfect and variances are equal, Cov(xy) = Var(x) = Var(y). When the relationship is perfect but variances differ, Cov(xy) = √(Var(x)·Var(y)) — that's the biggest covariance can ever get. Covariance can never exceed √(Var(x)·Var(y)), and dividing by that maximum is exactly what correlation does — which is why r cannot escape [−1, +1]." That last sentence turns a fix into a payoff: it pre-derives the Pearson formula that appears one section later.
- **Approved:** [x] — IMPLEMENTED 2026-08-15 using the drafted text, em-dashes translated per VOICE_GUIDE §14. The four bullets now separate the equal-variance case, the unequal-variance case (named as the maximum, not as a general identity), the inverse case, and the zero case. The closing sentence carries the payoff: covariance cannot exceed that bound, dividing by the maximum is what correlation does, so $r$ cannot escape [−1, +1]. I also rewrote the inverse bullet from $-Cov(xy)=\sqrt{\cdot}$ to $Cov(xy)=-\sqrt{\cdot}$, which is the same claim with the negation where a reader will actually see it.

### [CH10-U03] Restriction of range is in the curriculum, not in the chapter
- **Priority:** MED
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_Covariance and Correlation.qmd → after "Pearson's correlation is scale-independent!" (search anchor: "the correlation will change.")
- **Problem:** Week 7 Class 1 teaches "the third-variable problem; directionality; restriction of range; Simpson's paradox." The chapter handles third-variable and directionality (ice-cream/happiness causation passage + closing callout) but never touches restriction of range — the one on the list that's a *statistical* property of r rather than a design concept, i.e., squarely this chapter's job. It's also a five-line simulation: correlate two variables at r = .6, then filter to the top third of X and watch r collapse.
- **Fix:** Add a short section "When You Only See Part of the Picture: Restriction of Range": reuse `CorrData`, subset `Happiness > quantile(.66)` (framed as "we only surveyed people already at the ice-cream shop"), show the scatterplot pair and the shrunken r. Two-sentence moral: selective samples flatten correlations; this is why correlations among admitted students / hired employees / surviving participants routinely underwhelm. One forward sentence: Simpson's paradox (groups reversing a trend) waits for the multiple-regression chapters. Verify by running.
- **Approved:** [x] — IMPLEMENTED 2026-08-15, verified by running before writing. Full sample $r = .60$; keeping only the top third leaves 34 people and $r = .45$, with the SD of IceCream collapsing from 1.00 to 0.72. The chunk prints both SDs so the *mechanism* is visible and not just the shrunken r. Both panels are drawn on identical axes, so the truncation is the thing you see. All reported numbers are inline `r` expressions (G08), with a two-line `apa.r()` helper so they print as .60/.45 rather than 0.6/0.45. Moral and the Simpson's-paradox forward pointer are both in.
  **TWO DEVIATIONS.** (a) Placed after the scale-change series rather than at the literal anchor. Dropping it right after "the correlation will change" would have split the four scale-change demos in half; at the end of that run it lands as the contrast the series has been building toward, which is "rescaling leaves $r$ alone, deleting range does not." (b) Selected on `IceCream`, not `Happiness` as the item's code says. The item's own framing, "we only surveyed people already at the ice-cream shop," is selection on ice cream, and selecting on the predictor is the canonical restriction-of-range setup. Selecting on Happiness instead gives $r = .36$, a larger drop, if you prefer the more dramatic number.

### [CH10-U04] The mvrnorm simulation is described in prose but the code is hidden
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Covariance and Correlation.qmd → "Simulate Data" (search anchor: "We will use the `mvrnorm` function")
- **Problem:** The text says "We will use the `mvrnorm` function… we need to make a covariance matrix with r = .60" — and then the chunk is `echo=FALSE`, so the reader is told about code they cannot see. The chunk is short, heavily commented (the comments are good!), and making correlated fake data is a skill 343 students will actually reuse for their replication projects. Same disease as CH03-U01/CH05-U01.
- **Fix:** Set `echo=TRUE` on the simulation chunk (both this one and the 4-variable matrix chunk later, which has the same problem). Optionally add one sentence: "With unit variances, this covariance matrix is also the correlation matrix — a freebie that will matter later."
- **Approved:** [x] — IMPLEMENTED 2026-08-15. Both chunks are now `echo=TRUE`: the two-variable `mvrnorm` simulation and the four-variable matrix later in the chapter. Alex's existing comments inside them do the explaining, so no new code commentary was needed. The optional sentence is in, em-dash translated to a comma.

### [CH10-B01] Typo/formatting sweep
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Covariance and Correlation.qmd → multiple
- **Problem / Fix (list):**
  - "Perfect negative covariance yields a $r$= *-1" and "yields a $r$= *-0" — stray asterisks and a "−0"; should be "yields $r = -1$" / "No systematic covariance yields $r = 0$" (search: "yields a $r$= *-1").
  - "# Add regressin line" — misspelled comment copy-pasted into ~8 chunks; fix with replace-all "regressin" → "regression".
  - "### Pearson's: Let visualize our result" → "Let's visualize" (search: "Let visualize").
  - `CorrData$Happiness<-CorrData$Happiness # orginal` — a no-op line with a typo; delete it (search: "# orginal").
  - "-Like for stats/like for Alex" bullet is missing its space after the dash and renders wrong (search: "-Like for stats").
  - "remember $SS = (X-M)^2$" → "$SS = \Sigma(X-M)^2$" (search: "remember $SS =").
- **Approved:** [x] — IMPLEMENTED 2026-08-15. All six done. "regressin" → "regression" fixed in all 8 chunks (grep confirms zero remaining book-wide). The three $r$ bullets now read $r = +1$ / $r = -1$ / $r = 0$. "Let visualize" → "Let's visualize". The no-op `# orginal` line is deleted. The "-Like for stats" bullet no longer exists as a bullet: CH10-B02 turned that whole block into prose, which fixes the missing space by removing the construction.
  **ONE EXTRA, flagged for your call:** the "Why the Sign Flips" cross-product list read `$-2*2, -1*1, 0, 0, 1*-1, 2*(-2)$`, which is six terms for five pairs. The "0, 0" is a comma where a `*` belongs. Now written as five explicit products, `(0 * 0)` included. This was not in the item's list, but it sits inside CH10-B02's rewrite range and it is arithmetic on the page, so I fixed it rather than leave it. Revert if you meant it.

### [CH10-B02] Slide-residue structure pass (same treatment as CH06-B01)
- **Priority:** MED
- **Perspective:** Publisher + Student
- **Effort:** M
- **Location:** Chapter_Covariance and Correlation.qmd → "Variance" through "Covariance Review" (search anchor: "- Variance is our primary measure of spread.")
- **Problem:** The formal middle of the chapter is bullet-fragments from slides ("- Why would we do this? Let's start with an illustrative example."), one-bullet sections, and headings that exist only to pace a lecture ("### Perfect Positive Relationship" contains one sentence + one chunk). Reads like speaker notes; in the HTML sidebar it produces a noisy TOC.
- **Fix:** Convert bullet-fragments to short paragraphs; merge the "Perfect Positive/Identical/Perfect Negative/No Relationship" sequence under one section with bolded sub-steps or keep `###` but give each a complete opening sentence. Do together with CH10-U01 (answering the prompts), since they touch the same lines. No content changes.
- **Approved:** [x] — IMPLEMENTED 2026-08-15, in one pass with CH10-U01 as instructed. The Variance and Covariance openers are now short paragraphs instead of stacked fragments, and each of the four relationship sections opens with a complete sentence that states its setup rather than listing it. The `###` headings were kept: they are doing real navigational work in a chapter this long, and merging them would have made the HTML sidebar worse, not better. One sentence was added to the Variance section pointing at the third form of the formula, which is what CH10-U01's self-covariance answer later depends on. No statistical content changed.

### [CH10-P03] Spearman section: tell them when ties make `exact=TRUE` fail
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Covariance and Correlation.qmd → Spearman chunks (search anchor: "method = c(\"spearman\"), exact =TRUE")
- **Problem:** The final Spearman call uses `exact=TRUE` with a code comment about approximation, but with tied ranks R refuses exact computation and warns (warnings are globally suppressed here, so the book silently falls back). Real student data (Likert scales!) always has ties; the first thing they'll see at home is a warning the book never mentioned.
- **Fix:** Add two sentences: with ties, R cannot compute an exact p-value and will warn you and use the t-approximation — this is fine, not a mistake; Likert-scale data always ties. (Also note the rank-then-Pearson demo prints "r" in the APA output because we literally ran Pearson on ranks — one sentence so students don't think `cor_apa` mislabeled it.)
- **Approved:** [x] — IMPLEMENTED 2026-08-15, both halves. The ties note sits under the `exact = TRUE` chunk and says three things: it works *here* because these nine values have no ties, with ties R cannot compute an exact p-value and falls back on the t-approximation with a warning, and Likert data ties constantly so expect it. Verified the behaviour before writing: the chapter's own `CorrNL` has no ties and raises nothing, while a 40-row Likert sample raises "cannot compute exact p-value with ties" exactly as described. The rank-then-Pearson sentence is in, placed directly under that chunk's output.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`; Short Story ✓ present.

**Globals done in the same pass (2026-08-15):**

- **G01** (already approved): YAML stripped to `title:` only. The dead `fontsize`, `geometry`, and per-chapter `pdf` block are gone, so the chapter now inherits `_quarto.yml` (confirmed: it renders at `1.1rem` instead of the stripped `11pt`). The six repeated `opts_chunk$set()` calls were folded into one, matching the Part 1 chapters.
- **G02** (already approved): every figure has `fig-alt`. All 16 images in the rendered HTML carry alt text, verified by grep. Captions were not touched.
- Every chunk is now named. The chapter had 20 anonymous chunks, which meant `unnamed-chunk-N` figure filenames that shift whenever a chunk is added or removed, quietly invalidating the freeze cache. Names are stable.

**KNOWN ISSUE, pre-existing, not caused by these edits: this chapter cannot build to PDF from a clean checkout.**
The book PDF fails with `Unable to load picture or PDF file 'Chapter_Covariance-and-Correlation_files/figure-pdf/...'`. Cause: `*_files/` is gitignored, and for the two chapters whose *filenames contain spaces* the freeze cache does not preserve `figure-pdf`. Quarto rewrites `Chapter_Covariance and Correlation` to `Chapter_Covariance-and-Correlation` for processing, and the supporting-files bookkeeping does not survive that rename, so nothing gets restored and LaTeX finds no figures. Compare `_freeze/Chapter_Control/execute-results/tex.json`, whose `supporting` entry is `Chapter_Control_files\figure-pdf` *and whose figures are stored*, against this chapter's, which names a directory that was never saved.

Confirmed pre-existing: with all of these Chapter 10 edits stashed, the book still fails to build to PDF, at `Chapter_Regression with Cat Variables` instead. Those are the only two chapter filenames containing spaces, and they are the only two that fail. It works on Alex's machine because the gitignored `*_files/` directories are still sitting there from earlier renders.

The fix is to rename both files to remove the spaces (and update the two entries in `_quarto.yml`). That is a structural change across two chapters, so it is left for Alex to approve rather than folded into a chapter edit. HTML is unaffected and renders clean.

**Not flagged (deliberate):** The self-covariance route into correlation (variance → covariance
of identical variables) is the best conceptual path available and matches the Week 7 lab's
hand-calculation exercise. The bivariate-normality paragraph is more careful than most grad
texts. The Meehl crud-factor citation, the Ballantine disclaimer ("not auditioning for an
engineering degree"), and the U-shaped "laughing at you" line all stay.
