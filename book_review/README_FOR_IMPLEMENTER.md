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
