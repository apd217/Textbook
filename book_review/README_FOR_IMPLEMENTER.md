# READ THIS FIRST — Rules for the AI Implementing This Review

This folder contains a chapter-by-chapter review of Alex Demos's statistics textbook
(the `.qmd` files in the project root). Each file `NN_<ChapterName>.md` contains feedback
items for one chapter. `00_OVERVIEW.md` contains book-wide findings and the priority list.

## Your job

Implement **only** the items whose `**Approved:**` box is checked. A box counts as checked
if it contains an `x` or `X` anywhere inside the brackets — Alex's checkmarks vary in
format (`[x]`, `[X ]`, `[ x]` all mean approved). An empty `[ ]` is NOT authorized. Do not
implement unapproved items, do not "improve" nearby text while you are in the file, and do
not fix things you happen to notice unless Alex asks.

## Branch

All implementation work happens on the `review-implementation` branch. Never commit
directly to `main` — `main` is what GitHub Pages will eventually deploy from, so it stays
in a known-good, fully-rendered state while this branch absorbs edits. If you find yourself
on `main`, run `git checkout review-implementation` (or `git switch review-implementation`)
before touching any file. When a batch of chapters is done and rendering clean, Alex reviews
the diff and merges into `main` themselves — do not merge or push to `main`.

## Status as of 2026-08-16, end of the Chapter 18 session (READ THIS FIRST)

**Chapter 18 is done, and it was the last chapter. Every item in the review is now implemented.**
One commit, on `review-implementation`, not merged to main. Alex has not read it yet.

Implemented: CH18-U02, CH18-U01, CH18-P01, CH18-U03, CH18-P02, CH18-U04, plus G01 and G02.
Details are on each item in `18_Mixed_Regression.md`.

**Two things need Alex, and one of them is a loose file.**

1. **`Chapter_Mixed_Designs.qmd` is modified, uncommitted, and nobody knows who wrote it.** Its
   working-tree version duplicates Ch18's structure (same chocolate on-ramp, same seed, a
   Week 0 vs Week 6 2×2, a 2×4 in Advanced Topics). Its mtime is 2026-08-17 00:02, *after* the
   23:28 Ch18 commit, and it reuses Ch18 prose from that day verbatim, so it postdates and drew
   on this session's work but was not produced by it. Logged as **CH18-DUP01**. It is not in git,
   so it can be lost. Do not build on it or commit it without asking.
2. **The 2×4 material is now a real file: `Chapter_Mixed_Change_Over_Time.qmd`.** Extracted from
   the Ch18 history, made self-contained, renders clean, every number re-verified against the
   original run (interaction $-1.02796$, $SE = 0.11021$, $df = 98.001$, $t = -9.328$; LRT
   $\chi^2(1) = 63.539$; `emtrends` Control $-0.295$ against CBT $-1.322$). It is **not** in
   `_quarto.yml`, matching the other drafts. It carries a `bibliography: references.bib` line of
   its own so the Bennett citation resolves on a standalone render, which it does not without it.
   Its own `---Alex---` header lists what is still missing. **The filename is a guess and the
   CH18-DUP01 overlap with `Chapter_Mixed_Designs.qmd` is unresolved**, so do not add it to
   `_quarto.yml` until one of the two files wins.

The five things worth carrying forward:

1. **Alex answered the ordering question: neither move nor split, for now.** Ch18 stays last as
   one chapter, and the CH18-U02 on-ramp was written self-contained so it can be lifted into its
   own Week-10 chapter later without a rewrite. Moving the whole chapter earlier was rejected on
   a dependency, since Week × Group is a continuous-by-categorical interaction and that is
   Interaction_1's material. The split is still available and the item records exactly which
   block would move.
2. **He approved a cold open, again, when asked.** That is now three chapters running (15, 16,
   18) where flagging a §15 failure produced a yes. The device here is §17's identity payoff:
   the paired *t*-test and `lmer(fixation ~ condition + (1 | participant))` return the same
   *t*, df, *p* and estimate, and the chapter prints them side by side. **Keep flagging openings.**
3. **Running the code caught two more wrong numbers, one of them in the book's own prose.** The
   chapter claimed the interaction was "about $-1.2$", which is the value baked into the
   `rnorm()` call, not the value the model returns ($-1.03$). This is a **new failure mode worth
   naming: prose that reports the simulation's ingredients as if they were its results.** It is
   invisible unless you fit the model. Worth a grep in any chapter that simulates an effect and
   then describes it. Separately, `lmer` throws a convergence warning where `glmmTMB` did not,
   fixed with `bobyqa` and explained rather than hidden.
