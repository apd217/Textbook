# Chapter 17 — Categorical-by-Categorical Interactions: The 2×2 (Chapter_CatXCat_Interaction.qmd)

**Snapshot:** ~5,300 words, deliberately parallel to Chapter 16 (same study, same structure,
same APA scaffolding) — that parallelism is the chapter's best feature, and the
"difference of differences" development with cell-mean reconstruction tables is textbook-
grade. Main issues: the extreme-groups split needs a "do not do this at home" label, the
friends-vs-closeness DV confusion carries over from Chapter 16, and the promised ANOVA
cameo (preface: "ANOVA gets a brief appearance") still never happens.

---

### [CH17-P01] The extreme-groups split is used without the "never do this to real data" warning
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → "The Data" (search anchor: "we focus on the **extremes of the niceness distribution**")
- **Problem:** The chapter dichotomizes a continuous predictor (keep <2 and >8, discard the middle 120 students) to manufacture a 2×2. As a *teaching device* this is defensible and even clever — but dichotomizing continuous variables is one of the most-cited methodological sins in psychology (MacCallum, Zhang, Preacher & Rucker, 2002), and students *will* imitate what the book does. The closing comparison table notes "less statistical power" but never says "this is a demonstration, not a recommendation."
- **Fix:** Add a callout at the point of the split: "**Why we're allowed to do this (and you're mostly not):** I am butchering a perfectly good continuous variable to teach you the 2×2 framework, because the 2×2 is how half of psychology structures its experiments. Doing this to *real* continuous data — median splits, extreme groups — throws away information, shrinks power, and can create phantom effects. If your variable is continuous, use the previous chapter's model. [cite MacCallum et al. 2002; add to references.bib]." The end-of-chapter comparison table then reinforces rather than introduces the point.
- **Approved:** [ ]

### [CH17-P02] DV identity confusion (friends vs. closeness) — same sweep as CH16-P01
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → throughout (search anchors: "Predicted New Friends", "more friends than their equally disagreeable counterparts", "M_Friends")
- **Problem:** Same bug as Chapter 16 (which shares the dataset): the DV is a 0–100 closeness thermometer, but axis labels say "Predicted New Friends" and interpretations count friends ("about 25 more friends"). Notably the first-look plot and APA figure here already use "Friendship Closeness (0–100)" — so the chapter disagrees with itself panel to panel.
- **Fix:** Apply the CH16-P01 sweep to this chapter in the same pass (they must be fixed together since the story is shared). ~8 instances here.
- **Approved:** [ ]

### [CH17-P03] "In regression (unlike ANOVA), unequal cell size is handled automatically" — slight strawman
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → "The Data" (search anchor: "this unequal cell size is handled automatically")
- **Problem:** ANOVA *is* regression under the hood; unequal n doesn't invalidate ANOVA — it makes the factors non-orthogonal, which is why the Type I/II/III sums-of-squares fight exists. As written, the sentence gives students a fuzzy "ANOVA can't do unequal n" meme they'll repeat to an ANOVA-loving professor and lose.
- **Fix:** Reword: "Unequal cells are no problem for the regression estimates. (Classic ANOVA arithmetic assumes balanced cells; with unequal n the ANOVA world descends into a fight about 'Types of sums of squares' that regression coefficients let you skip. If you ever meet Type III SS in the wild, that's what the fight was about.)" — which also quietly pays one installment of the preface's ANOVA promise.
- **Approved:** [ ]

### [CH17-U01] The factorial-ANOVA bridge is asserted, never shown — and the preface promised an ANOVA cameo
- **Priority:** MED
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_CatXCat_Interaction.qmd → "Comparison" section (search anchor: "maps directly onto the two-way factorial ANOVA framework")
- **Problem:** The preface promises "ANOVA gets a brief appearance so you know what it is when someone inflicts it on you." With Chapter_Advanced_Contrasts_ANOVA.qmd commented out of the book, that appearance currently never happens — and this 2×2 chapter is its natural home. Students leaving 343 will meet "2×2 ANOVA, F(1, 76) = …" in every article they read; the book should show them, once, that it's the same model.
- **Fix:** Add a short section or collapsible callout "The ANOVA Costume": run `anova(Model.2)` (or `car::Anova` if Alex prefers — note the unequal-n caveat from CH17-P03), show the two main-effect Fs and the interaction F, and point out the interaction F here equals the t² of B3 from the regression. Three sentences of prose: "When a paper reports a 2×2 ANOVA, this is the table they mean. Same model, same data, same interaction test — regression just hands you the cell means and comparisons with less ceremony. Now you know what it is when someone inflicts it on you." (Coordinate with whether Advanced_Contrasts_ANOVA eventually ships; if it does, cross-reference instead of duplicating.)
- **Approved:** [ ]

### [CH17-U02] No Short Story
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_CatXCat_Interaction.qmd → end (search anchor: "you have described two results but have not tested an interaction.")
- **Problem:** Covered by the cross-cutting recap item; raw material is the (excellent) closing callout plus the comparison table.
- **Fix:** Add `## The Short Story`: 2×2 = four cells, four coefficients; B0 = reference cell; B1/B2 = simple effects at the other variable's reference; B3 = difference of differences; follow up with `pairs()` within levels + Cohen's d; and the prior-chapter comparison table's punchline (continuous version uses all the data — prefer it when you can).
- **Approved:** [ ]

---

**Global items that also apply here:** chapter YAML residue (this file also has the extra
`html:` block like Ch16); missing `fig-alt`.

**Not flagged (deliberate):** The "What changes / what stays the same" opening (ideal
scaffolding for a book that promises to stop re-explaining); both algebraic framings of the
difference-of-differences with the "which story you want to tell" guidance; `eff_size()`
with model sigma (correct, modern emmeans practice most instructors don't know); the
closing callout. The deliberate structural parallelism with Chapter 16 should be preserved
by any future edit — these two chapters teach as a matched pair.
