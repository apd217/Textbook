# Chapter 22 — Pearson's Chi-Square (Ch_34_Chi_Square.qmd)

**Snapshot:** ~4,000 words. Strong content: the Best (1979) answer-changing study is a
perfect running example, the simulate-the-null intuition (10,000 fake guessers before
showing the χ² density) is the book's philosophy at its best, and the effect-size / odds-
ratio / power extensions go beyond most intro treatments. Two structural problems: the
chapter still **talks like it's week 4 of 242** ("we will return to the logic of hypothesis
testing later in the semester") even though it now sits deep in Part 4 after nine chapters
of hypothesis testing — and a numeric inconsistency (127.14 vs 124.14) is propagated through
the APA reports.

---

### [CH22-P01] 127.14 or 124.14? The hand calculation and the APA reports disagree
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Ch_34_Chi_Square.qmd → "Goodness of Fit Calculation by Hand" (search anchor: "= 127.14") and "Our results?" / APA sections (search anchors: "124.14 (experimental value we got)", "N = 222) = 124.14")
- **Problem:** The hand calculation correctly gives χ² = (84²+84²)/111 = 127.14. The decision sentence and *both* APA write-ups then report 124.14 — three times. `chisq.test()` will print ~127.13, so the student sees the hand value, the code value, and the reported value disagree, in the section teaching them to report numbers accurately.
- **Fix:** Correct all instances to the computed value (ideally make them inline: `` `r round(MCQ.chi$statistic, 2)` ``, which prevents recurrence). Also upgrade "p < .05" to the exact-p convention the t-test chapters teach ("In modern APA format, report the exact p-value") — here p < .001. Verify by rendering.
- **Approved:** [x] — IMPLEMENTED 2026-08-17. Every chi-square value in the chapter is now
  inline. A hidden `stored-values` chunk at the top of the file builds `MCQ.chi`,
  `MCQ.chi.2` and `MCQ.chi.2.plain` so the prose can reference them *before* the reader
  builds them in the visible "by code" sections (knitr evaluates inline expressions in
  document order, so the item's suggested inline could not have worked on its own).
  `124.14` is gone from the rendered HTML: verified 127.14 in all seven places, and
  `chisq.test()` prints the same. p upgraded to `p < .001` (actual $p = 1.7 \times
  10^{-29}$, printed as words rather than inline to avoid the scientific-notation
  caret bug). Two extra things swept into the same sentences: `` `r Crit.MCQ` `` was
  rendering as `3.84145882069413` in three places and is now rounded to 2 dp, and the
  APA percentages were truncated rather than rounded (87.83/12.16), now inline at
  87.84/12.16.

### [CH22-B01] Stale course-sequence language: the chapter believes it comes *before* hypothesis testing
- **Priority:** HIGH
- **Perspective:** Publisher + Student
- **Effort:** S
- **Location:** Ch_34_Chi_Square.qmd → multiple (search anchors: "We will return the logic of hypothesis testing in more detail later in the semester.", "### Parametric Tests (coming later)", "later we’ll formalize how they connect to tests like t and F", "which the advanced chapter later in this book handles")
- **Problem:** This chapter was clearly written for an early-242 slot (chi-square as the first hypothesis test) and was moved to Part 4 without updating its self-references: it promises hypothesis-testing logic "later in the semester" (the reader finished it nine chapters ago), labels parametric tests "(coming later)" (they came), promises t and F will be formalized "later" (they were), and defers multiplicity to "the advanced chapter later in this book" (Multiple Comparisons is *earlier* in book order). For a reader this is disorienting; for an instructor evaluating the book it looks unedited.
- **Fix:** Sweep the chapter's temporal references to match its actual position: "(coming later)" → "(the t-tests and regression you've already met)"; "we will return… later in the semester" → "you know this logic from the t-test chapters — chi-square runs the same play with counts"; "later we'll formalize" → backward reference; "the advanced chapter later" → link to Ch_20_Multiple_Comparisons.qmd. Alternatively — Alex's call, see the ordering discussion in 00_OVERVIEW.md — this chapter genuinely could serve as an early gentle-intro to hypothesis testing (its null-simulation build-up is self-contained); but then the *other* chapters' text needs checking instead. Fixing the references in place is the cheaper, recommended path.
- **Approved:** [x] — IMPLEMENTED 2026-08-17. **Alex chose "fix the references in place"**
  on 2026-08-17 when asked; the move-the-chapter option is declined, not pending.
  Four references swept: "(coming later)" → "(everything up to this point)"; "later we'll
  formalize how they connect to tests like t and F" → "the mean and SD from Part 1 are what
  every *t*-test, *F*-test, and regression you have run since then is built out of";
  "we will return the logic of hypothesis testing later in the semester" → "You already
  know this logic from the *t*-test chapters. Chi-square runs the same play with counts
  instead of means."; "the advanced chapter later in this book" → a live link to
  [Multiple Comparisons](Ch_20_Multiple_Comparisons.qmd), which is now *earlier*.
  The link is also used a second time in the new residuals section (CH22-U01). Both
  resolve to `./Ch_20_Multiple_Comparisons.html` in the rendered book, verified.
  "(this chapter and the next)" on the Nonparametric heading was checked and is still
  accurate.