4. **Write `fig-alt` against the rendered PNG, not against the plotting code, and expect to be
   wrong more than once.** The diagnostic figure took **three** attempts. Draft one, written from
   the code, said the smoother lay flat; it did not. Draft two said it only wandered at the sparse
   edges; it did not, there was a real trend. Only after running the diagnostics down did the
   actual cause appear, and it was not the first plausible explanation either: a shrinkage story
   was tested and rejected before the omitted random slope turned out to be responsible. **Look at
   the image, then quantify what you think you see, then explain it.** All three steps failed
   independently here.

5. **Alex's altitude complaints are sometimes statistical facts wearing a pedagogical hat.** He
   said the jump from a 2-level design to a 2×4 with random slopes was too fast. Checking it
   turned up that a random slope is not *estimable* on two occasions at all: `lmer` errors, and
   two points determine a line exactly. His instinct located a real constraint, not a preference.
   Worth checking whether other "this feels too advanced" notes have the same character.

**Nothing in `10`–`25` is outstanding.** What remains for the book is Alex's own reading pass,
the still-commented-out draft chapters (`Advanced_Contrasts_ANOVA` is the ripest; see below),
and the two Part 1 em-dash chapters nobody has been authorized to touch.

## Status as of 2026-08-16, end of the 16+17 session

**Chapters 16 and 17 are DONE, committed, and Alex has read and edited both.** Do not reopen
them. **Chapter 18 (Mixed Regression) is the last chapter, and it is your whole job.**

### Chapter 18: everything already verified for you, so you do not redo it

Groundwork was run at the end of the 16+17 session specifically so the next session starts
from facts instead of assumptions. All of the following was **executed, not assumed**:

- **`lme4`, `lmerTest`, `glmmTMB` and `emmeans` are all installed.** The CH18-U01 conversion
  is not blocked on anything.
- **CH18-U02's central claim is TRUE and the numbers are these.** Rebuilding the paired-t
  chapter's chocolate data (`set.seed(343)`, `n <- 48`, objects `paired_wide` / `paired_long`,
  factor levels "No chocolate" / "Chocolate") and fitting
  `lmer(fixation ~ condition + (1 | participant))` reproduces the paired *t*-test **exactly**:

  | | paired `t.test` | `lmer` + lmerTest |
  |---|---|---|
  | *t* | 4.336614 | 4.336614 |
  | df | 47 | 47 |
  | *p* | 7.5972e-05 | 7.5972e-05 |
  | estimate | 0.78524 | 0.78524 |

  Identical to six decimals, Satterthwaite df included. **Write the section around these
  numbers, but re-run them yourself before you publish prose about them.** Note the estimate
  is the mean *difference*, so the fixed effect is the chocolate effect in seconds.
- **The paired-t chapter already routes here** (`Chapter_Paired_t_test.qmd:317` links to
  `Chapter_Mixed_Regression.qmd`), so CH18-U02 lands exactly where a reader arrives.
- **The chapter has 7 `glmmTMB` calls, 0 `fig-alt`, and full YAML residue** (`geometry`,
  `fontsize`, `format: pdf:`). So G01 and G02 are both outstanding here.
- **`Chapter_Mixed_Inference.qmd` is still commented out of `_quarto.yml`**, so CH18-P01's
  broken forward reference is real.

### Chapter 18: how to run the session

1. **Do CH18-U02 first, not CH18-U01.** It is additive, it is the highest-value thing in the
   file, its numbers are already verified above, and doing it first means you have read the
   chapter properly before you start rewriting its engine.
2. **CH18-U01 is DECIDED, not open.** Alex, 2026-08-16: *"I think I want to go back to LMER for
   this chapter to keep it easier."* `lmer()` + `lmerTest` is the primary engine. Do not
   re-argue it, and do not build a long glmmTMB comparison; he is optimising for the
   undergraduate, so glmmTMB shrinks to a short aside or leaves for `Mixed_Inference`.
   **CH18-U01 changes every number in the chapter.** Seven `glmmTMB` calls become `lmer`.
   Run the new models, read the actual output, and rewrite the surrounding prose to match.
   Do not port sentences across and assume they still hold. The z-versus-t difference is the
   whole point of the item, so every "z = " in prose is a defect after the swap.
3. **Alex reviews the diff before commit.** CH18-U02 is Tier 3.
4. Then CH18-P01, CH18-U03, CH18-P02, plus G01 and G02.

### One open question for Alex, which he has not yet answered

