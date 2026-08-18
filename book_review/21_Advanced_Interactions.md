# Chapter 21 — Advanced: Continuous and Higher-Order Interactions (Ch_21_Advanced_Interactions.qmd)

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
- **Location:** Ch_21_Advanced_Interactions.qmd → "The Johnson-Neyman Question" (search anchor: "solves for the values of moderator $Z$")
- **Problem:** The section derives the conditional-slope SE and warns against extrapolation, but the reader never sees a J–N region computed or plotted — for the one technique in the chapter where the *picture* is the product. Grad students will need this for actual papers (editors increasingly ask for it over ±1SD).
- **Fix:** Add a demo on the existing caffeine×sleep model. Two options: `interactions::johnson_neyman(InteractionModel, pred = Caffeine.C, modx = Sleep.C)` (one line, standard tool) or a ~10-line manual version solving the quadratic from the SE formula already displayed, then shading the significance region on a slope-vs-moderator plot — the manual route matches the chapter's show-the-machinery ethic and avoids a new dependency. Either way, mark the observed range of Sleep.C on the plot and repeat the extrapolation warning with the picture present. Verify by running.
- **Approved:** [x ] — IMPLEMENTED 2026-08-17, **manual route**. `interactions` is not installed
  on this machine, which settled the choice the item left open, and the manual version was the
  item's own preference anyway. Added: the quadratic derivation ($A$, $B$, $C$ from the SE
  formula already on the page), a computation chunk, and a slope-vs-moderator plot with a 95%
  band, the two boundaries, and the null region shaded.
  **Verified boundaries: 3.35 and 5.77 hours of sleep**, on an observed range of 2.54 to 9.64.
  The plot confirms the algebra visually: the confidence band touches zero exactly at the two
  orange lines.
  **The interesting finding is one the item did not anticipate, and it changed the prose.** Both
  boundaries are nominally "inside the observed range," so the first draft said so and moved on.
  Counting the data killed that sentence: only **1 participant of 240** falls in the
  significantly-positive region (53 in the null region, 186 above the upper boundary). So the
  section now reports a `table(cut(...))` of the counts and says plainly that the upper boundary
  is the finding and the lower one is where the data ran out. **"Inside the observed range" is a
  weaker guarantee than it sounds** is worth carrying into any other J-N material.
  Bonus, also verified: $-1SD$ of sleep is 5.39 hours, which lands *inside* the null region, so
  the $\pm1SD$ convention would label 5.39 hours "low sleep" and report nothing there, in a
  sample running down to 2.5. That is a much sharper indictment of $\pm1SD$ than "it is arbitrary."
  **Trap worth recording:** `vcov()` rows are in model order, so in `Y ~ Sleep.C * Caffeine.C`
  the `Caffeine.C` variance is row **3**, not row 2. A scratch script indexed positionally and
  produced roots of $-47.7$ and $56.7$ with nothing erroring. The chapter code indexes by name
  and carries a comment saying why. Same family as the Type III `(Intercept)` trap in Ch17.

### [CH21-P02] Missing the classic trap: standardized coefficients for product terms
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Ch_21_Advanced_Interactions.qmd → after the centering discussion (search anchor: "You would be fitting a mathematical casserole")
- **Problem:** The chapter covers centered-vs-uncentered carefully but never warns about *standardizing* interaction models — where software-reported "betas" are wrong for product terms because z-scoring the product ≠ the product of z-scores (Friedrich, 1982; CCAW covers this at length). Every psych grad student meets a reviewer asking for standardized coefficients on a moderation model; this book is positioned to inoculate them in one callout.
- **Fix:** Add a callout "The Standardized-Beta Trap": if you want standardized interaction coefficients, z-score X and Z *first*, then form the product and refit — do not trust a post-hoc 'standardized' column that z-scored the XZ product itself; the two differ and only the first is interpretable. One sentence pointing to CCAW ch. 7 / Friedrich (1982), added to references.bib.
- **Approved:** [x ] — IMPLEMENTED 2026-08-17 as `### The Standardized-Beta Trap`, with a live
  demo rather than only a callout, since the numbers make the case better than the warning does.
  `friedrich1982` added to `references.bib` (Am J Pol Sci, 26(4), 797–833, doi 10.2307/2110973);
  `cohen2003` already existed and is cited alongside it.
  **Verified numbers.** Proper (z-score components, then multiply): $\beta_{XZ} = -0.238$.
  Wrong (z-score the product itself): $-1.485$. A factor of 6.2. The lower-order betas are also
  wrong, and one of them is $1.02$, which the text uses as the tell.
  **The genuinely dangerous part, which I ran to confirm and then built the section around:**
  the two models fit **identically**. $R^2 = 0.2071$ in both and the interaction's *t* is $-4.19$
  in both, because the two sets of predictors span the same column space. So the significance
  test is untouched and nothing looks broken; only the reported magnitude is nonsense. That is
  why this error survives peer review.
  Used `as.numeric(scale(...))` throughout, per the Ch16 lesson about `scale()` returning a
  one-column matrix. Row names on the comparison table are relabelled by hand, because `cbind`
  takes them from the first argument and would have labelled the Wrong column's `Product.Z`
  row as `Sleep.Z:Caffeine.Z`.

