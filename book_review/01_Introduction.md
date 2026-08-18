# Chapter 1 — Why You Have to Learn Statistics (Ch_01_Introduction.qmd)

**Snapshot:** ~4,000 words. Hook is genuinely strong; the replication-crisis section is the
best "why should you care" argument in any intro stats chapter I know of. Main risks:
theory density (Kuhn + Michell + Meehl in chapter 1), no ending recap, and a
mid-chapter stretch with no visuals. Verdict: keep the soul, trim the seminar.

---

### [CH01-U01] No "Short Story" recap — the chapter just stops
- **Priority:** HIGH
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → end of file (search anchor: "More complicated software merely allows you to be wrong with additional parameters.")
- **Problem:** Later chapters (e.g., Intro to Regression) end with a "The Short Story" recap. Chapter 1 ends on a callout with no summary, no "here's what you now know," no bridge to Chapter 2. The target reader closes the chapter with no compressed version to hold onto — and this is the chapter that sets the pattern for how they'll read all the others.
- **Fix:** Add a final `## The Short Story` section (match the heading text used in Ch_11_Intro_Regression.qmd) with 5–6 one-line bullets: (1) statistics is the logic of the whole study, not math sprinkled at the end; (2) psychology got burned by ignoring this (replication crisis) and you can avoid contributing to the pile; (3) numbers only mean what the measurement lets them mean; (4) know the IV/DV/design vocabulary — it's the grammar of every later chapter; (5) next chapter: we make R do the arithmetic so you never have to. Keep bullets in Alex's voice.
- **Approved:** [X ] — IMPLEMENTED 2026-08-12 (6 bullets, added as §1.8 at end of chapter; renders clean)

### [CH01-U02] Michell's instrumental-vs-scientific-task argument is grad-level and stalls the flow
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → "Measurement: Numbers Are Not Magic" (search anchor: "Michell distinguishes two jobs.")
- **Problem:** The Stevens scales table + student-ID joke land perfectly for undergrads. But the two paragraphs on Michell's instrumental vs. scientific task (plus "Anxiety is not sitting inside the skull like a kidney") are a philosophy-of-measurement seminar. Good content, wrong altitude for week 1 of 242 — this is exactly the reader who bails when the abstraction level spikes without warning.
- **Fix:** Move the two Michell paragraphs (from "That classification is useful, but Joel Michell points out" through "decimal places.") into a collapsible advanced callout, e.g. `::: {.callout-note collapse="true" title="Advanced: Do Our Numbers Even Measure Anything? (Michell's Complaint)"}`. Keep the student-ID sentence in the main text as the one-line takeaway, since it's the punchline undergrads will remember. No wording changes inside the moved text.
- **Approved:** [ X] — IMPLEMENTED 2026-08-12 (student-ID punchline kept in main text; two paragraphs moved into collapsible note)

### [CH01-U03] "This Still Affects Your Life" evidence bullets are the densest text in the chapter
- **Priority:** MED
- **Perspective:** Student
- **Effort:** M
- **Location:** Ch_01_Introduction.qmd → "This Still Affects Your Life in a Serious Way" (search anchor: "In preclinical cancer biology, researchers repeated 50 experiments")
- **Problem:** Three ~4-line citation-heavy bullets (Errington cancer biology, Marek brain-wide associations, Marcoci COVID claims) each pack numbers, methods caveats, and a joke. A skimming reader gets the emotional point from the first bullet and skips the rest — but the Marek one contains the most memorable fact (brain-behavior studies need thousands of people). The information competes with itself.
- **Fix:** Convert the three bullets into a compact 3-row table: columns **Field** | **What they redid** | **What happened** (one short sentence each, numbers kept: "median effect 85% smaller", "~5% replication below n=500", "19 of 29 (~65%)"). Keep the two best jokes as a single sentence after the table ("So when a headline announces scientists found 'the brain region for procrastination' after scanning 23 sophomores, perhaps continue procrastinating before sharing it."). Keep all citations, attached to the table rows.
- **Approved:** [ X] — IMPLEMENTED 2026-08-12 (3-row table; both jokes kept in a single sentence after it)