The review file's **ordering note**: the curriculum needs this chapter's first half in Week 10,
*before* the interaction chapters, but the book puts it last in Part 2. The options are to move
the chapter earlier, or to split it so the new paired-t on-ramp sits at the Week-10 position
while the CBT longitudinal material stays as the finale. **Ask before implementing either.**
The parallel decision in the 14+15 session (the Part 2 reorder) is the precedent for how much
this can churn.

**Chapters 16 and 17 are done and committed, one commit each, not merged to main.**
Every item in both files is implemented and marked. Alex has not read them yet.

**The shared DV bug is fixed in both, the same way.** The variable is now literally called
`Closeness`, not `NewFriends`, so the printed model output agrees with the prose instead of
contradicting it. Alex chose the rename over the prose-only option. If you touch either
chapter, the two must stay identical: they share a simulate chunk and a story.

**Chapter 16 got a cold open** (Alex approved it mid-session). It runs the two separate
regressions the chapter used to only imagine, and lands on the absence of any test of the
gap between them. The device pays off twice more, at $B_3$ and at `emtrends()`, because the
separate-regression slopes `0.1998` / `4.9042` are *identical* to $B_1$ and $B_1 + B_3$.
**Chapter 17 got a light touch instead**, by Alex's explicit choice: its "what changes /
what stays the same" scaffolding is deliberate and is untouched; only the recap paragraphs
moved out of first position.

### Things that bit us this session, for the next one

1. **Items are still wrong about their own numbers, and now so is the prose.** Two claims in
   Ch17 were false and were not in the review at all: "both around 15" for cell means that
   are 16.0 and 22.6 (a gap the chapter itself later reports as significant), and "$d = 0.45$,
   a negligible effect". Both were caught by running the chapter's code before writing about
   it. **Keep doing that. It has now paid off in three consecutive sessions.**

2. **Rounded intermediates will silently break an identity you are trying to demonstrate.**
   Ch17's `t3` was already rounded to 2 dp in an earlier chunk. Squaring it gives 126.91
   against an $F$ of 126.90, which would have quietly undercut the whole "same test" point.
   Square the raw value. There is a comment in the chunk saying so.

3. **`scale()` returns a one-column matrix, and `lm()` accepts it without complaint.** That
   is what makes it dangerous: nothing fails until some package downstream refuses the model
   with an incomprehensible `nmatrix.1` error, which is exactly what `sjPlot::plot_model()`
   did. Ch16 now centers with `as.numeric(scale(...))`. **Check other chapters that center.**

4. **A single-chapter `quarto render` can trigger a full-book PDF pass.** It rewrote
   `execute-results/tex.json` and `figure-pdf/*` for about fifteen chapters nobody touched,
   deleted `_freeze/site_libs/`, and left an `index.tex` behind. None of that was committed:
   only the two edited chapters' freeze artifacts went in. **Check `git status` before you
   stage, and restore `_freeze/site_libs` if it shows as deleted.** Those unrelated `_freeze`
   modifications are still sitting uncommitted in the working tree.

### Em-dashes: the list is finished, but two chapters are still high

`Chapter_CatXCat_Interaction` went **5.35 to 0.20**, the floor. That was the last chapter on
the outstanding list. Current standings put two chapters above target, and **only one of them
was previously known**:

- `Chapter_Distro_Moments` at **6.45** (known; Part 1, finished, leave unless Alex asks)
- `Chapter_Introduction` at **3.16** (**not previously flagged anywhere**; also Part 1 and
  finished, so same rule applies, but somebody should tell Alex it exists)

### New standing policy from Alex, 2026-08-16: show the simulation, name the package

Given directly, after he read Ch16: **"in all chapters, we should SHOW them the simulation;
otherwise, they cannot run my lecture on their own"** and **"we should call the packages for
them when we first use them... If we use the same code later, no need to reload the library."**
Written up as **VOICE_GUIDE §14b** and **G05b** in `00_OVERVIEW.md`. It refines G05 rather
than replacing it: the simulation is now classified as statistics, not plumbing. Hidden code
is still fine for genuine scaffolding.

Where it stands after this session:

- **Simulations: essentially done, and it was one chunk.** An audit of every chapter in
  `_quarto.yml` found exactly **one** hidden data-making chunk in the whole book, in
  `Chapter_Hierarchical_Regression`. It is now echoed with a lead-in line. Everything else
  was already visible. Do not go hunting; the job is finished.
- **Libraries: 8 chapters outstanding, 28 invisible `library()` calls.** See G05b for the
  per-chapter counts and for the trap that makes this less mechanical than it looks (first
  use is often in a hidden chunk, where a `library()` call teaches nobody anything).
