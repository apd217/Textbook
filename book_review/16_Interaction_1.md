# Chapter 16 — Continuous-by-Categorical Interactions (Ch_16_Continuous_Categorical_Interaction.qmd)

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
- **Location:** Ch_16_Continuous_Categorical_Interaction.qmd → throughout (search anchors: "they form about 15 friends on average", "more close friends than students who stay in", "about `r round(b_go, 0)` more close friends", "The \"Go out\" group has far more close friends")
- **Problem:** The study description is precise: "how close of a friendship they formed **with one particular person** (0–100 feelings thermometer)." But the variable is named `NewFriends`, axis labels say "Predicted New Friends," and the interpretations count people: "they form about 15 friends," "25 more friends," "every additional point of niceness is associated with about 5 more close friends." A student can't tell whether the outcome is closeness (points) or quantity (humans). Fifteen *friends* and fifteen *closeness points with one acquaintance* are wildly different claims, and the confusion sits exactly where the chapter teaches coefficient interpretation — the skill being graded.
- **Fix:** Pick one identity and enforce it everywhere. Recommended: keep the thermometer (it matches the cited Back et al. design and the 0–100 scale). Then: rename the variable `Closeness` (or keep `NewFriends` but fix all prose/labels), change axis labels to "Predicted Friendship Closeness (0–100)" (the APA figure already does this correctly — it's the only place that does), and rewrite every "N friends" interpretation as "N closeness points" ("going out is associated with about 25 points more closeness at average niceness"). Alternatively redefine the DV as a friend count — but then the 0–100 thermometer description, the APA figure labels, and the write-up's "friendship closeness" all need to change instead. Sweep the whole chapter; there are ~10 instances.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Kept the thermometer and took the stronger of the two options Alex was offered: renamed the variable `NewFriends` → `Closeness`, so the printed model output agrees with the prose instead of contradicting it. All axis labels now read "Predicted Closeness (0-100)"; every "N friends" interpretation is now "N points of closeness". Chapter 17 swept identically in the same session. Remaining uses of "friends" in the chapter are all legitimate (the Back et al. framing, the thermometer's 100 = "best friends" anchor, and the `Friend.Data` object name).

### [CH16-U01] The "How to Center in R" chunk contains only comments — nothing runs
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_16_Continuous_Categorical_Interaction.qmd → "How to Center in R" (search anchor: "# data$BeingNice.C <- scale(data$BeingNice, center = TRUE, scale = FALSE)")
- **Problem:** The one code chunk in the centering section is entirely commented out — the reader sees gray pseudo-code and no output, in the section teaching the single most error-prone mechanical step of the week (`scale = FALSE` vs. the default). The real centering happens later inside a hidden simulation chunk, so students never see live centering code with a live check.
- **Fix:** The section precedes the data introduction, which is why the code was stubbed. Two options: (a) move the "How to Center in R" subsection to just after "The Data" and make it real: `Friend.Data$BeingNice.C <- scale(Friend.Data$BeingNice, center=TRUE, scale=FALSE)` followed by `mean(Friend.Data$BeingNice.C)` showing ~0 (and remove the centering line from the hidden simulate chunk); or (b) keep the placement and demo on a toy vector (`x <- c(2,4,9); x - mean(x)`). Option (a) is better — it also gives the anti-footgun sentence a home: "forget `scale = FALSE` and you've silently z-scored instead; your slopes will be in units nobody asked for."
- **Approved:** [x] — IMPLEMENTED 2026-08-16 via option (a). The section now sits just after The Data, runs for real, and prints the `mean()` check (which comes out as `1.78e-16`, so the prose explains the scientific notation rather than pretending it says 0). The centering line is gone from the hidden simulate chunk. **Found a second footgun while doing this and documented both:** `scale()` returns a one-column *matrix*, not a vector, and `lm()` accepts it silently — which is what makes it dangerous, because `sjPlot::plot_model()` in CH16-U02 then fails with `variable 'BeingNice.C' was fitted with type "nmatrix.1"`. Centering now uses `as.numeric(scale(...))`; verified every coefficient is identical either way.

### [CH16-U02] The homework requires sjPlot; the chapter only builds plots the artisanal way
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_16_Continuous_Categorical_Interaction.qmd → after the interaction plot (search anchor: "## Simple Slopes: Testing Each Group's Slope Separately")
- **Problem:** Week 11's HW: "Plot the simple slopes for the interaction and write up the results in APA format (**visualize in sjPlot**)." The chapter builds its interaction plots via emmeans + ggplot from scratch — better plots, honestly, but a student needing the sjPlot one-liner for homework won't find it in the book (it appears in the Multiple Regression chapter for main effects only).
- **Fix:** Add a short subsection "The One-Line Version" after the main interaction plot: `sjPlot::plot_model(Model.2, type = "int")` (or `type = "pred", terms = c("BeingNice.C","GoingOut_")`), shown with output, plus two sentences: this is the quick-look/homework version; the hand-built emmeans version gives you control over raw data points, axis back-transformation, and APA polish — learn both, use the fast one until the figure matters.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Added "### The One-Line Version" after the interaction plot, framed with the exploratory-versus-reporting-code distinction from VOICE_GUIDE §16. Ran `plot_model()` and read its actual output rather than describing it from memory, which turned out to matter three ways: it plots against **centered** niceness (x axis runs −6.6 to +6.6, not 0 to 10), it labels the axis "Being Nice C" because it is just reading the column name, and it draws no raw data. Those three limitations are now the stated reason the hand-built version exists. Note this item is only implementable because of the `as.numeric()` fix recorded under CH16-U01.

### [CH16-U03] No Short Story on the biggest chapter in Part 2
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_16_Continuous_Categorical_Interaction.qmd → end (search anchor: "The plot and simple slopes explain the interaction after it has been tested.")
- **Problem:** 6,500 words ending on a (great) warning callout, with no recap. Of all chapters, this is the one where a compressed retelling saves a drowning student: interaction = slopes differ; center X so zero is a person who exists; B1 = reference-group slope (simple effect), B2 = group gap at the mean, B3 = slope difference (the test); ΔR² F-test first, simple slopes to explain, plot always.
- **Fix:** Add `## The Short Story` with those ~6 bullets plus one on the reporting order (comparison test → interaction coefficient → simple slopes → figure). Also consider a one-line "you can stop here" marker before the APA-Style Figure section for undergrads who just need the concepts — the last quarter of the chapter is write-up craft.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Added `## The Short Story` with the six bullets plus the reporting order as a closing line. **PARTIAL:** did not add the "you can stop here" marker before the APA-Style Figure section. It would land oddly given that the APA write-up is explicitly the Week 11 homework deliverable, so telling undergraduates they can stop before it seemed like the wrong signal. Easy to add if Alex disagrees.

### [CH16-P02] Intercept p-value interpretation is a stretch worth trimming
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Ch_16_Continuous_Categorical_Interaction.qmd → "The Intercept" (search anchor: "do average-niceness, stay-at-home students form *any* friendship at all?")
- **Problem:** Framing the intercept's p-value as testing "do they form any friendship at all?" invites students to start interpreting intercept significance tests generally — a habit that produces nonsense write-ups ("the intercept was significant, p < .001!"). The value interpretation (predicted closeness for average-nice stay-in student) is the teaching point; its p-value is almost never of scientific interest.
- **Fix:** Keep the value interpretation; replace the p-value sentence with: "The intercept comes with a p-value testing whether this predicted value differs from zero. It does — but 'average students have nonzero friendships' is not a finding anyone will publish. Intercept p-values are usually ignorable; the slope tests are where the questions live."
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Used the drafted replacement, refitted to the thermometer DV ("average students have a nonzero opinion of the person they sat next to" rather than "nonzero friendships"). The value interpretation above it was kept and also converted to thermometer units.

### [CH16-B01] YAML carries an extra html format block (only chapter that does)
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_16_Continuous_Categorical_Interaction.qmd → YAML (search anchor: "df-print: paged")
- **Problem:** This chapter alone declares its own `html:` format options (`toc-depth: 1`, `df-print: paged`), which can override book-level HTML settings for this chapter only — one chapter of the web book could paginate data frames and truncate its sidebar differently from the rest. Same disease as the global YAML-residue item, slightly worse strain.
- **Fix:** Covered by the global YAML cleanup (strip to `title:`) — flagged so the implementer knows this file has the extra block.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. YAML stripped to `title:` only, including the extra `html:` block (G01). Rendered before and after; no visual change.

---

### [CH16-VOICE] Cold open replacing the recap opening (added and implemented 2026-08-16)
- **Priority:** HIGH | **Effort:** M | **Perspective:** Student
- **Problem:** The chapter opened on "Where We Are and Where We Are Going", a recap, which is the §15 failure mode that Chapters 10 and 15 both had.
- **Fix as implemented:** Alex approved a cold open mid-session. Added `## Two Slopes, and Nothing That Compares Them` above the old recap, which is demoted rather than deleted (the same shape Ch15 ended up with). It splits the data by group, runs an ordinary regression in each half, prints both, and lands on the absence: two slopes, four *p*-values, and no test anywhere of the gap between them. Closes on the italic aphorism "*You cannot test a difference with two analyses that have never met.*"
- **Why this device:** per §17, plant once and pay off twice. The separate-regression slopes are `0.1998` and `4.9042`; the interaction model's $B_1$ and $B_1 + B_3$ are `0.1998` and `4.9042`, identical to four decimals, with $B_3 = 4.7044$ exactly the gap. **Verified by running it before writing the prose.** So the cold open pays off once at $B_3$ ("they are the same numbers") and again at `emtrends()` ("the third time"). The closing callout, which already warned against diagnosing an interaction from two *p*-values, now reads as the third callback without being rewritten.
- The old "The Two-Regressions Intuition" section described this same demonstration hypothetically ("Imagine, for a moment..."). It was rewritten as a short callback since the reader has now actually done it.
- **One correction worth recording:** a draft sentence claimed the pooled model gives "slightly sharper" standard errors. It does not. Pooled SEs are 0.2106 / 0.2526 against separate SEs of 0.2107 / 0.2524, so one is fractionally *wider*. The two groups happen to have nearly identical residual spread. The sentence now says what is actually true: the estimates never move, what you gain is one pooled error term instead of two and a standard error on the gap.

### [CH16-B02] Broken `$\neq$` in the coefficient summary table (found and fixed 2026-08-16)
- **Priority:** MED | **Effort:** S | **Perspective:** Publisher
- **Problem:** Not in the original review. The "What it tests" cell for `BeingNice.C` contained `$\neq$` in which the backslash-n had been expanded into a literal newline, splitting the table row across two lines. The table rendered broken.
- **Fix:** Restored `$\neq$`. Confirmed in the rendered HTML that it now emits `<span class="math inline">\(\neq\)</span>` inside the cell.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**G02 status:** DONE 2026-08-16. All 8 figures in this chapter now carry `fig-alt`, and the
two hypothesis/diagnostic figures that had no caption got one as well. Alt text was written
against actual plotted ranges (computed, not guessed) so the described endpoints match the
figure.

**Not flagged (deliberate):** The sketch-your-hypotheses-first section (this should be
requiredreading before the class project); the additive-model residual curvature as the
motivation for the interaction term (diagnostics doing narrative work); the coefficient
summary table with a "What it tests" column; the decision to show raw data under the
prediction lines in every plot. The Back et al. (2008) framing matches the curriculum's Week
11 example exactly — the book and lecture will reinforce each other.