### [CH01-U04] Terms table needs a "do not memorize this now" instruction
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → "Research Design: The Extremely Short Version" (search anchor: "Here are the terms you need before the rest of the book starts moving:")
- **Problem:** A 17-row definition table reads as "memorize me" to an anxious student, which triggers exactly the shutdown this book is designed to avoid. It's actually a reference table — but nobody tells the reader that.
- **Fix:** Replace the intro sentence with something like: "Here are the terms the rest of the book will use constantly. Do not memorize this table. Bookmark it. You will be back — the forgetting is normal and I planned for it." (Adjust to taste; the instruction "bookmark, don't memorize" is the fix.)
- **Approved:** [ X] — IMPLEMENTED 2026-08-12 (Short Story recap now echoes this line, by design)

### [CH01-U05] ~1,000-word visual desert between the scales figure and end of chapter
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** M
- **Location:** Ch_01_Introduction.qmd → "Research Design: The Extremely Short Version" (search anchor: "The basic research sequence is:")
- **Problem:** After the measurement-scales figure there are no more visuals — the terms table, the 9-step research sequence, the Meehl callout, and the how-to-read section are all text. For this reader, the last fifth of every chapter is where attention dies; ending on pure text guarantees skimming.
- **Fix:** Turn the 9-step "basic research sequence" numbered list into a simple circular flow diagram (R base graphics like the causal-logic figure, or a Graphviz/DOT chunk) — the curriculum literally calls Week 1 "the research cycle," so drawing it as a cycle also matches what the TA teaches that week. Keep the list as the figure caption or drop it.
- **Approved:** [ X] — IMPLEMENTED 2026-08-12 (9-step circular diagram, base R; list dropped, return arrow drawn in orange)

### [CH01-P01] "Statistically significant" placeholder definition should say where the real one lives
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → "Why Should You Care?" (search anchor: "That definition is deliberately incomplete.")
- **Problem:** The placeholder definition is pedagogically smart, and the text promises "a real definition after you learn some probability theory." But it doesn't say *where*. A professor reading this wants the IOU to name the chapter; a student wants to know how long they'll be confused.
- **Fix:** Add a cross-reference to the actual chapter that delivers the real definition (the one-sample t-test / hypothesis-testing chapter). Use a Quarto cross-ref (`@sec-...`) if section IDs exist, otherwise name the chapter title in prose. Also verify the promised definition actually appears there and is flagged as the payoff ("remember that IOU from Chapter 1?").
- **Approved:** [ X] — IMPLEMENTED 2026-08-12 (links to Ch_06_One_Sample_t.qmd). NOTE: the payoff half is still owed — CH06-P02 must add the formal p-value definition there and flag it as the IOU. Do not close that item without it.

### [CH01-P02] Kuhn/feedback-systems section: good, but one sentence overclaims
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → "Paradigms and the Stories We Tell About Causes" (search anchor: "Asking \"Which came first?\" can be a stupid question")
- **Problem:** The section is accurate and admirably honest ("I study systems like the second picture"). One quibble: "Psychology usually relies on linear causal logic" conflates *causal direction* with *linearity of functional form*, and although the next sentence disclaims it ("does not mean every relationship must be a straight line"), the term "linear causal logic" itself will collide with "linear model" three chapters later. Students will conflate the two uses of "linear."
- **Fix:** Rename the concept "one-way causal logic" or "directional causal logic" throughout this section (3–4 occurrences), keeping the disclaimer sentence. This reserves the word "linear" for lines, which is what the rest of the book needs it to mean.
- **Approved:** [X ] — IMPLEMENTED 2026-08-12 (4 spots: prose, fig-cap, plot title, plus "nonlinear perspective" → "dynamical-systems perspective")