- **Alex should be asked** whether the hidden top-of-file `load-libraries` block gets deleted
  once packages are named at point of use, or kept as a summary. Both were left in place.
- **The Introduction** now carries a callout saying the `.qmd` files are downloadable and
  runnable, and that some chunks are hidden on purpose. That was the fourth thing he asked for.

### Type III sums of squares: the trap, written down once

Ch17 originally used Type II. Alex corrected it to Type III on 2026-08-16 and was right:
psychology's ANOVA tables are Type III because SPSS `GLM` defaults to Type III. Switching
introduced two defects that anything in this book reaching for Type III will hit again:

1. **`car::Anova(type = 3)` inserts an `(Intercept)` row.** Every positional index shifts by
   one and nothing errors. Index by row name, always.
2. **Type III is invalid under R's default dummy coding.** `contr.treatment` is right for the
   rest of these chapters, because it is what makes $B_1$ and $B_2$ readable as simple effects.
   Ask for Type III on such a model and you silently get the simple-effect *t*-tests back,
   squared. Fit a **separate** model with `contr.sum` for the Type III table and leave the
   original alone. Ch17 now has a `callout-warning` teaching exactly this.

### Advanced material: the chapter you want probably already exists

Before writing new advanced content, **check `Chapter_Advanced_Contrasts_ANOVA.qmd`**. It is
195 lines, already written, and merely commented out of `_quarto.yml`. It covers dummy coding,
planned contrasts, effect coding via `contr.sum`, contrast weights as hypotheses, and
estimability, on a three-level example. Ch17 now points at it (without a hyperlink, since it
is not in the book, **so add the link when it ships**). Alex has graduate lecture material to
fold into it. It deserves its own session, and CH17-U04 lists the duplication to resolve.

### What is left

**Chapter 18 (Mixed Regression), on its own, with a fresh session.** Unchanged advice:
CH18-U01 is a real code conversion (glmmTMB → lmer, which changes every output) and CH18-U02
is Tier 3 narrative. Do not tack it onto the end of anything.

One thing Ch18 can now reuse: the preface's ANOVA promise is **paid** as of this session, in
Ch17's "The ANOVA Costume". `Chapter_Advanced_Contrasts_ANOVA.qmd` is still commented out of
`_quarto.yml`, so that section is currently the book's only ANOVA appearance. If that chapter
ever ships, cross-reference rather than duplicate.

## Status as of 2026-08-16, end of the 14+15 session

**Chapters 14 and 15 are finished and Alex has read and edited both.** Every item is
implemented or marked as needing no change: CH14-B01, P01, U01 and CH15-P01, P02, U01.
Chapter 15 also got a full voice pass, approved by Alex mid-session, logged as CH15-VOICE in
`15_Hierarchical_Regression.md`. Do not reopen either chapter without instruction.

**Your job is chapters 16 (Interaction_1) and 17 (CatXCat), together.** The grouping is not
optional: CH16-P01 and CH17-P02 are the same bug wearing two hats. See below.

### The five things that will actually bite you

1. **Items written before the Part 2 reorder can point the wrong way. Check `_quarto.yml`,
   never the item.** CH15-P02 said "you met this quantity in the Control chapter." After the
   reorder Control comes *after* Hierarchical, so the whole sentence had to flip into a
   forward pointer. The order today is: Multiple Regression, **Hierarchical**, **Control**,
   Interaction_1, CatXCat, Mixed Regression. Any item that says "previous chapter," "earlier,"
   or "we saw in" is a claim to verify, not a fact.

2. **An item can be wrong about its own numbers.** CH15-P02 implied Hierarchical and Control
   share the $sr^2$ value. They do not: Hierarchical residualizes Anxiety ($sr^2 = .067$),
   Control residualizes Study Hours ($sr^2 = .110$). Same identity, different predictor. Run
   the numbers before you write a sentence claiming two chapters match.

3. **Alex's own edits sometimes need repair, and he expects you to catch it.** In this session
   his Ch15 pass introduced two real defects: dropping "sequential" as a synonym left the
   disambiguation callout saying hierarchical regression is also called hierarchical
   regression, and `R^2` typed outside math renders as a literal caret, "R^2", in the heading
   *and* the TOC. Both were fixed and flagged back to him. **Re-render and re-read after he
   edits.** Do not assume his version is clean just because it is his.

