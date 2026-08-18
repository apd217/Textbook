# Book-Wide Review: Overview & Priorities

> Reviewer: Claude (Fable), 2026-08-12. Full three-perspective review of all 26 active
> chapters: struggling undergrad (U), quantitative psychology professor (P), publisher (B).
> Chapter-level items live in `01_…` through `26_….md`; each has an ID, priority, location
> anchor, precise fix, and an approval checkbox. Book-wide items below use `G##` IDs and
> also have checkboxes. **Implementer: read README_FOR_IMPLEMENTER.md first.**

## 1. Verdict in one paragraph

This is a genuinely good book — in places (Paired t, Power, Control, Multiple Comparisons,
Bootstrapping) it is better than anything commercially available for this audience, and the
voice is a real asset that no editor should sand off. The weaknesses are systematic rather
than fatal, and they cluster into four groups: **(1) book–lab mismatches** — five places
where the book teaches different tools or syntax than the standardized 343/242 labs (Welch
vs. pooled t, glmmTMB vs. lmer, missing CSV/factor basics, missing sjPlot one-liners,
refused r benchmarks); **(2) uneven chapter engineering** — roughly a third of the chapters
(mostly the older, slide-derived ones: One-Sample t, Covariance/Correlation, Chi-Square)
have stub headings, unanswered lecture prompts, hard-coded statistics, and hidden code,
while the recently rewritten chapters show exactly what the book should be; **(3) a handful
of real bugs** — wrong variable in echoed code, a propagated 127.14/124.14 error, a mean
computed from bin upper-bounds, an output the text refers to but never shows, and a DV that
changes identity mid-chapter; **(4) missing connective tissue** — recaps, self-checks,
cross-references, and alt text are present in some chapters and absent in others. Fix the
lab mismatches first (they cost students points), then the bugs, then run the cross-cutting
items as mechanical passes.

## 2. Chapter ordering & structure recommendations

**Part 1 (The Necessary Slog): ~~keep as is~~ — SUPERSEDED 2026-08-14, see below.** Only
other change: Chi-Square still *believes* it lives here (see CH22-B01) — fix its text, not
its position.

> **CORRECTION (2026-08-14, Alex's call, implemented).** This paragraph was wrong, and the
> curriculum matrix in §3 of this same document proves it. The matrix says 242 teaches power
> in **Week 10**, *before* the independent-samples t-test (Week 11) and the paired t-test
> (Week 12). The book had Power at position 9, after both. The claim that "the order matches
> the 242 weeks" was simply false, and the reasoning that Power should come last because "it
> reuses all of them" put a book-internal tidiness argument ahead of the syllabus that Part 1
> actually serves. Part 1 is the 242 course; Part 2 is 343.
>
> **New Part 1 order:** Introduction → R_Basics → Probability → Distro_Moments →
> Standard_Error → OneSample_t → **Power_Effect_Size** → Independent_t → Paired_t.
>
> The two test-specific power sections moved out of the Power chapter and into the chapters
> they belong to: `type = "two.sample"` plus Hedges' correction now closes Independent_t, and
> `type = "paired"` plus "Why Pairing Is Cheaper" now closes Paired_t. Each now runs on the
> data its host chapter already simulated instead of re-simulating it, which also fixed a
> silent staleness bug: the moved chunk was still building the CTA data on the pre-1-5-scale
> parameters. The Power chapter keeps the concepts and the one-sample worked example, and
> carries a callout pointing forward to the two it handed off.
>
> This also resolved CH09-B01 the way that item originally wanted. With Power now immediately
> after OneSample_t, Chapter 6 can defer effect sizes entirely: it keeps the $d$ in its APA
> line and a callout telling the reader the next chapter explains it. The SDT figure, both
> $d$ formulas, the small/medium/large/huge benchmarks, and the four effect-size
> visualisations all now live in exactly one place, the Power chapter. The "keep the table in
> both chapters" compromise recorded in `09_Power_Effect_Size.md` is therefore obsolete.

**Part 2 (Putting Lines Through Things): two changes recommended.**

> **DECIDED (2026-08-15, Alex's call).** Recommendation 1 is **adopted and implemented**;
> recommendation 2 is **declined for now** — Mixed Regression stays where it is, and the
> cheaper CH18-U02 on-ramp alternative was not taken either. Revisit if the Week 10 mismatch
> bites.
>
> **New Part 2 order:** CovCorr → Intro Regression → Categorical Variables →
> Multiple Regression → **Hierarchical** → **Control** → Interaction_1 → CatXCat →
> Mixed Regression.
>
> Three cross-references had to move with it, since a reorder that leaves "the next chapter"
> pointing at the wrong chapter is a broken reorder:
> - Multiple Regression's closing `callout-tip` now routes to Hierarchical first and Control
>   second (both linked). Alex's undergraduate-recruitment punchline is untouched.
> - Multiple Regression's "The next chapter takes apart what statistical control is actually
>   doing" became a plain link to the Control chapter, with no positional claim to rot.
> - Control's opener dropped "In the previous chapter," keeping the link. It now reads
>   "In [Multiple Regression: Statistical Control], we predicted…".
>
> Two references *repaired themselves*, which was the point: Hierarchical's "Where We Left
> Off" opener and its "Recall the Venn diagram from the previous chapter" (the Ballantine
> lives in Multiple Regression) are both true as written now. That closes CH15-B01 without
> touching the chapter — see the note on that item.

1. **Swap Control (14) and Hierarchical (15).** Hierarchical directly continues the
   Multiple-Regression chapter's Models 1/3 (its "in the previous chapter" opener becomes
   *true*, fixing CH15-B01 for free), and Control — explicitly labeled an advanced chapter —
   then closes the trilogy as the under-the-hood deep dive, with its sr² = ΔR² proof landing
   *after* the reader has used ΔR². New order: Multiple_Regression_Control →
   Hierarchical_Regression → Control.
