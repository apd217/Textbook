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
- **Approved:** [ ]

### [CH25-U02] APA formatting mechanics are taught nowhere in the book — this is the chapter to host them
- **Priority:** MED
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_Reporting.qmd → after "What Belongs in a Regression Table?" (search anchor: "celestial punctuation")
- **Problem:** Every chapter shows APA write-ups, but the mechanical rules students get graded on appear nowhere: statistics in italics (*t*, *p*, *M*, *SD*, *R*²), no leading zero for values bounded by 1 (p, r: ".03" not "0.03"), two decimals for most statistics, exact p-values except "< .001", df in parentheses, spaces around = and <. The 343 curriculum promises an "APA format refresher" (Week 6); the book — built partly at Stephanie Del Tufo's urging to teach APA write-ups — has no single place these rules live.
- **Fix:** Add a compact section "The APA Formatting Rules Nobody Tells You" as a table: rule | wrong | right (6–8 rows covering the above). Close with one sentence: every write-up example in this book follows these; when your poster doesn't, the TA will find it. Cross-reference from the earlier APA sections is optional but cheap (one line in each: "formatting rules live in the Reporting chapter").
- **Approved:** [ ]

### [CH25-U03] Mention `sjPlot::tab_model()` — the one-line regression table students will actually use
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Reporting.qmd → "Extract Results from the Model Object" (search anchor: "broom::tidy(ReportModel, conf.int = TRUE)")
- **Problem:** `broom::tidy` + kable is the right teaching path, but sjPlot is already the course's plotting package and `tab_model(ReportModel)` produces a publication-ready HTML table in one line — the tool students will reach for on posters. Omitting it means they'll find it on Stack Overflow without the chapter's guardrails.
- **Fix:** Add a short aside: `sjPlot::tab_model(ReportModel)` shown once, with the guardrail sentence (a beautiful table of a bad model is still a bad model; the checklist above governs what belongs in it regardless of who typesets it).
- **Approved:** [ ]

### [CH25-B01] Part title problem (logged for the overview): "When R Inevitably Betrays You" contains no betrayal
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** _quarto.yml → part "When R Inevitably Betrays You" (search anchor: "When R Inevitably Betrays You")
- **Problem:** The part title promises debugging/troubleshooting; its two chapters are Reporting and a Tidyverse review. The only actual "R betrayed me" content in the book is the short error section in R_Basics. Readers scanning the TOC for help with a broken script will open this part and find a style guide.
- **Fix:** Either rename the part ("Appendices: Reporting and R Reference" or in-voice: "The Paperwork") or — better long-term — add the missing troubleshooting appendix (common error messages decoded, restart-R ritual, reprex habit). Decision belongs with the ordering discussion in 00_OVERVIEW.md.
- **Approved:** [ ]

---

**Global items that also apply here:** missing `fig-alt`; Short Story is prose (bullet it in
the same pass as CH19/21/24).

**Not flagged (deliberate):** "Lead with the Scientific Result" callout (arguably the most
important callout in the book); the Future You callout; "Model.Final.2.REAL.useThisOne";
the manual-transcription warning. The chapter's brevity is right — the fixes above add
maybe 300 words of high-value reference material, not prose.