4. **`R^2` outside math is a live bug elsewhere in the book.** Pandoc needs `R^2^` or `$R^2$`.
   `Chapter_Multiple_Regression_Control.qmd` still has it in three headings (lines 329, 389,
   395) and is marked finished, so it needs Alex's say-so. The correct pattern is
   `## Residual Variance and $R^2$` in Intro_to_regression.

5. **`check_render_safety.R` counts differently since 2026-08-16.** It now strips HTML
   comments and YAML fences, so every chapter's number dropped by about two, and a clean file
   reports **1**, not 0. Treat 1 as the floor. Numbers written before that date read about two
   high. The change exists because three `---Alex---` notes used to fake a spike of 6.

### What is done, so you do not redo it

- **Em-dash cleanups: one left.** Hierarchical went 9.48 to the floor. **`Chapter_CatXCat_Interaction`
  at 5.35 is yours**, in this session. `Chapter_Distro_Moments` at 6.45 is Part 1 and finished;
  leave it unless Alex asks.
- **Italic *t* and *F*: done book-wide, 2026-08-16**, 76 symbols across 15 chapters, at Alex's
  request. Only the hyphenated compounds were swept (`*t*-test`, `*F*-test`, `*t*-value`,
  `*F*-statistic`, `*t*-distribution` and friends). **Bare `t` and `F` were deliberately left
  alone** and you should leave them alone too: a survey found 44 "bare t" hits that were mostly
  `don't`, and the "bare F" hits were inside multi-line `$$` blocks plus Bootstrapping's `t(F)`
  functional notation, which is real math. The sweep script is
  `book_review/tools/italicize_tF.R`; it protects YAML, code chunks, `#|` option lines
  (`fig-alt` especially, where markdown is not parsed and asterisks would be read aloud),
  inline code, and math. Run it dry first. **Not yet swept: `p`, `r`, `M`, `SD`, `N`, `df`.**
  APA italicizes those too. Ask Alex before extending.
- **G01 (YAML strip), G02 (`fig-alt`), G10 (callout types)** are applied in 10 through 15 as
  each chapter was touched. Chapters 16 and 17 still carry dead `format:` blocks, and Ch16/17
  additionally carry an `html:` block. `callout-danger` is gone book-wide; the convention is
  now written at the top of `_quarto.yml`.

### Chapters 16 and 17: what the grouping is for

**CH16-P01 and CH17-P02 are one bug.** The DV is a 0 to 100 closeness thermometer and both
chapters keep calling it a count of friends. Fix it in one and not the other and the book
contradicts itself. Chapter 16 already has the contradiction *internally*: the study is
described with a thermometer at the top, and the hypothesis plots are labelled "Predicted New
Friends". These are also the two largest files in Part 2, 44KB and 36KB.

Before you start: re-read `VOICE_GUIDE.md` §15 and check both chapter openings. Ch16 opens on
"Where We Are and Where We Are Going", which is a recap, the same failure Ch10 and Ch15 had.
Chapter 15's cold open is the freshest worked example of the fix.

**Alex has already been editing Ch16 by hand.** As of this session: "in the course" became
"in the book" (three places, one of which he missed and was completed for him), and the
z-score formula became `$$Z = \frac{X - M}{S}$$` to match Distro_Moments and Covariance. Diff
against `git log` before assuming anything about that file's state.

### What the Chapter 15 voice pass established, which 16 and 17 can reuse

The cold open that worked was a **demonstration that indicts the tool**: ten columns of
`rnorm()` added to a real model, $R^2$ climbing every time. It landed because the numbers were
real and slightly embarrassing (ten junk predictors bought $\Delta R^2 = .063$, the one real
predictor bought $.067$), and because the same device came back twice later as a callback: a
5,000-run null distribution that motivates the F-test, and the junk columns re-entered as a
block to show the test correctly killing them. **Plant, then pay off twice.** Alex kept all of
it and added to it.

Two process notes from that pass. **Verify before you write**, every time: the F equals t
squared claim, the FWL standard errors, and the simulation-versus-formula agreement were all
run first and the prose written to match, which is why none of them needed correcting. And
**flag rather than smuggle**: the voice pass happened because the dryness was raised as an
`---Alex---` note and a line in this file, and Alex then asked for it. He says yes to scope
expansion when you ask. He should not have to discover it in a diff.

## Status as of 2026-08-15

**Part 1 is finished.** Every approved item in `01`–`09` is implemented and marked. Do not
re-open those chapters except on Alex's instruction.

**Chapters 10, 11, 12 and 13 are finished.** **Every item in `10`–`25` is approved** (Alex
ticked them all on 2026-08-15), so approval is no longer the gate.

