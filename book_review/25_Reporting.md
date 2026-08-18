# Chapter 25 — Reporting Models (Chapter_Reporting.qmd)

**Snapshot:** ~830 words. Right instincts throughout — lead with the scientific result,
extract from model objects, "celestial punctuation," Future You. But it's thin for the job
the curriculum assigns it: 343 students must produce APA posters and write-ups, and the
book's only reporting chapter never teaches APA's actual formatting mechanics, and its
example write-up contains no numbers.

---

### [CH25-U01] The example write-up is a template with the numbers removed — model the finished product
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Reporting.qmd → "Example Write-Up" (search anchor: "predicted an estimated increase in memory performance")
- **Problem:** The write-up paragraph deliberately omits every statistic, then instructs "replace that language with the actual numerical estimates." The chapters students will imitate (t-tests, regression, interactions) all model *filled-in* write-ups with live inline values; the dedicated reporting chapter is the only one that doesn't. For this audience, showing the completed sentence teaches more than describing it.
- **Fix:** Fill the paragraph with inline R from `ReportModel` (b, SE or CI, t, p per predictor; R², F for the model) exactly as Chapters 13/15/16 do, and keep one sentence noting the underlying template structure ("claim in units → statistics in parentheses → what it does and doesn't support"). 
- **Approved:** [x] — IMPLEMENTED 2026-08-17. Every statistic in the paragraph is now inline
  from `ReportModel` via a hidden `reporting-inline-values` chunk, which also defines the
  APA helpers (`fmt` for two decimals with trailing zeros preserved, `no_zero` for values
  bounded by 1, `apa_p` for the exact-p rule) so the paragraph obeys the table added by
  CH25-U02. The template sentence is kept.

  **Running the model changed the write-up's meaning, twice.**
  1. **Caffeine is not significant.** $b = -0.013$, 95% CI $[-0.027, 0.001]$,
     $t(176) = -1.84$, $p = .067$. Alex's template said "Caffeine showed a small negative
     adjusted association with memory", which promotes a coefficient compatible with zero
     to a finding. The filled paragraph says the association is negative *and* not
     distinguishable from zero, and a following sentence points out that this is
     deliberate, because it is the sentence reviewers read hardest.
  2. **The diagnostics clause had to go.** It claimed the plots showed no consequential
     violation of constant residual variance. The errors are simulated homoscedastic
     (`rnorm(n, 0, 7)`), but on this particular draw `lmtest::bptest(ReportModel)` returns
     $p = .003$. Rather than assert an untrue diagnostic, or bolt a diagnostics section
     onto a chapter whose brevity the review calls right, the clause is replaced by a
     sentence saying a real write-up ends with diagnostics and pointing at Ch19. **There is
     an `---Alex---` note on it**, since he may prefer the chapter actually ran them.

  Caffeine is also reported per 100 mg alongside per milligram, because "0.013 points per
  milligram" is not a sentence anybody can picture, and the chapter's own checklist asks
  for estimates in interpretable units.

