# Chapter 22 — Pearson's Chi-Square (Chapter_ChiSquare.qmd)

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
- **Location:** Chapter_ChiSquare.qmd → "Goodness of Fit Calculation by Hand" (search anchor: "= 127.14") and "Our results?" / APA sections (search anchors: "124.14 (experimental value we got)", "N = 222) = 124.14")
- **Problem:** The hand calculation correctly gives χ² = (84²+84²)/111 = 127.14. The decision sentence and *both* APA write-ups then report 124.14 — three times. `chisq.test()` will print ~127.13, so the student sees the hand value, the code value, and the reported value disagree, in the section teaching them to report numbers accurately.
- **Fix:** Correct all instances to the computed value (ideally make them inline: `` `r round(MCQ.chi$statistic, 2)` ``, which prevents recurrence). Also upgrade "p < .05" to the exact-p convention the t-test chapters teach ("In modern APA format, report the exact p-value") — here p < .001. Verify by rendering.
- **Approved:** [ ]

### [CH22-B01] Stale course-sequence language: the chapter believes it comes *before* hypothesis testing
- **Priority:** HIGH
- **Perspective:** Publisher + Student
- **Effort:** S
- **Location:** Chapter_ChiSquare.qmd → multiple (search anchors: "We will return the logic of hypothesis testing in more detail later in the semester.", "### Parametric Tests (coming later)", "later we’ll formalize how they connect to tests like t and F", "which the advanced chapter later in this book handles")
- **Problem:** This chapter was clearly written for an early-242 slot (chi-square as the first hypothesis test) and was moved to Part 4 without updating its self-references: it promises hypothesis-testing logic "later in the semester" (the reader finished it nine chapters ago), labels parametric tests "(coming later)" (they came), promises t and F will be formalized "later" (they were), and defers multiplicity to "the advanced chapter later in this book" (Multiple Comparisons is *earlier* in book order). For a reader this is disorienting; for an instructor evaluating the book it looks unedited.
- **Fix:** Sweep the chapter's temporal references to match its actual position: "(coming later)" → "(the t-tests and regression you've already met)"; "we will return… later in the semester" → "you know this logic from the t-test chapters — chi-square runs the same play with counts"; "later we'll formalize" → backward reference; "the advanced chapter later" → link to Chapter_Multiple_Comparisons.qmd. Alternatively — Alex's call, see the ordering discussion in 00_OVERVIEW.md — this chapter genuinely could serve as an early gentle-intro to hypothesis testing (its null-simulation build-up is self-contained); but then the *other* chapters' text needs checking instead. Fixing the references in place is the cheaper, recommended path.
- **Approved:** [ ]

### [CH22-P02] Mid-chapter APA reports the uncorrected 16.08 while the adjacent code runs Yates (15.57)
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_ChiSquare.qmd → two-way APA (search anchor: "N = 1379) = 16.08") vs. the corrected test (search anchor: "correct = TRUE")
- **Problem:** The hand calculation (16.08, uncorrected) is reported in the mid-chapter APA sentence, then the R section runs `correct = TRUE` and prints 15.57 with no comment; only the final "Reporting the Result" section reconciles them ("state your choices"). A student comparing the mid-chapter APA to the output above it sees an unexplained mismatch for several pages.
- **Fix:** At the mid-chapter APA, add one sentence: "This matches our hand calculation, which used no continuity correction; R's default output below will differ slightly — we'll sort that out in a moment." Or run `correct = FALSE` first to match the hand value, then introduce Yates as the deliberate follow-up. Either way the reconciliation should happen at first contact, not two sections later.
- **Approved:** [ ]

### [CH22-B02] Typo/labeling sweep
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_ChiSquare.qmd → multiple
- **Problem / Fix (list):**
  - `dimnames(MCQ.Study.2) <- list(Social = c("Easy","Diff")…)` — the dimension is item difficulty, not "Social" (copy-paste residue from another dataset); rename to `Difficulty` (search: "Social = c(\"Easy\"").
  - "The way above if the hard way and shown you understand what the computer is doing" → "The way above is the hard way, and shows you understand…" (search: "The way above if the hard way").
  - "If we have diferent number of conditions" → "different" (search: "diferent number").
  - "This is little more complex" → "This is a little more complex" (search: "This is little more complex").
  - "Since our result was p-value < .05, as rejected our null." → "Since our p-value was below .05, we rejected the null." (search: "as rejected our null").
  - "Two-Way Pearson's Chi-Squared" vs "Chi-Square" — the chapter alternates spellings in headings; standardize on "Chi-Square" (search: "Chi-Squared \[Test of Independence\]").
- **Approved:** [ ]

### [CH22-U01] Follow-up residuals: the Issues list names the problem, the chapter has the tool one line away
- **Priority:** LOW
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Chapter_ChiSquare.qmd → "Chi-Square Issues" (search anchor: "It does not identify every cell responsible for it.")
- **Problem:** The Issues list correctly says the omnibus test doesn't localize the association, and the callout says to "inspect the percentages, residuals, and effect size" — but standardized residuals are never shown, even though `MCQ.chi.2$stdres` already exists in the fitted object. For a 2×2 it's trivial; for the grad reader heading to bigger tables it's the missing follow-up tool.
- **Fix:** Add a 3-line chunk: `MCQ.chi.2$stdres` with two sentences — values act like z-scores per cell; beyond ±2 marks the cells doing the work; for bigger tables this is the first thing to inspect after a significant omnibus (and yes, checking many cells is a family — link the Multiple Comparisons chapter).
- **Approved:** [ ]

---

**Global items that also apply here:** chapter YAML residue (this one also injects amsmath
into the PDF header — check if actually needed after cleanup); missing `fig-alt`; no Short
Story (the Issues list + closing callout could be retitled/reshaped to serve).

**Not flagged (deliberate):** The "forced answer-changing exam" thought experiment for
building the null distribution — this is the best empirical-to-theoretical density bridge in
the book; the row-vs-column-percentages honesty ("People do not present both"); the odds
ratio section's direction-sensitivity warning; the base-R power function via `uniroot`
(quietly teaches noncentral distributions without saying so).