**Chapters 10–13 have been through Alex's own edit pass and a follow-up cleanup** (2026-08-16):
grammar, em-dash reduction, and a render-safety sweep. Treat them as done.

**Two dash cleanups were outstanding here. One is done; see the 2026-08-16 block above.**

- `Chapter_Hierarchical_Regression.qmd` was at **9.48** em-dashes per 1000 words, the worst in
  the book. **Fixed 2026-08-16** in the 14+15 pass.
- `Chapter_Distro_Moments.qmd` is at **6.69** and `Chapter_CatXCat_Interaction.qmd` at **5.60**
  (old baseline; subtract about 2 for the current script). Distro_Moments is Part 1 and
  finished, so leave it unless Alex asks; CatXCat is chapter 17 and should be fixed in the
  16+17 session.

**Remaining Part 2 work: chapters 16, 17, 18.** Chapters 14 and 15 are done. Suggested
grouping, and the reasoning matters more than the grouping:

- ~~**14 (Control) + 15 (Hierarchical) together.**~~ **Done 2026-08-16.** They were joined by
  one identity: CH15-P02 asks for the connection that $\Delta R^2$ *is* the $sr^2$ from the
  Control chapter, computed on the same data. Doing them in one session is how that stayed
  consistent, and it is how the direction error in the item got caught. Note the reorder put
  Hierarchical *before* Control, so Control is the payoff chapter and Hierarchical is where
  the reader first meets $\Delta R^2$. CH15-B01 was already moot.
- **16 (Interaction) + 17 (CatXCat) together.** CH16-P01 and CH17-P02 are the *same* bug: the
  DV is a 0–100 closeness thermometer but both chapters keep calling it a count of friends.
  Fixing it in one and not the other leaves the book contradicting itself. These are also the
  two largest files in Part 2 (44KB and 36KB).
- **18 (Mixed Regression) on its own, with a fresh session.** CH18-U01 is a real code
  conversion (glmmTMB → lmer, which changes every output in the chapter) and CH18-U02 is new
  voice-bearing narrative that this README classifies as Tier 3. Do not tack it onto the end
  of a long session.

**The Part 2 ordering swap is done.** Hierarchical now sits directly after Multiple Regression,
with Control closing the trilogy. See the DECIDED block in `00_OVERVIEW.md` §2. Recommendation
2 (moving Mixed Regression earlier) was declined, and CH15-B01 is moot as a result.

### Lessons from Chapter 10 that apply to every remaining chapter

1. **Check the chapter's opening first.** Chapter 10 opened on a bulleted definition list, and
   Alex's verdict was that it "started out different from the others and the text is pretty
   dry." `VOICE_GUIDE.md` §15 is now the spec for openings. Do this before item work, because
   it often reframes the rest of the chapter.
2. **Re-read the preface before and after each chapter.** Alex asks for this directly. It is a
   contract: every idea gets a picture, a story, or runnable code, and no long stretch passes
   without a simulation, an analogy, or a joke. Audit against it when you finish.
3. **No hanging figures or captions.** Every figure needs a caption saying what it shows, and
   where a figure demonstrates a transformation the caption must name *what happened to each
   axis* ("X axis: ice cream, raised to the fourth power. Y axis: happiness, untouched."). A
   bare plot with no lead-in text is the most common dryness bug in this book.
4. **Name every chunk.** Anonymous chunks produce `unnamed-chunk-N` figure filenames that shift
   whenever a chunk is added, silently invalidating the freeze cache. Ch10 had 20 of them;
   chapters 11 and 12 still do.
5. **Verify package output before describing it.** Two Ch10 claims would have been wrong from
   memory: `ggpubr` prints a capital italic `R` with no df and a scientific-notation p, and
   `GGally`'s stars are `***` <.001, `**` <.01, `*` <.05, `.` <.10. Run it and read the output.
6. **Inline-compute every number in new prose** (G08). Ch10 defines an `apa.r()` helper in its
   `pirate-r` chunk so inline correlations print APA style (`.60`, not `0.60`). Reuse that
   pattern; do not define it twice in one file.
7. **Leave focus notes as `<!-- ---Alex--- ... -->`.** HTML comments, so they never render into
   a student-facing build, and greppable so Alex can pull them all at once with
   `grep -rn -- "---Alex---" *.qmd`. Use them for new voice-bearing prose, judgment calls, and
   deviations. He deletes the comment and keeps the prose when he agrees.
8. **Deviating from an item is fine when the item is internally inconsistent.** Say so on the
   item. CH10-U03's code named one variable while its framing implied another; the deviation
   and its reasoning are recorded there.