2. **Move Mixed_Regression (18) before Interaction_1 (16).** The curriculum teaches
   within-subjects regression with lmer in Week 10, *before* interactions in Weeks 11–13.
   The book currently delivers it last. With the new paired-t-≡-lmer on-ramp (CH18-U02),
   the chapter serves Week 10; its longitudinal second half stays as the advanced material.
   New Part 2 order: CovCorr → Intro Regression → Categorical Variables →
   Multiple Regression → Hierarchical → Control → **Mixed Regression** → Interaction_1 →
   CatXCat.
   - Cheaper alternative if moving feels disruptive: leave the order, but add the CH18-U02
     on-ramp and a routing callout at the end of Categorical Variables ("measuring the same
     people twice? Jump ahead to Mixed Regression — your Week 10 lab does").

**Part 3–4: keep**, with the Chi-Square text fixes. Note ChiSquare/Nonparametric/Bootstrap
are ordered sensibly (counts → ranks → resampling).

**Part 5: rename.** "When R Inevitably Betrays You" promises debugging that isn't there
(CH25-B01). Either rename ("The Paperwork" / "Appendices: Reporting and R Reference") or
add the missing troubleshooting appendix — common error messages decoded, the restart
ritual, how to make a minimal reproducible example. The appendix is worth writing
eventually; students need it weekly.

**When the grad chapters ship** (Mediation, GLM, Missing Data, the Mixed quartet, EFA):
consider a dedicated Part ("The Graduate On-Ramp") rather than distributing them — the
book already has a de facto grad spine (Ch14, 19, 21, 24 + advanced halves of 9, 18) and
CCAW-bound readers would benefit from one named track. Also: the preface's "ANOVA gets a
brief appearance" promise is currently unfulfilled anywhere in the active book — CH17-U01
is the cheap payment; Advanced_Contrasts_ANOVA is the full one.

## 3. Curriculum coverage matrix

✔ = covered at right level; ~ = partial (see item); ✘ = gap (see item).

### PSCH 242

| Week | Curriculum stats content | Book chapter(s) | Status | Key items |
|---|---|---|---|---|
| 2–3 | R as calculator; objects; **CSVs; factors; `table()`**; packages; `summary()` | R_Basics | ~ | CH02-U01 (CSV/factor/table missing), CH02-U02 (no RStudio screenshot) |
| 4 | Probability intuition failures (**named heuristics**); sampling; distribution shape/center/spread | Probability, Distro_Moments | ~ | CH03-U02 (heuristics unnamed), CH03-U01 (no visible code) |
| 5 | Variance/SD logic (**why N−1**); z-scores; `pnorm()`, **`quantile()`** | Distro_Moments | ~ | CH04-U01 (N−1 unexplained), CH04-U02 (no qnorm/quantile) |
| 7 | Variance→covariance→r; **Cohen's benchmarks**; NHST for r; Spearman; **restriction of range** | Covariance and Correlation | ~ | CH10-U02 (benchmarks refused), CH10-U03 (restriction of range missing) |
| 9 | SEM; CLT; one-sample t; df; **H0: μ=μ0 notation**; Cohen's d; APA | Standard_Error, OneSample_t | ~ | CH06-U01 (symbolic hypotheses), CH06-P01/P02 (broken payoff, p-value definition) |
| 10 | Type I/II; α, β, power; p-value misconceptions | Power_Effect_Size (+Ch6) | ✔ | CH09-U01 (roadmap) |
| 11 | Independent t; **pooled SE; homogeneity; `var.equal=TRUE` formula syntax**; d | Independent_t | ~ | CH07-U01 (Welch/pooled mismatch), CH07-U02 (no assumptions section) |
| 12 | Paired t; difference scores; ≡ one-sample on D; **counterbalancing/order effects**; within-subject graphs | Paired_t | ~ | CH08-U01 (counterbalancing missing) |

### PSCH 343

| Week | Curriculum stats content | Book chapter(s) | Status | Key items |
|---|---|---|---|---|
| 4 | Review SEM/t; bridge t→regression | Standard_Error, Intro_to_regression | ✔ | — |
| 5 | Simple regression; **least squares**; R²; residuals; **APA write-up; full summary() walkthrough** | Intro_to_regression | ~ | CH11-U01/U02/U03 (all three missing) |
| 8 | Dummy coding; ≡ t-test (**why do t's match?**); k−1 dummies; EMMs; **relevel(); F, R² in APA** | Regression with Cat Variables | ~ | CH12-U01/U02/U03, CH12-P01 (protected-t logic) |
| 10 | Within-subjects regression; random intercept; **`lmer()`**; **≡ paired t demo** | Mixed_Regression | ✘ | CH18-U01 (glmmTMB≠lmer), CH18-U02 (on-ramp missing) |
| 11 | Cont×cat interaction; centering (`scale()`); product term; ΔR²; `anova()` | Interaction_1 | ✔ | CH16-U01 (centering chunk stub) |
| 12 | Simple slopes; plots (**sjPlot per HW**); `emtrends`; within-subjects interactions | Interaction_1 (+Mixed) | ~ | CH16-U02 (sjPlot one-liner); within-subject interaction lives only in draft chapters — flag for Alex |
| 13 | Mixed 2×2; simple effects; EMMs/`emmeans`; complex reporting | CatXCat + Mixed_Regression | ✔ | CH17 items minor |

**Two true content gaps against the curriculum:** (a) Week 12's *within-subjects
continuous×categorical interaction* (`lmer(Y ~ X*Z + (1|Subject))`) is only in the
commented-out Mixed chapters — the active book never shows an interaction inside lmer;
CH18-U01/U02 partially cover this, but consider one worked example in Mixed_Regression.
(b) 242's measurement/design weeks are deliberately out of scope (open methods chapters
cover them) — fine, but Chapter 1's scales-of-measurement section is the book's only
overlap and should stay.

## 4. Cross-cutting items (approve once, apply everywhere)

### [G01] Strip chapter YAML to `title:` only
- **Priority:** MED | **Effort:** S (mechanical)
- 23 of 26 chapters carry dead per-chapter format blocks (fontsize/geometry/pdf toc; Ch16/17 also carry an `html:` block; ChiSquare injects amsmath). Ch19/21/24/25 are already clean — that's the target state. All formatting decisions live in `_quarto.yml`. Full render before/after to confirm no visual change.
- **Approved:** [ X]

### [G02] Add `#| fig-alt:` to every figure
- **Priority:** MED (HIGH for a public university course text) | **Effort:** L (≈70 figures)
- Zero figures in the book have alt text (verified by grep). Captions are witty, not descriptive — screen-reader users get nothing. Write literal one-sentence descriptions; do NOT replace captions. This also matters for the book's own dyslexia-accessibility mission.
- **Approved:** [X ]

### [G03] "The Short Story" recap in every chapter
- **Priority:** HIGH | **Effort:** M
- Present in 18 chapters, absent in 8: Introduction, R_Basics, Probability, Multiple_Regression_Control, Hierarchical, Interaction_1, CatXCat, Multiple_Comparisons (each has a per-chapter item with drafted bullet content: CH01-U01, CH02-U04, CH03-U04, CH13-U01, CH15-U01, CH16-U03, CH17-U02, CH20-U02). Also convert the four prose-paragraph recaps (Ch19, 21, 24, 25) to bullets. Use Ch4/Ch8's recaps as the style model.
- **Approved:** [X ]

### [G04] Self-check questions with collapsible answers in every core chapter
- **Priority:** HIGH | **Effort:** L (new content, ~3–5 questions × 18 chapters)
- The book's target reader needs retrieval practice more than any other feature, and the book already contains the perfect pattern twice: Ch14's "Four Questions Before You Escape" and Ch26's "Practice… / Solutions, because suffering has limits." Reuse that exact structure (scenario-based questions, `collapse="true"` answers, jokes intact). Highest-leverage new content in this review. Suggest Alex drafts or approves the questions per chapter; the implementing model can draft candidates for review.
- **Approved:** [X ]

### [G05] Code-visibility policy: show the statistics, hide the plumbing
- **Priority:** HIGH | **Effort:** M
- Chapters disagree about `echo`: R_Basics shows everything; Probability and Standard_Error hide *everything* — including the `sample()`/`replicate()` simulations that ARE the lesson (CH03-U01, CH05-U01, CH10-U04, CH13-U02 are the specific fixes). Adopt the Power chapter's explicit policy and its reader-facing callout ("Some of Today's Code Is Not Your Problem"): echo every chunk teaching a function students must use; hide pure plotting boilerplate; when hiding, occasionally say so.
- **Approved:** [ X]

### [G05b] `library()` at first *visible* use, in every chapter
- **Priority:** HIGH | **Effort:** M (8 chapters, mechanical but needs eyes)
- **Set by Alex directly on 2026-08-16**, alongside the show-the-simulation rule. His words:
  "we should call the packages for them when we first use them so they know which packages
  to use. If we use the same code later, no need to reload the library." Written up as
  VOICE_GUIDE §14b, which also carries the show-the-simulation half.
- **Current state, measured 2026-08-16:** **28 of the book's 61 `library()` calls are in
  chunks the reader never sees**, across 8 chapters. Nearly all are the hidden
  `load-libraries` block at the top of a file, so a student reading the rendered book is
  never told which packages the chapter needs. Worst offenders by invisible calls:
  `Multiple_Regression_Control` (5), `Hierarchical_Regression` (5), `Intro_to_regression` (2),
  `Power_Effect_Size` (2), `Independent_t_test` (2), `Standard_Error` (1). Chapters 16 and 17
  are partly converted already (Alex did three by hand in 16; the rest were done in that session).
- **The trap:** it is not enough to move `library()` next to first use, because first use is
  often inside a hidden chunk, and a `library()` call in a hidden chunk teaches nobody
  anything. It must be the first use the **reader can see**. Chapter 16 has a live example:
  Alex's `library(GGally)` landed in the `ggpairs-plot` chunk, which inherits `echo=FALSE`,
  so it is still invisible. Flagged to him rather than fixed, because echoing that chunk is
  a reading-experience decision, not a mechanical one.
- **ANSWERED by Alex, 2026-08-17: delete the hidden block.** Once a chapter's packages are
  named at first *visible* use, the hidden top-of-file `load-libraries` chunk goes away. There
  is then exactly one place a reader learns a package is needed, and it is the place they can
  see. Do not keep it as a belt-and-braces summary. **Order of operations matters:** move every
  `library()` call to its first visible use *first*, confirm the chapter still runs top to
  bottom, and only then delete the block. Deleting first will break the file, because some
  first uses are inside hidden chunks that were silently relying on it.
- **Approved:** [x] — instruction given directly, 2026-08-16. Chapters 16, 17 done; Ch15's
  simulation echoed. The other 8 chapters are outstanding.

### [G06] Standardize on the native pipe `|>`
- **Priority:** LOW | **Effort:** M (mechanical + verify)
- 7 chapters use `%>%`; the Tidyverse appendix teaches `|>` and admits the inconsistency. Sweep `%>%` → `|>` (verify each renders), and move the "old pipe means the same thing" note into R_Basics (CH26-B01).
- **Approved:** [ X]

### [G07] Routing callouts at chapter ends ("Which test comes next?")
- **Priority:** MED | **Effort:** M
- Ch6's end-of-chapter router and Ch8/Ch13's forward pointers are the best navigation devices in the book; most chapters just stop. Add a 2–4 line router to each core chapter (per-chapter items note the natural targets, e.g., CH07-U05). In HTML these become the book's de facto decision tree.
- **Approved:** [ X]

### [G08] Inline-compute every reported statistic (no hard-coded results)
- **Priority:** HIGH | **Effort:** M
- Worst offenders: Regression with Cat Variables (CH12-P02 — both write-ups and coefficient tables typed by hand) and Chi-Square (CH22-P01 — a propagated wrong value). Also Ch5's `.957` (CH05-P02), Ch4's 12.75 (CH04-P04). Policy: any number that comes from a model appears via `` `r ` `` expressions. This is the book's own reproducibility sermon (Reporting chapter) applied to itself.
- **Approved:** [ X]

### [G09] HTML navigation: raise `toc-depth`, add repo/issue links, PDF download
- **Priority:** MED | **Effort:** S
- `_quarto.yml` sets HTML `toc-depth: 1`, so the right-hand page TOC shows nothing below chapter level — on a web textbook, section navigation is the primary reading interface; set 2 (or 3). Add `book: repo-url:` (+ `repo-actions: [issue]`) so "tell me before it reproduces" (preface) has an actual channel, `downloads: [pdf]` for the download-the-PDF audience, and confirm search is on (Quarto default). Consider `theme: dark/light` toggle.
- **Approved:** [X ]

### [G10] Fix invalid/inconsistent callout types
- **Priority:** LOW | **Effort:** S
- One `callout-danger` (invalid type; CH14-B01) → `callout-important`. While in there: the book's implicit convention (important = must-not-misunderstand; warning = common mistake; note = context; tip = practice advice) is mostly followed — write it down in a comment at the top of `_quarto.yml` so future chapters comply.
- **Approved:** [ X]

### [G11] De-slide-ification pass on the three oldest chapters
- **Priority:** MED | **Effort:** L
- One-Sample t (CH06-B01), Covariance/Correlation (CH10-U01/B02), and parts of Chi-Square read as speaker notes: stub headings, orphaned bullets, rhetorical questions answered only in Alex's head. The per-chapter items specify the fixes; schedule them as three dedicated sessions since they touch many lines.
- **Approved:** [X ]

### [G12] Deprecated/fragile R idiom sweep
- **Priority:** MED | **Effort:** S
- `..density..` → `after_stat(density)` (CH04-P03; grep book-wide); `aes` fragile self-join (CH04-P02); object named `sample` (CH06-P04); `geom_errorbarh` still fine but note. One pass, render-verified.
- **Approved:** [ X]

### [G13] Consistency micro-fixes (notation & terminology)
- **Priority:** LOW | **Effort:** S
- "linear causal logic" → directional (CH01-P02); Y vs Ŷ (CH11-P01); N-collision in the SEM formula (CH05-P01); "radio and radar" ×2 (CH06-P05, CH09-P03); the b/B/β conventions are actually consistent (B or b raw, β standardized) — leave them, but say so once in Intro-to-Regression.
- **Approved:** [ X]

## 5. Top 20 highest-impact items

Ranked by (reader harm × frequency of exposure). IDs point into chapter files.

| # | ID | What | Why it leads |
|---|---|---|---|
| 1 | CH18-U01 + U02 | lmer, not glmmTMB; add paired-t≡lmer on-ramp | Week 10–13 labs all use lmer; book never shows it |
| 2 | CH07-U01 | Show pooled t + formula syntax beside Welch | Book contradicts the Week 11 lab and exam |
| 3 | CH16-P01 + CH17-P02 | Fix DV identity (closeness vs. friend counts) | Conceptual bug in the two project-critical chapters |
| 4 | CH12-P01 | Omnibus F + protected-t logic around `adjust="none"` | Current claim is wrong and students will repeat it |
| 5 | CH11-U01/U02/U03 | summary() walkthrough, least squares, APA report | Week 5's three deliverables, all missing |
| 6 | CH02-U01 | CSV/factors/table() survival section | Week 3 lab has no book support |
| 7 | G08 | Inline-compute all statistics (Ch12, Ch22 worst) | Silent rot + the already-wrong 124.14 |
| 8 | CH06-P01 + P02 | Fix apa() payoff; define the p-value (pay Ch1's IOU) | Book's hinge concept currently dangles |
| 9 | CH22-B01 | Chi-square stale "later in the semester" refs | Chapter is disoriented about its own position |
| 10 | G03 | Short Story recaps in the 8 missing chapters | The reader this book targets navigates by recaps |
| 11 | G04 | Self-checks with collapsible answers everywhere | Retrieval practice; pattern already proven in Ch14/26 |
| 12 | G05 | Show the simulation code (Ch3, Ch5, Ch10, Ch13) | "Run it yourself" is the book's promise |
| 13 | CH04-U01 | Why N−1 (and why squared) | Curriculum names it; top student question |
| 14 | CH10-P01 | var(Z)→var(A) bug + answer the dangling prompts | Wrong code on the page, in echo=TRUE |
| 15 | CH04-P01 | Income mean from upper bounds, caption says midpoints | Bug in the chapter about means misleading |
| 16 | CH10-U02 | Give Cohen's r benchmarks (then mock them) | Exam-relevant; current refusal costs points |
| 17 | CH08-U01 | Counterbalancing/order effects | Week 12 content absent from its chapter |
| 18 | CH09-P01 | Fix conflated-counts explanation in Power opener | Subtly wrong stats in the flagship chapter |
| 19 | G09 | toc-depth, repo/issue links, PDF download | Web usability + the error-report channel |
| 20 | G02 | fig-alt everywhere | Accessibility; on-mission for this book |

## 6. Preface (index.qmd) feedback

The preface is one of the best parts of the book — do not soften it. Three items:

### [PR-01] Give readers the error-reporting channel the preface asks them to use
- **Priority:** MED | **Effort:** S | **Location:** index.qmd (search anchor: "please tell me before it reproduces")
- The preface asks readers to report mistakes but provides no email, GitHub issues link, or form. Add one sentence with the actual channel (pairs with G09's repo-url).
- **Approved:** [X ]

### [PR-02] Tell readers about the two formats and how to use each
- **Priority:** LOW | **Effort:** S | **Location:** index.qmd (end)
- One short paragraph: web version has search/copyable code (use it while coding); PDF is for reading offline/printing; code is meant to be run, not read. Also link Chapter 1's "How to Read This Book Without Reading All of It" so the preface hands off to it explicitly.
- **Approved:** [ X]

### [PR-03] The ANOVA promise needs a pointer once CH17-U01 lands
- **Priority:** LOW | **Effort:** S
- After the ANOVA cameo exists, the preface's "brief appearance" line should name where (CatXCat chapter). Trivial, but promises should carry addresses.
- **Approved:** [ X]

## 7. Rendered-output (PDF/web) findings

Checked against `Alexs Textbook.pdf` (Box, built 2026-08-12 — current; 323 pp., "Version
0.5"). Text-level extraction only (no visual page rendering available in this environment),
so these are the findings that method supports:

- **Front matter/TOC**: clean; part/chapter numbering correct; cover carries version+date (good practice, keep it updated per release).
- **No gross code/table overflow** detected in extracted text (longest lines ~135 chars are layout-merge artifacts, not overflow). A quick *visual* flip-through for page-break orphans (headings at page bottoms, split code chunks) is still worth Alex's 15 minutes — `\Needspace` is already configured for longtables but not for code blocks or headings; if orphans show up, add `needspace` guards around chunk output in the PDF header.
- **Chapter length balance** (pages): most chapters 6–17 pp — good; Distro_Moments (17), CatXCat (15), Interaction_1 (17), Chi-Square (16) are the heaviest and all have "you can stop here" or Advanced-split items already filed.
- **Web build**: not inspected live (no rendered `_book/` in repo at review time). When first publishing to GitHub Pages: verify mermaid-free math renders, check one long table on mobile width, and implement G09.
- **A dyslexia-friendly gesture worth considering** (on-mission, optional): Quarto HTML supports a font toggle via a small JS/SCSS addition — offering OpenDyslexic/Atkinson Hyperlegible as an optional theme would make the book's origin story part of its design. Filed as a suggestion, not an item.

## 8. Other suggestions (asked for: "any other comments")

1. **A master "which analysis?" appendix** — one page, built from Ch23's decision table + Ch6/Ch8 routing callouts + the regression chapters: *outcome type × design → chapter link*. For the target reader this may be the most-visited page in the book.
2. **A glossary** — bolded terms are introduced well but never collected. Quarto supports a simple glossary page; even an alphabetical list of bold-term definitions with chapter links serves the "I don't read linearly" audience.
3. **Companion data files** — the simulate-everything philosophy is right for the book, but the labs use CSVs; consider a `data/` folder with 3–4 of the book's simulated datasets exported as CSV (chocolate fixation, CTA, friendship) so lab exercises can say "the dataset from your book" — cheap continuity between book and lab.
4. **An "AI and you" box in R_Basics** — the preface is honest about AI as editor; students are using it as author. Two paragraphs in Alex's voice on using AI to *explain* code vs. to *do* homework (and how `?help` + running examples beats pasting errors into a chatbot) would be the most 2026-relevant paragraph in any stats book. Optional, but nobody else has written it well.
5. **Version/changelog page** — the cover says v0.5; a one-page changelog helps returning students and instructors in other sections trust that page numbers moved for a reason.
6. **Draft-chapter roadmap** — the preface promises the grad expansion; a short "coming attractions" list (with the CCAW chapters each will map to) would let grad students plan and would formalize the CCAW-on-ramp positioning.

---

## 9. Running notes (kept for auditability)

### Notation & terminology sightings
- Ch1: "linear causal logic" collides with "linear model" (CH01-P02).
- b/B raw vs β standardized: consistent across chapters ✔ (declare once, CH13/G13).
- "The Short Story" missing in 8 chapters (verified by grep; see G03).
- `%>%` in 7 chapters vs `|>` in Tidyverse appendix (G06).
- callout-danger: 1 instance, Ch_15_Statistical_Control (G10). fig-alt: 0 instances book-wide (G02).

### Recurring voice assets (protect from editors)
- Statistics/Probability Gods, Dorkaos, Reviewer 2, foam chainsaw, coerced-undergrad-labor arc, effect-size bats, "rectangular coffins," "statistical identity theft," "celestial punctuation," "computation is not forgiveness."

### Cross-chapter dependencies to keep consistent when editing
- CTA storyline: Ch5 → Ch7 → Ch9. Chocolate fixation: Ch8 → Ch9 → (proposed) Ch18 on-ramp. Friendship study: Ch16 ↔ Ch17 (must be edited as a pair). Exam study (StudyHours/Anxiety): Ch13 ↔ Ch14 ↔ Ch15 (identical simulated data — keep seeds in sync).
- Ch1 IOU (real definition of significance) → pays off in Ch6 (CH06-P02) → Ch20 owns the full definition.
- Salmon: Ch3 → Ch18 → Ch20 (hub). Hoekstra CI study: Ch5 (keep) + Ch24 (compress, CH24-U01).

### Progress
- [x] Skeleton created
- [x] 01–26 chapter reviews complete (see files)
- [x] PDF currency check + text-level layout scan
- [x] Cross-cutting items grounded by grep (pipes, fig-alt, Short Story, callout-danger)
- [x] Global pass / this file finalized
