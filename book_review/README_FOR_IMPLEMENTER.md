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

## Status as of 2026-08-15 (read before starting Part 2)

**Part 1 is finished.** Every approved item in `01`–`09` is implemented and marked. Do not
re-open those chapters except on Alex's instruction.

**Chapters 10, 11, 12 and 13 are finished.** **Every item in `10`–`25` is approved** (Alex
ticked them all on 2026-08-15), so approval is no longer the gate.

**Remaining Part 2 work: chapters 14, 15, 16, 17, 18.** Suggested grouping, and the reasoning
matters more than the grouping:

- **14 (Control) + 15 (Hierarchical) together.** They are joined by one identity: CH15-P02
  asks for the callback that $\Delta R^2$ *is* the $sr^2$ from the Control chapter, computed on
  the same data. Doing them in one session is how that stays consistent. Note the reorder put
  Hierarchical *before* Control, so Control is now the payoff chapter and Hierarchical is where
  the reader first meets $\Delta R^2$. CH15-B01 is already moot.
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

0. **Read `VOICE_GUIDE.md` in this folder before writing a single sentence of prose.**
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