### Known issue: the book will not build to PDF from a clean checkout

Both chapters whose *filenames contain spaces* fail with `Unable to load picture or PDF file`.
`*_files/` is gitignored, and for those two the freeze cache does not preserve `figure-pdf`,
because Quarto rewrites `Chapter_Covariance and Correlation` to
`Chapter_Covariance-and-Correlation` and the supporting-files bookkeeping does not survive the
rename. Confirmed pre-existing: reproduced with every Chapter 10 edit stashed. It works on
Alex's machine only because those gitignored directories linger from earlier renders. The fix
is renaming both files plus their `_quarto.yml` entries, and it needs Alex's approval.
**Verify with `--to html`, which is unaffected.**

Things established during Part 1 that apply to Part 2:

1. **Part 1 is the 242 course; Part 2 is the 343 course.** Different audiences. Part 1
   readers are new to R and to statistics; Part 2 readers have had Part 1. This is why Part 1
   comments code on first use and walks through R output, and why Part 2 can move faster.
2. **Part 1's chapter order was changed** to match the 242 syllabus: Power now sits between
   One-Sample t and Independent t. See the CORRECTION block in `00_OVERVIEW.md`. If a Part 2
   item's reasoning depends on Part 1's old order, re-check it.
3. **Em-dashes are rationed.** Alex asked for this explicitly. Do not introduce `---` or `—`
   in new prose. Use commas, colons, or full stops. Existing ones in his own text stay.
4. **"Bounce around" is the house term** for sampling variability, grounded in the
   bouncing-ball image planted in the Probability chapter. Do not invent a synonym ("wobble"
   was tried and rejected).
5. **`fig-pos: 'H'`** is now set in the pdf format block of `_quarto.yml`, so figures stay
   where they are written. It was previously under `execute:`, where it did nothing, which is
   why figures floated away from their text in the PDF.
6. **Tables render at `\small` in PDF and .82rem in HTML**, matching the callout register.
   Set in `_quarto.yml` and `styles.scss`. Do not restyle tables per chapter.
