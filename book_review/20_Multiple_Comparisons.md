# Chapter 20 — P-Values and Multiple Comparisons (Chapter_Multiple_Comparisons.qmd)

**Snapshot:** ~2,500 words. One of the best chapters in the book, period: dead-salmon opener
(properly cited), a correct p-value definition with the misconception list, Gelman & Stern's
significant-here-not-there trap, family definition as scientific judgment, FWER vs. FDR with
an honest power-tradeoff simulation, and a goal→method table. Findings are additions, not
corrections.

---

### [CH20-P01] The applied bridge is missing: emmeans `adjust=` and Tukey, which is what students actually touch
- **Priority:** MED
- **Perspective:** Professor (grad reader) + Student
- **Effort:** M
- **Location:** Chapter_Multiple_Comparisons.qmd → after "Multiple Comparisons in Regression" (search anchor: "use software that can adjust the contrast family explicitly")
- **Problem:** In this book's own pipeline, multiplicity shows up concretely in one place: `pairs(emmeans(...))` after a categorical model — where the Cat-Variables chapter used `adjust="none"` with protected-t reasoning (item CH12-P01), and where emmeans silently defaults to **Tukey** for all-pairwise comparisons. Tukey HSD — the correction psychologists meet most — is never named in this chapter, and the emmeans `adjust=` menu ("tukey", "holm", "none", "fdr") is never shown. The reader learns the theory here and the practice nowhere.
- **Fix:** Add a short section "Where You'll Actually Meet This: emmeans": refit a quick 3-group model (or reuse the distracted-driving data by cross-reference), show `pairs(emm)` with default Tukey vs. `adjust="holm"` vs. `adjust="none"`, and give the decision rule in book voice: all-pairwise after an omnibus → Tukey is built for exactly this; a few planned contrasts → Holm; exactly 3 groups with a significant omnibus F → "none" is the protected-t special case (link back to the categorical-predictors chapter so the two chapters tell one story). Verify by running.
- **Approved:** [ x] — IMPLEMENTED 2026-08-17 as `## Where You Will Actually Meet This: emmeans`.
  **Used FOUR groups, not three, and that is the point.** `Chapter_Regression with Cat
  Variables.qmd` already forward-links here, saying protected LSD "expires at three groups" and
  that four or more needs a real correction. Arriving with a three-group example would have
  restated what that chapter already did. So the section adds a fourth condition (Podcast) to
  the same distracted-driving design and lands exactly where the promise pointed. The reverse
  link is in, twice, and the spaced filename needs URL encoding:
  `](Chapter_Regression%20with%20Cat%20Variables.qmd)`. Verified that Quarto resolves it to
  `./Chapter_Regression with Cat Variables.html`, byte-identical to its own sidebar nav href.
  **Design note, because it took three passes and matters if anyone re-tunes this.** At n = 40
  per group every comparison was significant under all three methods, so the corrections
  demonstrated nothing. Dropped to **n = 20** with sd = 0.25, which is a realistic small psych
  study, and the flip appeared naturally. **The effect sizes were tuned; the seed was not**
  (§17: no seed hunting).
  **Verified result:** `Lecture - Texting` is $p = .0412$ unadjusted, $.170$ under Tukey, $.082$
  under Holm. Significant if you looked at that pair alone, dead if you looked at all six.
  Five of six comparisons agree across all three methods, which the text says plainly rather
  than pretending corrections usually overturn things.
  **The real reveal is the footnote.** `pairs()` with no arguments prints
  `P value adjustment: tukey method for comparing a family of 4 estimates`. The section makes
  reading that line the central instruction, since a reader who misses it reports Tukey-adjusted
  p-values while describing them as raw.
  Decision rule is a `callout-tip` with four cases. **One claim deliberately NOT made:** that
  Tukey beats Holm for pairwise families. Here Holm gives the smaller p for the borderline
  contrast, so the text says only that both control FWER and distribute power differently.