### [CH22-P02] Mid-chapter APA reports the uncorrected 16.08 while the adjacent code runs Yates (15.57)
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_34_Chi_Square.qmd → two-way APA (search anchor: "N = 1379) = 16.08") vs. the corrected test (search anchor: "correct = TRUE")
- **Problem:** The hand calculation (16.08, uncorrected) is reported in the mid-chapter APA sentence, then the R section runs `correct = TRUE` and prints 15.57 with no comment; only the final "Reporting the Result" section reconciles them ("state your choices"). A student comparing the mid-chapter APA to the output above it sees an unexplained mismatch for several pages.
- **Fix:** At the mid-chapter APA, add one sentence: "This matches our hand calculation, which used no continuity correction; R's default output below will differ slightly — we'll sort that out in a moment." Or run `correct = FALSE` first to match the hand value, then introduce Yates as the deliberate follow-up. Either way the reconciliation should happen at first contact, not two sections later.
- **Approved:** [x] — IMPLEMENTED 2026-08-17, both halves of the item rather than either/or,
  because the flag alone still left the reader looking at two numbers. The mid-chapter APA
  now carries a forward flag ("That hand calculation used no continuity correction, and
  R's default for a 2×2 table does... Nothing is broken; we sort it out when it happens"),
  and immediately under the `correct = TRUE` output the chapter names the gap, runs
  `chisq.test(correct = FALSE)` to land back on 16.08, and says neither number is the
  wrong one as long as you report which you ran. Both values are inline, so they cannot
  drift apart again.

### [CH22-B02] Typo/labeling sweep
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_34_Chi_Square.qmd → multiple
- **Problem / Fix (list):**
  - `dimnames(MCQ.Study.2) <- list(Social = c("Easy","Diff")…)` — the dimension is item difficulty, not "Social" (copy-paste residue from another dataset); rename to `Difficulty` (search: "Social = c(\"Easy\"").
  - "The way above if the hard way and shown you understand what the computer is doing" → "The way above is the hard way, and shows you understand…" (search: "The way above if the hard way").
  - "If we have diferent number of conditions" → "different" (search: "diferent number").
  - "This is little more complex" → "This is a little more complex" (search: "This is little more complex").
  - "Since our result was p-value < .05, as rejected our null." → "Since our p-value was below .05, we rejected the null." (search: "as rejected our null").
  - "Two-Way Pearson's Chi-Squared" vs "Chi-Square" — the chapter alternates spellings in headings; standardize on "Chi-Square" (search: "Chi-Squared \[Test of Independence\]").
- **Approved:** [x] — IMPLEMENTED 2026-08-17. All six fixed. The heading sweep caught two
  more than the item listed: "### Step 2: Calculate Chi-squared" and "doing one-way
  chi-Squares in R", both now "Chi-Square"/"chi-squares". The `Social` → `Difficulty`
  rename propagates into the printed table and into the new `stdres` output, so the row
  dimension is now labelled correctly everywhere it appears.

### [CH22-U01] Follow-up residuals: the Issues list names the problem, the chapter has the tool one line away
- **Priority:** LOW
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Ch_34_Chi_Square.qmd → "Chi-Square Issues" (search anchor: "It does not identify every cell responsible for it.")
- **Problem:** The Issues list correctly says the omnibus test doesn't localize the association, and the callout says to "inspect the percentages, residuals, and effect size" — but standardized residuals are never shown, even though `MCQ.chi.2$stdres` already exists in the fitted object. For a 2×2 it's trivial; for the grad reader heading to bigger tables it's the missing follow-up tool.
- **Fix:** Add a 3-line chunk: `MCQ.chi.2$stdres` with two sentences — values act like z-scores per cell; beyond ±2 marks the cells doing the work; for bigger tables this is the first thing to inspect after a significant omnibus (and yes, checking many cells is a family — link the Multiple Comparisons chapter).
- **Approved:** [x] — IMPLEMENTED 2026-08-17 as a new section, "Which Cells Are Doing the
  Work?", sitting between "Reporting the Result" and "Chi-Square Issues" so the tool is on
  the page before the Issues list complains about its absence. The Issues bullet now points
  at it. One thing worth recording: for this 2×2 all four residuals are $\pm 4.01$ exactly,
  which is not a coincidence and would read as a bug if unexplained, so the section says
  why (one degree of freedom, four cells telling one fact four times) before moving on to
  where residuals actually earn their keep.

---

**Global items that also apply here:** chapter YAML residue (this one also injects amsmath
into the PDF header — check if actually needed after cleanup); missing `fig-alt`; no Short
Story (the Issues list + closing callout could be retitled/reshaped to serve).

### Done alongside the items, 2026-08-17

- **G01 (YAML strip): DONE.** `fontsize`, `geometry` and the whole `format: pdf:` block are
  gone; the file is now `title:` only. **The `amsmath` injection was not needed.** Every
  math construct in the chapter (`\sum`, `\frac`, `\sqrt`, `\min`, `\times`, `\chi`, `\phi`)
  is either plain LaTeX or already loaded by pandoc's default template. Renders clean.
- **G02 (`fig-alt`): DONE**, all six figures, each written against the rendered PNG and with
  the bin heights checked numerically (565 / 253 / 33 for the zoomed histogram).
- **Chunk names: DONE.** The chapter had 12 anonymous chunks producing `unnamed-chunk-N`
  figure filenames. All named. The six stale `unnamed-chunk-*.png` files were removed from
  `_freeze`.
- **Em-dash density: 2.00 → 0.23**, the floor. Six real dashes, cut individually (colon,
  comma, or full stop as the sentence wanted).
- **CH22-VOICE, the cold open. Alex approved it on 2026-08-17 when asked**, before any of it
  was written. The chapter used to open on the parametric/nonparametric taxonomy, which is
  the §15 failure mode. It now opens by handing `t.test()` the two Best counts and watching
  R return a perfectly respectable $t = 1.32$, $p = .41$, and a CI from $-956$ to $1178$,
  out of a table it does not understand. **The payoff is an identity, not a callback**
  (§17): `t.test()` reports a mean of 111, and 111 is exactly the expected frequency $f_e$
  that the hand calculation uses three sections later. That is called out at the hand
  calculation. The taxonomy section survives intact, one slot lower, where the reader now
  has a reason to want it.
- **Two clipped figure labels, found by looking at the PNGs and not in any item.** At
  $df = 1$ the string "(critical region)" ran off the bottom edge of the plot; at $df = 5$
  the first line was cut to "5% of chance va" on the right. Both were caused by positioning
  the label at `max(dchisq(x_vals, df)) * 0.6`, which is a tiny number in the tail. The
  label is now parked in the empty upper right with an arrow pointing at the shaded wedge,
  and `ylim` is set explicitly so the position is deterministic. Same failure family as the
  Ch19 participant-60 labels. No statistics changed; there is an `---Alex---` note on it.

**Not flagged (deliberate):** The "forced answer-changing exam" thought experiment for
building the null distribution — this is the best empirical-to-theoretical density bridge in
the book; the row-vs-column-percentages honesty ("People do not present both"); the odds
ratio section's direction-sensitivity warning; the base-R power function via `uniroot`
(quietly teaches noncentral distributions without saying so).