7. **Report the exact p-value** to 2–3 decimals, `p < .001` below that. Settled in Ch7.
8. **Code comments go on first use of a function**, not every use. R output gets walked
   through the first time a reader meets that kind of output (see Ch6's "Reading What R Just
   Handed You" for the pattern to copy).

### Windows/Dropbox render note

Renders intermittently fail with `os error 32` file locks, and Quarto sometimes fails to copy
figures from `_freeze/` into `Chapter_X_files/`, producing `Unable to load picture or PDF
file`. The fix is not to re-run blindly:

1. `rm -f index.tex`
2. If a figure is named in the error, check `_freeze/<chapter>/figure-pdf/` — the file there
   is usually fine and only the working copy is missing.
3. `mkdir -p Chapter_X_files/figure-pdf && cp _freeze/Chapter_X/figure-pdf/*.pdf Chapter_X_files/figure-pdf/`
4. Re-render.

Never "fix" this by deleting `_freeze/`; that throws away every cached result in the book.

## Hard rules

0a. **Run the render-safety check before you finish any chapter. Alex asked for this by
   name on 2026-08-16.**

   ```bash
   Rscript book_review/tools/check_render_safety.R
   ```

   **`Rscript` is not on PATH on Alex's machine.** Call it by full path instead, adjusting the
   version if R has been updated since 2026-08-16:

   ```bash
   "C:/Program Files/R/R-4.6.0/bin/Rscript.exe" book_review/tools/check_render_safety.R
   ```

   It reports three things: characters that will silently vanish from the PDF, em-dash
   density per chapter, and possible hyphenated compounds mangled by a dash replace. Fix
   everything it finds in the chapter you are working on before you commit.

   **Why this matters more than it sounds.** The book builds PDF with xelatex in CMU Serif
   and CMU Sans, and those fonts are missing a handful of ordinary characters. xelatex does
   not error on a missing glyph. It drops the character and carries on, so the HTML looks
   perfect and the PDF quietly loses a symbol in the middle of a sentence. Alex caught this
   by eye; nothing in the toolchain was going to tell us.

   Verified against the book's own fonts by reading the xelatex log, not guessed:

   | Status | Characters |
   |---|---|
   | **BREAKS the PDF** | `↔` U+2194, `⇒` U+21D2, `⁴` U+2074, `≠` U+2260, `≤` U+2264, `≥` U+2265, `≈` U+2248 |
   | **Safe** | `→` `²` `³` `−` `×` `±` `•` `…` `Δ α β ρ σ μ`, smart quotes, en dash, em dash, `à é` |

   Note the traps, because they are not intuitive: the **right** arrow is fine but the
   **double-headed** arrow is not, and superscript **2 and 3** are fine but superscript
   **4** is not. Never reason from one character to its neighbour, and never conclude a
   character is safe because the HTML looked right.

   Fixes, in order of preference: write it in words ("raised to the fourth power"); use
   math mode (`$\neq$`, `$\leq$`, `$\approx$`, `$\leftrightarrow$`); or use plain ASCII
   inside code comments (`<->`). If you need a character not on either list above, add it
   to the test file and re-run xelatex rather than assuming.

0b. **Read `VOICE_GUIDE.md` in this folder before writing a single sentence of prose.**
   It is the spec for how this book sounds, with calibration examples of the two standard
   failure modes. Every piece of new or rewritten prose must pass its §9 checklist. If an
   item requires new prose "in voice" and you are not confident, draft it as an HTML
   comment (`<!-- DRAFT for Alex: ... -->`) next to the location instead of shipping it.
1. **Preserve the voice.** The book is deliberately funny, self-deprecating, and informal
   (Statistics Gods, Probability Gods, effect sizes measured in Nerf bats, the title is a
   *Zoolander* reference). Your edits must sound like Alex, not like a textbook committee.
   When an item includes drafted replacement text, use it verbatim or with minimal fitting.
   When it doesn't, match the surrounding register. Never make the prose more formal,
   more hedged, or more corporate — and never zanier either (see VOICE_GUIDE.md §8).
2. **Never change a statistical claim beyond what the item specifies.** If implementing an
   item seems to require altering the math or a substantive claim in a way the item does
   not describe, STOP and flag it for Alex instead of guessing.
3. **Keep code runnable.** Any R chunk you touch must still run top-to-bottom. Keep or add
   `set.seed()` wherever randomness affects output. Do not change package choices
   (base R early chapters, `emmeans`, `lme4`, `sjPlot`, `ggpubr` later) unless the item says to.
4. **Edit `.qmd` source only.** Never edit anything in `*_files/`, `*_cache/`, or `_book/`
   — those are generated.
5. **Verify by rendering.** After editing a chapter, run
   `quarto render <chapter>.qmd --to html` and confirm it renders without errors.
   If an item is marked "verify by running," actually run the relevant code.
6. **One chapter per commit**, message format: `Review edits: <chapter> (<item IDs>)`.
7. **Mark what you did.** After implementing an item, change its `**Approved:** [x]` line to
   `**Approved:** [x] — IMPLEMENTED <date>`. If you had to deviate or skip, write
   `— SKIPPED/PARTIAL: <one-line reason>` so Alex can audit.

## Item anatomy

```markdown
### [CH11-U02] <short title>
- **Priority:** HIGH | MED | LOW      ← impact on the reader, not effort
- **Perspective:** Student | Professor | Publisher
- **Effort:** S | M | L               ← S = minutes, M = an hour, L = restructuring
- **Location:** <file> → <section> (search anchor: "<literal string in the file>")
- **Problem:** <diagnosis>
- **Fix:** <the instruction you execute>
- **Approved:** [ ]
```

The search anchor is a literal string that occurs in the target `.qmd`; use it to find the
exact spot. If the anchor no longer exists (Alex edited the file since the review), flag the
item instead of guessing.

## Sensible order of work

1. All approved HIGH items, book order.
2. Then MED, then LOW.
3. Items marked Effort L (restructures, splits, merges) should each get their own session —
   read the whole chapter first, and re-read the item's full text including any sketch of
   the target structure.

## Task tiers (which kind of session handles what)

- **Tier 1 — mechanical, no prose judgment** (any competent model; batchable): G01 YAML
  strip, G06 pipe sweep, G12 idiom sweep, G10 callout types, G08 inline-stat conversion,
  and all typo-sweep items (CH06-U03, CH10-B01, CH22-B02). Verification is a render diff.
- **Tier 2 — guided edits with drafted fixes** (the default; strong model recommended):
  most CHnn items — the instruction specifies location, content, and often wording;
  judgment is limited to stitching.
- **Tier 3 — new voice-bearing prose** (strongest model available, and Alex reviews the
  diff before commit): G04 self-check questions, G03 recaps where no bullets were drafted,
  CH18-U02 (the paired-t ≡ lmer on-ramp narrative), G11 de-slide-ification, and any item
  whose Fix says "in voice" without drafted text. Before a Tier-3 session, run the
  audition in VOICE_GUIDE.md §10.4.