### [CH25-U02] APA formatting mechanics are taught nowhere in the book — this is the chapter to host them
- **Priority:** MED
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_Reporting.qmd → after "What Belongs in a Regression Table?" (search anchor: "celestial punctuation")
- **Problem:** Every chapter shows APA write-ups, but the mechanical rules students get graded on appear nowhere: statistics in italics (*t*, *p*, *M*, *SD*, *R*²), no leading zero for values bounded by 1 (p, r: ".03" not "0.03"), two decimals for most statistics, exact p-values except "< .001", df in parentheses, spaces around = and <. The 343 curriculum promises an "APA format refresher" (Week 6); the book — built partly at Stephanie Del Tufo's urging to teach APA write-ups — has no single place these rules live.
- **Fix:** Add a compact section "The APA Formatting Rules Nobody Tells You" as a table: rule | wrong | right (6–8 rows covering the above). Close with one sentence: every write-up example in this book follows these; when your poster doesn't, the TA will find it. Cross-reference from the earlier APA sections is optional but cheap (one line in each: "formatting rules live in the Reporting chapter").
- **Approved:** [x] — IMPLEMENTED 2026-08-17 as "The APA Formatting Rules Nobody Tells You",
  a nine-row rule/wrong/right table plus two paragraphs on the italic rule.

  **The open question was put to Alex first and he chose the full sweep**: writing the table
  means committing to italic `p`, `r`, `M`, `SD`, `N`, `df` book-wide. **That sweep is DONE**,
  as its own commit, with a new tool at `book_review/tools/italicize_stats.R`. 63 symbols
  across 19 files. See the block at the bottom of this file for what it does and does not
  touch, and for the bug it nearly shipped.

  Two corrections to the item's own list, both made after checking APA 7 rather than
  writing from memory:
  - The item lists "*R*²" as needing italics. In this book $R^2$ is always written in math
    mode, where it is already italic, so no action.
  - The item's implied rule ("abbreviations are not italic") is wrong: APA italicizes *SE*
    and *OR*. The genuine line is Latin-symbol versus Greek-letter, with **CI** as the one
    exception worth memorizing. The chapter now states it that way.

  A first draft of the table had a Greek-italics row demonstrating wrong-versus-right
  *inside* math mode, where MathJax overrides the distinction and the demonstration cannot
  work. Dropped; the point is made in prose instead. The cross-reference line back from
  earlier APA sections was **not** added, since it is marked optional and would touch
  fifteen finished chapters for one sentence each.

### [CH25-U03] Mention `sjPlot::tab_model()` — the one-line regression table students will actually use
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Reporting.qmd → "Extract Results from the Model Object" (search anchor: "broom::tidy(ReportModel, conf.int = TRUE)")
- **Problem:** `broom::tidy` + kable is the right teaching path, but sjPlot is already the course's plotting package and `tab_model(ReportModel)` produces a publication-ready HTML table in one line — the tool students will reach for on posters. Omitting it means they'll find it on Stack Overflow without the chapter's guardrails.
- **Fix:** Add a short aside: `sjPlot::tab_model(ReportModel)` shown once, with the guardrail sentence (a beautiful table of a bad model is still a bad model; the checklist above governs what belongs in it regardless of who typesets it).
- **Approved:** [x] — IMPLEMENTED 2026-08-17 as a short subsection under "Extract Results
  from the Model Object", with the guardrail sentence. One thing the item could not have
  known: **`tab_model()` emits HTML**, so a plain chunk would print nothing useful in the
  PDF build. The chunk carries `#| eval: !expr knitr::is_html_output()` and a code comment
  saying why, so the code is still visible to PDF readers while only the web build runs it.
  Verified in the rendered HTML.

### [CH25-B01] Part title problem (logged for the overview): "When R Inevitably Betrays You" contains no betrayal
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** _quarto.yml → part "When R Inevitably Betrays You" (search anchor: "When R Inevitably Betrays You")
- **Problem:** The part title promises debugging/troubleshooting; its two chapters are Reporting and a Tidyverse review. The only actual "R betrayed me" content in the book is the short error section in R_Basics. Readers scanning the TOC for help with a broken script will open this part and find a style guide.
- **Fix:** Either rename the part ("Appendices: Reporting and R Reference" or in-voice: "The Paperwork") or — better long-term — add the missing troubleshooting appendix (common error messages decoded, restart-R ritual, reprex habit). Decision belongs with the ordering discussion in 00_OVERVIEW.md.
- **Approved:** [x] — IMPLEMENTED 2026-08-17. **Alex chose "rename the part"** over writing
  the troubleshooting appendix when asked. `_quarto.yml` now reads `- part: "The Paperwork"`,
  with a comment recording the old title and why it changed.

  **Note for whoever reads the diff:** Alex was editing `_quarto.yml` by hand during this
  session and his save overwrote the rename once. It was re-applied. His new commented-out
  `"ANOVA is dead, Long Live ANOVA"` part stub is in the same commit, unmodified, because
  it was sitting uncommitted and uncommitted files get lost around here.