### [CH20-U01] The regression-family example is a commented-out stub
- **Priority:** LOW
- **Perspective:** Student (grad reader)
- **Effort:** S
- **Location:** Chapter_Multiple_Comparisons.qmd → "Multiple Comparisons in Regression" (search anchor: "# Example after fitting a model called model:")
- **Problem:** The only how-to code in the section is a chunk of comments referring to a model that doesn't exist ("a model called model"). Same disease as the centering stub in Chapter 16 — gray pseudo-code where live code would cost five lines.
- **Fix:** Make it real: simulate a quick 6-predictor model (or reuse an existing dataset), extract `coef(summary(model))[, "Pr(>|t|)"]`, show `p.adjust(..., "holm")` and `"BH"` side by side in a small table. If CH20-P01's section is added, this can fold into it.
- **Approved:** [ x] — IMPLEMENTED 2026-08-17. The commented stub is gone, replaced by a live
  model with the raw / holm / BH table the item asked for.
  **Used TWELVE predictors rather than six, and it paid off.** With six (two real, four null) no
  false positive appeared, so the table showed corrections politely agreeing with each other and
  taught nothing. Twelve predictors with **two real and ten null** matches the chapter's own
  kitchen-sink paragraph ("84 predictors, 31 interactions, and the participant's astrological
  sign") and puts P(at least one false positive) near 40%, so a false positive is the *expected*
  outcome rather than a rigged one.
  **Verified result at `set.seed(343)`:** raw p clears .05 for V1, V2 **and V11**. V1 and V2 are
  the real effects; V11 is pure `rnorm()` at $p = .041$. Holm ($.411$) and BH ($.164$) both kill
  it and both keep the two real effects. That is the cleanest possible demonstration and it was
  not arranged, which the text says out loud, along with the 40% figure and a note that other
  seeds give none or two.
  Not folded into CH20-P01's section: they teach different families (a set of coefficients vs.
  a set of pairwise contrasts) and sit in different places in the chapter.

### [CH20-U02] No Short Story
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Multiple_Comparisons.qmd → end (search anchor: "perform social cognition without preregistration.")
- **Problem:** The closing prose is excellent but unscannable; this chapter's checklist ("a defensible statistical argument uses…") is nearly a recap already. Covered by the cross-cutting item.
- **Fix:** Add `## The Short Story`: p = P(data this weird | H0 + model), never the reverse; significant-vs-not is not a comparison; a family is defined by the claim, before peeking; FWER (Holm ≥ Bonferroni) when any false claim is costly, BH-FDR for exploration; report the method and the family; the salmon was dead the whole time.
- **Approved:** [x ] — IMPLEMENTED 2026-08-17. Nine bullets, using the item's drafted content
  verbatim where it existed, plus two new ones earned by this session's work: the `emmeans`
  Tukey default, and the reminder that no correction repairs bad measurement or replaces
  replication. Closes on the salmon line as drafted.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**G01 DONE 2026-08-17:** YAML stripped from `title` + `fontsize` + `geometry` + a dead
`format: pdf:` block down to `title:` only, matching Ch19/21. **G02 DONE:** the chapter's one
figure (`fig-fwer-growth`) now has `fig-alt`, written against the rendered PNG.

**Opening checked against §15 and it passes, so nothing was touched.** "First, Let Us Put a
Dead Fish in an MRI" is the strongest cold open in the book: a real study, an absurd concrete
image, the statistical problem arriving only after the reader is already inside it. It is the
§15 target state, not a candidate for a pass.

**Noticed, not fixed, because it is cosmetic and not in any item:** in `fig-fwer-growth` the
`text(78, .075, "5% reference", ...)` label sits close enough to the dashed line at $y = .05$
that the line visually cuts through the bottom of the text. Legible, but slightly untidy.
One-line fix if Alex wants it: raise the y to about `.10`.

**Chapter length** grew from ~2,500 to 3,183 words, then to **4,881** after Alex's follow-up
(below); em-dash density fell 1.40 to **0.20**, with no dashes added. The two real ones left are
Alex's own, in the nil-hypothesis sentence, and were left alone per the standing rule.

---

## Alex's follow-up, 2026-08-17: explain Tukey properly, and give design-based guidance

His instruction: Tukey is very common and needs more explanation; it is best for **between-subjects**
designs when exploring. **Holm** tends to be better for **within** designs, because you probably
have the power to handle it, but in between designs it kills power like Bonferroni. **FDR** is
excellent for pure exploratory work, or for "is there any activity in my dead brain" — and if the
test works properly, it will not declare activity.

**Three new subsections, all verified before writing.**

**1. `### What Tukey Actually Is`.** The chapter used Tukey without ever saying what it is.
It now explains the studentized range: Tukey asks how far apart the largest and smallest of $k$
means would drift by chance, so protecting the biggest gap protects every smaller one, because
six comparisons among four means are six views of four numbers rather than six questions. Names
the payoff (exact FWER control under equal $n$ and equal variances, not merely conservative) and
the assumption that earns it (**independent groups with one common error variance**, i.e. a
between-subjects design). That is what makes Alex's between-subjects rule a statistical fact
rather than a preference.