### [CH21-B01] Small polish: scatterplot y-label, prose Short Story
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_21_Advanced_Interactions.qmd → interaction plot (search anchor: "ylab = \"Predicted concentration\"") and end (search anchor: "## The Short Story")
- **Problem:** (1) The plot draws *raw* concentration points with predicted lines overlaid, but the y-label says "Predicted concentration" — mislabels the dots. (2) Short Story is a single prose paragraph while most chapters use scannable bullets (same as CH19-B01).
- **Fix:** (1) y-label → "Concentration"; caption can note lines are model predictions at three sleep values. (2) Bullet the Short Story: slope of X = b1 + b3Z (the derivative *is* the interaction); b1 is the slope at Z=0, so make zero mean something; center for interpretation, not exorcism; probe theory-chosen values (or J–N), inside the data; labels like synergistic/buffering are stories about coding, check before naming; three-way = a two-way that changes.
- **Approved:** [ x] — IMPLEMENTED 2026-08-17, both parts. (1) y-label is now "Concentration",
  with a `fig-cap` saying the dots are observed scores and only the three lines are predictions,
  plus an inline code comment so the next editor does not "fix" it back. (2) Short Story is now
  7 bullets, using the item's drafted content and adding the standardized-beta bullet from
  CH21-P02 and the "an effect at a place" line from the cold open.

---

**Global items that also apply here:** missing `fig-alt` (YAML already clean here, like Ch19).

**G02 DONE 2026-08-17:** all three figures carry `fig-alt`, written against the rendered PNGs.
The J-N plot's alt text was corrected after looking at the image: the blue slope line crosses
zero near 5 hours, in the *middle* of the shaded region rather than at either boundary, because
the boundaries are where the confidence *band* touches zero. That distinction is the whole
method and the first draft of the alt text had it wrong.

**CH21-VOICE (cold open), added 2026-08-17 and approved by Alex before implementation.** The
chapter opened on "Advanced Topic: It Depends, Again" plus a Fast Review recap, which is the
first-position-recap failure from §15 that Ch10, Ch15 and Ch16 all had. It now opens on the
same model fit twice, uncentered and centered: the caffeine coefficient goes $+0.0618$
($p = .002$) to $-0.0188$ ($p < .001$), a sign flip where both versions are significant, while
the interaction coefficient, $R^2$, and all 240 fitted values are identical (they disagree in
the 12th decimal place). Closes on "*A coefficient in an interaction model is not an effect. It
is an effect at a place*", which the Short Story reuses.
Structural consequence: the simulation chunk moved to the top, so
`## Simulating Sleep, Caffeine, and Questionable Judgment` is now
`## Does the Interaction Earn Its Place?` and holds the additive-vs-interaction `anova()`
comparison, which the chapter previously ran without commenting on.

**Chapter length grew** from ~2,200 words to 3,124, then to 3,441 after Alex's edit pass below;
em-dash density 0.29.

---

## Alex's edit pass, 2026-08-17: he installed `interactions` and added the package call

**`interactions` is now installed** (it was not when CH21-P01 was implemented, which is why the
manual route was chosen). Alex added a `johnson_neyman()` block at the end of the J-N section and
made three other edits.

**His edits, all kept:** deleted the `---Alex---` cold-open note (his standard signal that the
prose is accepted); `## Advanced Topic: It Depends, Again` → `## It Depends, Again`;
`$p <$ .001` → `$p < .001$`, which is better math markup.

**The package call was verified rather than trusted, and it is correct.** All argument names he
used are real (`model`, `pred`, `modx`, `alpha`, `control.fdr` are all in `formals()`), and
**the package reproduces the hand-solved boundaries exactly**: manual $-3.2158656$ / $-0.8036323$
against package $-3.2158656$ / $-0.8036323$. Added a chunk printing all four side by side, because
that agreement is the payoff for having built the quadratic by hand two sections earlier, and it
is the §17 identity move for free.
Also confirmed `control.fdr = TRUE` genuinely changes the answer (bounds move outward to
$-3.57$ / $-0.74$), so his comment about it is accurate. Added a sentence explaining *why*: a J-N
region is an enormous implicit family of simple-slope tests, which links back to the multiple
comparisons chapter.

**Fixes applied to his block:**
- "will also this with less code" → "will also **do** this with less code" (dropped verb).
- **The chunk was unnamed and produces a figure.** Named it `johnson-neyman-package` and gave it
  `fig-alt`, written against the rendered PNG (G02, plus the standing rule about anonymous chunks
  shifting figure filenames and silently invalidating the freeze cache).
- Added a `###` heading so it is not an orphan block hanging off the previous section.
- Added a note that the package reports on the **centered** scale ($-3.22$, $-0.80$) while the
  manual section reports **hours** ($3.35$, $5.77$), since a reader comparing the two numbers
  would otherwise think they disagree.
- Added a paragraph reading the plot: pink is n.s., blue-green is $p < .05$, and the thick black
  bar along zero marks the **observed** range while the line and band are deliberately drawn past
  both ends of it. That is the extrapolation the section warns about, drawn by the package itself.

**Flagged, not changed:** Ch21 no longer says "Advanced Topic" in that heading, but
`Ch_19_Regression_Diagnostics.qmd:70` still has `## Advanced Topic: Who Is This For?`
and `Ch_20_Multiple_Comparisons.qmd:19` still has a `## Advanced topic` callout. Either the
label is being retired book-wide or Ch21 is now the odd one out. Alex's call.

**Not flagged (deliberate):** The derivative-as-the-whole-interaction framing; "hear colors
at a higher frame rate"; the essential-vs-nonessential multicollinearity distinction
(straight out of CCAW and stated more clearly); the keep-lower-order-terms rule with
"interpretive debris"; the fourth panel of the patterns figure being a text panel
("Same product-term machinery / Different theoretical stories") — that's information design,
keep it. This chapter and Ch14 (Control) are the strongest pure-grad chapters; they need the
least work of anything in the book.
