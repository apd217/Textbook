# Chapter 16 — Continuous-by-Categorical Interactions (Chapter_Interaction_1.qmd)

**Snapshot:** ~6,500 words, and the book's pedagogical centerpiece for 343 (Weeks 11–12 and
the replication project both live here). The architecture is superb: sketch competing
hypotheses *before* data, two-regressions intuition, centering explained properly, additive
model shown failing via its residuals, coefficient-by-coefficient walkthrough keyed to the
plot, emtrends simple slopes, fully inline APA write-up, and the closing "don't diagnose an
interaction from two p-values" warning. One real conceptual bug runs through it, though: the
DV keeps switching identity between "friendship closeness (0–100 with one person)" and "a
count of friends."

---

### [CH16-P01] The DV is a 0–100 closeness thermometer, but the chapter keeps counting "friends"
- **Priority:** HIGH
- **Perspective:** Professor + Student
- **Effort:** M
- **Location:** Chapter_Interaction_1.qmd → throughout (search anchors: "they form about 15 friends on average", "more close friends than students who stay in", "about `r round(b_go, 0)` more close friends", "The \"Go out\" group has far more close friends")
- **Problem:** The study description is precise: "how close of a friendship they formed **with one particular person** (0–100 feelings thermometer)." But the variable is named `NewFriends`, axis labels say "Predicted New Friends," and the interpretations count people: "they form about 15 friends," "25 more friends," "every additional point of niceness is associated with about 5 more close friends." A student can't tell whether the outcome is closeness (points) or quantity (humans). Fifteen *friends* and fifteen *closeness points with one acquaintance* are wildly different claims, and the confusion sits exactly where the chapter teaches coefficient interpretation — the skill being graded.
- **Fix:** Pick one identity and enforce it everywhere. Recommended: keep the thermometer (it matches the cited Back et al. design and the 0–100 scale). Then: rename the variable `Closeness` (or keep `NewFriends` but fix all prose/labels), change axis labels to "Predicted Friendship Closeness (0–100)" (the APA figure already does this correctly — it's the only place that does), and rewrite every "N friends" interpretation as "N closeness points" ("going out is associated with about 25 points more closeness at average niceness"). Alternatively redefine the DV as a friend count — but then the 0–100 thermometer description, the APA figure labels, and the write-up's "friendship closeness" all need to change instead. Sweep the whole chapter; there are ~10 instances.
- **Approved:** [ x]

### [CH16-U01] The "How to Center in R" chunk contains only comments — nothing runs
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Interaction_1.qmd → "How to Center in R" (search anchor: "# data$BeingNice.C <- scale(data$BeingNice, center = TRUE, scale = FALSE)")
- **Problem:** The one code chunk in the centering section is entirely commented out — the reader sees gray pseudo-code and no output, in the section teaching the single most error-prone mechanical step of the week (`scale = FALSE` vs. the default). The real centering happens later inside a hidden simulation chunk, so students never see live centering code with a live check.
- **Fix:** The section precedes the data introduction, which is why the code was stubbed. Two options: (a) move the "How to Center in R" subsection to just after "The Data" and make it real: `Friend.Data$BeingNice.C <- scale(Friend.Data$BeingNice, center=TRUE, scale=FALSE)` followed by `mean(Friend.Data$BeingNice.C)` showing ~0 (and remove the centering line from the hidden simulate chunk); or (b) keep the placement and demo on a toy vector (`x <- c(2,4,9); x - mean(x)`). Option (a) is better — it also gives the anti-footgun sentence a home: "forget `scale = FALSE` and you've silently z-scored instead; your slopes will be in units nobody asked for."
- **Approved:** [ x]

### [CH16-U02] The homework requires sjPlot; the chapter only builds plots the artisanal way
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Interaction_1.qmd → after the interaction plot (search anchor: "## Simple Slopes: Testing Each Group's Slope Separately")
- **Problem:** Week 11's HW: "Plot the simple slopes for the interaction and write up the results in APA format (**visualize in sjPlot**)." The chapter builds its interaction plots via emmeans + ggplot from scratch — better plots, honestly, but a student needing the sjPlot one-liner for homework won't find it in the book (it appears in the Multiple Regression chapter for main effects only).
- **Fix:** Add a short subsection "The One-Line Version" after the main interaction plot: `sjPlot::plot_model(Model.2, type = "int")` (or `type = "pred", terms = c("BeingNice.C","GoingOut_")`), shown with output, plus two sentences: this is the quick-look/homework version; the hand-built emmeans version gives you control over raw data points, axis back-transformation, and APA polish — learn both, use the fast one until the figure matters.
- **Approved:** [ x]

### [CH16-U03] No Short Story on the biggest chapter in Part 2
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Interaction_1.qmd → end (search anchor: "The plot and simple slopes explain the interaction after it has been tested.")
- **Problem:** 6,500 words ending on a (great) warning callout, with no recap. Of all chapters, this is the one where a compressed retelling saves a drowning student: interaction = slopes differ; center X so zero is a person who exists; B1 = reference-group slope (simple effect), B2 = group gap at the mean, B3 = slope difference (the test); ΔR² F-test first, simple slopes to explain, plot always.
- **Fix:** Add `## The Short Story` with those ~6 bullets plus one on the reporting order (comparison test → interaction coefficient → simple slopes → figure). Also consider a one-line "you can stop here" marker before the APA-Style Figure section for undergrads who just need the concepts — the last quarter of the chapter is write-up craft.
- **Approved:** [x ]

### [CH16-P02] Intercept p-value interpretation is a stretch worth trimming
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Interaction_1.qmd → "The Intercept" (search anchor: "do average-niceness, stay-at-home students form *any* friendship at all?")
- **Problem:** Framing the intercept's p-value as testing "do they form any friendship at all?" invites students to start interpreting intercept significance tests generally — a habit that produces nonsense write-ups ("the intercept was significant, p < .001!"). The value interpretation (predicted closeness for average-nice stay-in student) is the teaching point; its p-value is almost never of scientific interest.
- **Fix:** Keep the value interpretation; replace the p-value sentence with: "The intercept comes with a p-value testing whether this predicted value differs from zero. It does — but 'average students have nonzero friendships' is not a finding anyone will publish. Intercept p-values are usually ignorable; the slope tests are where the questions live."
- **Approved:** [ x]

### [CH16-B01] YAML carries an extra html format block (only chapter that does)
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Interaction_1.qmd → YAML (search anchor: "df-print: paged")
- **Problem:** This chapter alone declares its own `html:` format options (`toc-depth: 1`, `df-print: paged`), which can override book-level HTML settings for this chapter only — one chapter of the web book could paginate data frames and truncate its sidebar differently from the rest. Same disease as the global YAML-residue item, slightly worse strain.
- **Fix:** Covered by the global YAML cleanup (strip to `title:`) — flagged so the implementer knows this file has the extra block.
- **Approved:** [ x]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Not flagged (deliberate):** The sketch-your-hypotheses-first section (this should be
requiredreading before the class project); the additive-model residual curvature as the
motivation for the interaction term (diagnostics doing narrative work); the coefficient
summary table with a "What it tests" column; the decision to show raw data under the
prediction lines in every plot. The Back et al. (2008) framing matches the curriculum's Week
11 example exactly — the book and lecture will reinforce each other.