**2. `### Where Holm Helps and Where It Does Not`.** This section exists because the chapter's own
comparison table would otherwise contradict the advice: **Holm gives the smaller p in five of the
six rows.** Ignoring that would have been indefensible, so the section explains it.
**Alex's "Holm kills power like Bonferroni" is exactly right, and sharper than it sounds.** Holm is
step-down, so its first step multiplies the smallest *p* by the full family size, which *is*
Bonferroni. Verified: raw $5.991865\times10^{-10}$, $6\times$ raw, Holm, and Bonferroni all return
$3.595119\times10^{-9}$, identical to every printed digit. New `holm-is-bonferroni` chunk shows all
four side by side. The improvement over Bonferroni is entirely in the *later* comparisons, which is
why Holm hurts most when your headline is the strongest contrast, which is the usual case.
**One claim was deliberately softened after checking.** "Tukey is more powerful for between-subjects
pairwise" is true only at the top of the sorted list, and by a modest margin here: Bonferroni/Tukey
is **1.03**, because four groups offer little dependence to exploit. The text says so, and notes
the advantage grows with more groups (8 groups gives 28 comparisons on 7 df). Below the top row,
Holm's step-down beats Tukey. Framing is therefore "which reference distribution matches your
design", not "which gives smaller numbers".
Within-subjects rationale is stated as Alex gave it plus the mechanism: Tukey's studentized range
assumes independence and repeated measures are not independent, so Holm's indifference to
dependence stops being a concession; and within designs remove between-person variance, so they
usually have the power to absorb the conservatism.

**3. `### What FDR Is Actually For`, with the dead-brain demo.** This is the one that pays off the
chapter's own opener. Three new chunks, all verified:
- **`dead-brain`:** 10,000 pure-null voxels. Uncorrected $p<.05$ finds **542** active voxels in a
  corpse; at the salmon paper's own $p<.001$ threshold it still finds **10**. **BH finds 0. Holm
  finds 0.**
- **`dead-brain-repeated`:** 2,000 dead brains, BH declares at least one discovery **4.45%** of the
  time. Under a global null, FDR control implies FWER control, so this is the guarantee working.
- **`live-brain`:** 10,000 voxels, 200 real. Uncorrected finds 690 (492 false). Holm finds 58 with
  **0** false but misses 142 real effects. BH finds 166, recovering **154 of 200** for **12** false.
  Observed FDP is 0.072, slightly above .05, which incidentally demonstrates the "expectation over
  repeated uses" point the section already made.
- Closing `callout-note` reframes the salmon as a **calibration check** rather than an fMRI joke:
  hand a procedure data with nothing in it and confirm it says nothing. Lands on Alex's line, that
  FDR is permissive about *which* discoveries pass, not about *whether* anything is there.

**The `adjust=` callout was rebuilt around design instead of test count**, and now carries the trap
explicitly: reaching for Holm in a between-subjects pairwise design because it sounds more rigorous
costs power exactly where the paper needs it. Four Short Story bullets added to match.

**Read-through of Alex's edit pass, 2026-08-17.** His changes (italic *p* throughout, goat for
goose, foam-bat for foam-chainsaw, "demand cookies", "a newer computer that can do a more powerful
fancy test") were all kept. Two defects found and fixed:

1. **`–––` rendered as literal triple en-dashes** in the nil-hypothesis sentence, line 80. His
   em-dash cleanup had replaced `---` with three U+2013 characters, which is not a punctuation
   mark and rendered visibly as "nil hypothesis–––a population difference". Converted to commas
   per §14's "cut it to the right thing" (simple appositive aside). **Flagged rather than assumed:
   revert to em-dashes if that was deliberate.** En dash itself is PDF-safe, so this was cosmetic
   rather than a build risk.
2. **A forward reference of mine pointed backwards.** The `adjust=` callout said "See the next
   section for what FDR is actually good at", but the FDR section is *earlier* in the chapter.
   Rewritten to point back at the dead-brain demonstration. My error, not his.

**Bug found and fixed while verifying, worth knowing about.** Two inline `` `r signif(...)` ``
expressions returning scientific notation rendered as literal **`5.99^{-10}`** in the HTML, not as
math. Same family as the `R^2`-outside-math caret bug already logged in the README, but a different
trigger: knitr formats small numbers for math context, and inline R output is not in math context.
Fixed by moving the values into a chunk, where verbatim output is safe. A scan of the rendered
chapters found no other instances. **Do not put `signif()`/`format(scientific=)` results in inline
R;** print them in a chunk or round them into ordinary decimals.

**Cross-references to coordinate:** CH03-P01 (Probability chapter's salmon aside should cite
@bennett2010 and point here — the citation already exists in references.bib per this chapter);
CH12-P01 (protected-t discussion should point here); CH18-P02 (mixed chapter's salmon
line). This chapter is the hub — make the spokes link to it.

**Not flagged (deliberate):** The FWER growth simulation overlaying theory (quiet
methodological modeling); the "families of one… p-hacking with office supplies" line; the
honest statement that FDR .05 is an expectation over uses, not a per-study guarantee; the
final table mapping goals to defaults. The chapter correctly resists ranking corrections and
instead matches error promises to goals — that framing is worth protecting from any editor
who wants a flowchart.
