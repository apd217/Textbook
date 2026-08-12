# Chapter 21 — Advanced: Continuous and Higher-Order Interactions (Chapter_Advanced_Interactions.qmd)

**Snapshot:** ~2,200 words of dense, correct grad-prep that maps directly onto Aiken & West
and CCAW Chapter 7. The recentering demonstration ("we only rotated the coefficient labels
until the question we wanted was sitting in the convenient chair") is the best explanation
of what simple-slope software does that I've seen anywhere. Gaps are omissions, not errors:
Johnson–Neyman is described but never computed, and the standardized-interaction trap —
the single most common grad-student error in this territory — goes unmentioned.

---

### [CH21-P01] Johnson–Neyman gets formulas but no computation or plot
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** M
- **Location:** Chapter_Advanced_Interactions.qmd → "The Johnson-Neyman Question" (search anchor: "solves for the values of moderator $Z$")
- **Problem:** The section derives the conditional-slope SE and warns against extrapolation, but the reader never sees a J–N region computed or plotted — for the one technique in the chapter where the *picture* is the product. Grad students will need this for actual papers (editors increasingly ask for it over ±1SD).
- **Fix:** Add a demo on the existing caffeine×sleep model. Two options: `interactions::johnson_neyman(InteractionModel, pred = Caffeine.C, modx = Sleep.C)` (one line, standard tool) or a ~10-line manual version solving the quadratic from the SE formula already displayed, then shading the significance region on a slope-vs-moderator plot — the manual route matches the chapter's show-the-machinery ethic and avoids a new dependency. Either way, mark the observed range of Sleep.C on the plot and repeat the extrapolation warning with the picture present. Verify by running.
- **Approved:** [ ]

### [CH21-P02] Missing the classic trap: standardized coefficients for product terms
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Chapter_Advanced_Interactions.qmd → after the centering discussion (search anchor: "You would be fitting a mathematical casserole")
- **Problem:** The chapter covers centered-vs-uncentered carefully but never warns about *standardizing* interaction models — where software-reported "betas" are wrong for product terms because z-scoring the product ≠ the product of z-scores (Friedrich, 1982; CCAW covers this at length). Every psych grad student meets a reviewer asking for standardized coefficients on a moderation model; this book is positioned to inoculate them in one callout.
- **Fix:** Add a callout "The Standardized-Beta Trap": if you want standardized interaction coefficients, z-score X and Z *first*, then form the product and refit — do not trust a post-hoc 'standardized' column that z-scored the XZ product itself; the two differ and only the first is interpretable. One sentence pointing to CCAW ch. 7 / Friedrich (1982), added to references.bib.
- **Approved:** [ ]

### [CH21-B01] Small polish: scatterplot y-label, prose Short Story
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Advanced_Interactions.qmd → interaction plot (search anchor: "ylab = \"Predicted concentration\"") and end (search anchor: "## The Short Story")
- **Problem:** (1) The plot draws *raw* concentration points with predicted lines overlaid, but the y-label says "Predicted concentration" — mislabels the dots. (2) Short Story is a single prose paragraph while most chapters use scannable bullets (same as CH19-B01).
- **Fix:** (1) y-label → "Concentration"; caption can note lines are model predictions at three sleep values. (2) Bullet the Short Story: slope of X = b1 + b3Z (the derivative *is* the interaction); b1 is the slope at Z=0, so make zero mean something; center for interpretation, not exorcism; probe theory-chosen values (or J–N), inside the data; labels like synergistic/buffering are stories about coding, check before naming; three-way = a two-way that changes.
- **Approved:** [ ]

---

**Global items that also apply here:** missing `fig-alt` (YAML already clean here, like Ch19).

**Not flagged (deliberate):** The derivative-as-the-whole-interaction framing; "hear colors
at a higher frame rate"; the essential-vs-nonessential multicollinearity distinction
(straight out of CCAW and stated more clearly); the keep-lower-order-terms rule with
"interpretive debris"; the fourth panel of the patterns figure being a text panel
("Same product-term machinery / Different theoretical stories") — that's information design,
keep it. This chapter and Ch14 (Control) are the strongest pure-grad chapters; they need the
least work of anything in the book.