---

**Global items that also apply here:** missing `fig-alt`; Short Story is prose (bullet it in
the same pass as CH19/21/24).

### Done alongside the items, 2026-08-17

- **G02 (`fig-alt`): DONE**, the chapter's one figure, written against the rendered PNG. The
  parallel-lines detail is called out because that is the model's no-interaction assumption
  made visible, and a reader using a screen reader would otherwise have no way to know.
- **Short Story bulleted**, matching CH19/21/24.
- **Em-dash density: 1.68 → 0.72.** Both numbers are the floor: this chapter has **zero**
  real em-dashes and always did. The 1.68 was the YAML-fence artifact divided by a very
  small word count, and the number moved only because the chapter got longer. **Anything
  reporting near the floor on a short chapter should be checked before it is treated as a
  finding.**
- **YAML was already clean.** No hidden `load-libraries` block, so G05b does not apply.
  `library(sjPlot)` sits at first use; `broom` and `knitr` are called with `::`, which was
  already the chapter's style and was left alone.

### The italics sweep (the open question from 2026-08-15, now closed)

**Alex answered on 2026-08-17: write the table AND sweep the book.** Done, in its own commit.
Tool: `book_review/tools/italicize_stats.R`, a companion to `italicize_tF.R`. **63 symbols
across 19 files.** Run it dry first; it prints every proposed change.

**Scope is deliberately narrow, and narrower than "italicize p, r, M, SD, N, df" sounds.**
Only two shapes are touched:

1. A symbol immediately before a comparator: `p = .03`, `SD = 1`, `N = 222`. **5 hits.**
2. The compound `p-value` / `p-values`, the same shape `italicize_tF.R` swept for *t* and
   *F*. **58 hits**, which is where nearly all the value is.

**Bare `p` and bare `r` in running prose are still not swept, and should not be.** The survey
that killed the bare-*t* sweep in the 14+15 session applies unchanged: a regex confident
enough to catch a bare letter is confident enough to corrupt every "r" in the book.

**The bug this nearly shipped, which is the reusable lesson.** `italicize_tF.R` protects
inline code and math with one alternation, scanning left to right. That is not safe here,
because a `$` can live *inside* a code span. On this line in
`Chapter_Regression with Cat Variables.qmd`:

```
$t(`r tl$df`) =$ `r round(tl$t.ratio, 2)`, $p < .001$
```

the `$` in `` `r tl$df` `` makes the math matcher pair the wrong dollars, which leaves the
real `$p < .001$` unprotected. The first dry run proposed writing `$*p* < .001$` into two
finished chapters, where it would have rendered as literal asterisks inside math.
**Mask code spans first, then find math in the code-masked text.** The new tool does, and
that chapter correctly drops out of the sweep entirely.

Three other exclusions were added after auditing the dry run one hit at a time:

- **Callout fence lines** (`::: {.callout-... title="Never Write p = 0"}`). Quarto parses
  `title=` as an attribute, not as markdown, so asterisks would show up literally.
- **HTML comment blocks**, tracked across lines rather than by delimiter, so `---Alex---`
  notes are left alone.
- Two bullets in `Chapter_ChiSquare.qmd` that looked like statistics but were **`qchisq()`
  argument names** (`p = .05`, `df = 1`). Those wanted code font, not italics, and were
  changed to backticks by hand instead.

**Verification:** all 16 affected book chapters re-render clean, the rendered HTML shows
`<em>p</em>-value`, and a grep confirms no asterisks landed inside any math span and no
emphasis got nested.

**Not flagged (deliberate):** "Lead with the Scientific Result" callout (arguably the most
important callout in the book); the Future You callout; "Model.Final.2.REAL.useThisOne";
the manual-transcription warning. The chapter's brevity is right — the fixes above add
maybe 300 words of high-value reference material, not prose.