### [CH01-P03] Meehl callout could anchor the grad-student on-ramp
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → callout "A Warning about Soft Theories" (search anchor: "Meehl argued that theories in")
- **Problem:** The Meehl summary is correct and well told. For the grad-student audience headed to CCAW, this is the natural place to plant the first "go deeper" pointer, and there is none. The preface promises the book works as a CCAW on-ramp; the chapters should occasionally point at the ramp.
- **Fix:** Add one closing line to the callout: pointer to Meehl (1978) as worth reading in full for grad students, plus CCAW Chapter 1 for how regression thinking frames research questions. One sentence, Alex-voiced (e.g., "Graduate students: read the actual Meehl paper. It is forty years old and still describes your literature review.").
- **Approved:** [X ] — PARTIAL 2026-08-12: added the Meehl line ("nearly fifty years old," since 1978 makes "forty" wrong). Dropped the CCAW half — the preface already tells grad students to keep Cohen et al. within reach, and repeating it inside a soft-theories callout read as off-topic. Say the word if you want it back.

### [CH01-B01] Chapter-level YAML format block conflicts with the book-level _quarto.yml
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → YAML front matter, lines 2–10 (search anchor: "fontsize: 11pt")
- **Problem:** The chapter file carries its own `fontsize: 11pt`, `geometry: margin=.5in`, and a `format: pdf: toc:` block. The book-level `_quarto.yml` says 10pt and 0.62in margins. In a Quarto book, chapter-level format metadata is at best ignored and at worst merged unpredictably — either way it's a landmine: someone later "fixes" formatting in the chapter file and nothing happens, or a Quarto version change makes it suddenly apply. (Check whether other chapters carry the same residue — if so, this is one global cleanup item.)
- **Fix:** Delete everything from the chapter YAML except `title:`. Formatting lives only in `_quarto.yml`. Render the book after removal and confirm no visual change.
- **Approved:** [ X] — IMPLEMENTED 2026-08-12 (Ch1 only; stripped to `title:`). Confirmed the residue was live, not inert: pre-strip metadata showed `fontsize: 11pt` overriding the book's HTML `1.1rem` for this chapter alone. The other 22 chapters still need the same strip — that is cross-cutting item G01.

### [CH01-B02] No figure alt text anywhere in the chapter (book-wide issue, logged here first)
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** M
- **Location:** Ch_01_Introduction.qmd → all three figure chunks (search anchor: "#| fig-cap: \"A real effect can produce wildly different estimates")
- **Problem:** Figures have `fig-cap` but no `fig-alt`. For the GitHub-hosted HTML version this is an accessibility failure (screen readers get nothing), and universities increasingly require alt text on course materials. Captions here are witty rather than descriptive, so they don't double as alt text.
- **Fix:** Add `#| fig-alt:` to each figure chunk with a plain literal description (e.g., for the replication simulation: "Two strip charts of 50 simulated study effects. With 20 people per group the points scatter widely from below zero to above one; with 200 per group they cluster tightly around the true effect of 0.3."). This is a book-wide pattern — see the cross-cutting item in 00_OVERVIEW.md; approve once there to apply everywhere.
- **Approved:** [X ] — IMPLEMENTED 2026-08-12 (all 5 figures in this chapter now carry fig-alt, including the 2 new ones). Rest of book = G02.

### [CH01-B03] First visual arrives ~1,000 words in
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_01_Introduction.qmd → "Why Should You Care?" (search anchor: "Statistics does four jobs for us:")
- **Problem:** The first figure (replication simulation) lands after roughly two pages of prose. The four-jobs table helps break the wall, but the publisher rule of thumb for reluctant readers is a genuine visual in the first screenful. The chapter's own thesis is "minimal words, maximum visuals" (preface) — chapter 1 should model it.
- **Fix:** Cheapest fix: promote the effect-size joke (coffee stirrer → Nerf bat → wooden bat → metal bat → mother's slipper) into a small horizontal "effect size severity scale" graphic placed right after the three-definitions list. It is the most quotable joke in the chapter and currently buried in a bullet. A one-chunk base-R drawing keeps it consistent with the chapter's other figures.
- **Approved:** [X ] — IMPLEMENTED 2026-08-12 (5-box escalating scale placed directly after the three-definitions list; first visual now lands ~500 words in)

---

**Not flagged (deliberate):** The IRB volcano callout, the "no such thing as fish" aside, and
the fickle-Probability-Gods framing are doing exactly what this audience needs — do not let
any future editor sand these off. The replication-crisis section ordering (crisis before any
formula) is pedagogically correct and should survive all restructuring.
