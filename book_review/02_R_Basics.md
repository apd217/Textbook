# Chapter 2 — R: The Extremely Short Survival Guide (Chapter_R_Basics.qmd)

**Snapshot:** ~1,400 words. Tone and length are exactly right for the audience — this is the
model the longer chapters should aspire to. The problems are coverage gaps against the 242
lab sequence (no CSV import, no factors, no `table()`, no help system) and zero visuals in
the one chapter where a screenshot would do the most work.

---

### [CH02-U01] The chapter doesn't cover reading in data — but the Week 3 lab requires it
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** M
- **Location:** Chapter_R_Basics.qmd → after "Data Frames: Where the Undergraduates Are Stored" (search anchor: "The Institutional Review Board remains stubborn about this.")
- **Problem:** The 242 curriculum's Week 3 lab is explicit: "reading in a CSV file, understanding functions and their arguments, installing and loading packages, setting variables as factors… inspect its structure using `summary()` & `table()`." This chapter covers functions, packages, and `summary()` — but there is no `read.csv()`, no factors, and no `table()`. The only data frame students see is typed by hand. The very first thing a student does with real data (get it into R) is the thing the survival guide skips. The Tidyverse appendix covers imports, but no drowning week-3 student will find it there.
- **Fix:** Add a section `## Getting Data Into R` after the data-frames section covering: (1) `read.csv("file.csv")` with a one-line explanation of where R looks for files (tie back to the RStudio Projects advice already in the chapter — "this is why we made a Project"); (2) `str()` and `head()` to check what arrived; (3) `factor()` for categorical variables with a two-sentence why ("R needs to know 'CBT' is a category, not a word it should alphabetize and worry about"); (4) `table(study$therapy)` for counting categories. Reuse the existing `study` data frame so no new example is needed. Keep it under ~350 words; this is survival, not mastery.
- **Approved:** [ X]	

### [CH02-U02] No RStudio screenshot in the chapter that introduces RStudio
- **Priority:** HIGH
- **Perspective:** Student + Publisher
- **Effort:** M
- **Location:** Chapter_R_Basics.qmd → "R Is Not RStudio" (search anchor: "Think of R as a temperamental but extremely capable chef.")
- **Problem:** This is the only chapter with zero figures, and it's the chapter describing a piece of software the reader has never seen. The curriculum's first lab teaches "the four-pane layout"; the book never shows it. The chef/kitchen metaphor is charming but a lost student needs the actual kitchen, labeled.
- **Fix:** Add one annotated screenshot of RStudio's four panes (Source, Console, Environment, Files/Plots/Help), with callout labels like "your script lives here (the work)", "the Console (the experiments)", "objects you've created", "plots, files, help". Alex must supply/approve the screenshot (AI shouldn't fabricate UI images); the implementing model should insert the figure block with caption + fig-alt and leave a `<!-- TODO: Alex drop screenshot here -->` if the image file doesn't exist yet.
- **Approved:** [X ]

### [CH02-U03] Nowhere does the book teach `?function` — the single highest-value survival skill
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_R_Basics.qmd → "Errors Are Information, Delivered Rudely" (search anchor: "Ask for help and show the code")
- **Problem:** The errors section teaches asking humans for help but not asking R: `?mean`, the Help pane, and reading the Arguments/Examples sections of a help page. For a student alone at 11pm before the lab is due, `?` is the difference between progress and despair. (It also sets up honest AI-era advice: check what the function actually does rather than trusting autocomplete or a chatbot.)
- **Fix:** Add a short subsection or callout `### Asking R for Help` before the error list: `?mean` opens the manual; the two sections worth reading are **Arguments** and **Examples** ("run the examples; they are the only part guaranteed to work"); mention the Help pane search box. 3–5 sentences in voice.
- **Approved:** [X ]

### [CH02-U04] No "Short Story" recap
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_R_Basics.qmd → end of file (search anchor: "The thinking remains your job.")
- **Problem:** The closing paragraph is good but is prose, not a scannable recap. Same issue as CH01-U01; this should become the book-wide pattern (see cross-cutting item in 00_OVERVIEW.md).
- **Fix:** Add `## The Short Story` with ~6 bullets: scripts not console; `<-` makes objects; `c()` makes vectors; functions take arguments (`na.rm = TRUE`); install once / `library()` every session; read the first error, then `?` the function. End with the existing line "R will calculate nonsense with breathtaking speed. The thinking remains your job." — it's the perfect closer, keep it as the final sentence.
- **Approved:** [X ]

### [CH02-U05] Mention the Posit Cloud fallback
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_R_Basics.qmd → "Install Them in This Order" (search anchor: "Give yourself time to install software.")
- **Problem:** The curriculum explicitly offers Posit Cloud as the fallback for students with installation problems (old laptops, Chromebooks, locked-down machines). The book doesn't mention it, so the student with the broken install thinks the book has no answer for them.
- **Fix:** Add one sentence after the install steps: if installation fails or the laptop is elderly, Posit Cloud (free tier) runs RStudio in the browser and the course works fine there — install locally later. Keep it to two sentences max.
- **Approved:** [ X]

### [CH02-P01] Operator-precedence hand-wave is fine, but one trap deserves a sentence: unary minus
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_R_Basics.qmd → "PEMDAS Has Returned" (search anchor: "Operations at the same level are generally handled in their defined order.")
- **Problem:** "Generally handled in their defined order" is an acceptable simplification of left-to-right associativity. But one precedence trap actually bites stats students within weeks: `-2^2` returns `-4`, not `4`, and it shows up the moment they square deviations or z-scores by hand. That's worth one line; the rest of the precedence table isn't.
- **Fix:** Add to the code chunk: `-2^2` with a comment `# surprise! exponent wins over the minus sign — write (-2)^2 if you mean squared`, and one prose sentence noting this will matter when we start squaring deviations from the mean in the descriptives chapter.
- **Approved:** [X ]

### [CH02-B01] Chapter YAML residue (same as CH01-B01 — global cleanup)
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_R_Basics.qmd → YAML front matter (search anchor: "fontsize: 11pt")
- **Problem:** Same per-chapter `fontsize/geometry/format` block as Chapter 1. Confirmed this is a template pattern, not a one-off; promoted to cross-cutting item in 00_OVERVIEW.md.
- **Fix:** Handled by the global cleanup item (strip chapter YAML to `title:` only, all chapters, one pass, then full render check). Do not do it per-chapter.
- **Approved:** [ X]

---

**Not flagged (deliberate):** The chapter's brevity. Resist any urge to grow this into a
"complete R introduction" — the pirate-underwear line, the android callout, and the
`install.packages` quotation-marks joke carry more pedagogical weight than another 1,000
words would. The additions above (~400 words total) are curriculum-driven, not
completeness-driven.
