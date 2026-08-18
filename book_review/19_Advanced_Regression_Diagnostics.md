# Chapter 19 — Advanced: Regression Diagnostics (Ch_19_Regression_Diagnostics.qmd)

**Snapshot:** ~1,350 words, grad/advanced audience (correctly labeled). Conceptually careful
(leverage ≠ influence, screening thresholds ≠ deletion warrants, hat matrix for the brave)
and admirably free of ritualism ("do not test normality and surrender"). Notably, this
chapter's YAML is already clean (title only) — it's the template for the global YAML fix.
Main gaps: the chapter *tells* more than it *shows* in the second half — no `vif()` call, no
HC-standard-error one-liner, and the refit-without-the-outlier comparison it preaches is
never demonstrated.

---

### [CH19-P01] The chapter's own sermon — "compare conclusions with and without" — is never demonstrated
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Ch_19_Regression_Diagnostics.qmd → after the Cook's distance plot (search anchor: "not whom to throw into the statistical volcano.")
- **Problem:** Participant 60 is built, flagged in two plots, and moralized about ("If one person reverses the entire result, that instability is part of the result") — but the payoff never happens: the model is never refit without them, so the reader never sees how much the coefficients actually move. The one thing a grad student will do in practice (sensitivity refit) is the one thing not modeled.
- **Fix:** Add a short chunk: `TherapyModel.60 <- update(TherapyModel, data = TherapyData[-60, ])` and a two-row coefficient comparison (kable or `rbind(coef(...))`), with 2–3 sentences interpreting the shift and repeating the rule: report both, don't silently pick the flattering one. Verify by running.
- **Approved:** [ x] — IMPLEMENTED 2026-08-17, and **expanded**: the refit now happens twice.
  Alex approved a §15/§17 cold open on 2026-08-17, so the chapter now *opens* on the refit
  (the hook), and the disciplined version with SEs and p-values sits under Cook's distance
  as `### The Sensitivity Refit, Done Properly` (the payoff), plus a callout drafting the
  one sentence you would actually write in a paper.
  **The numbers are better than the item assumed and were all run first.** Dropping
  participant 60 does not merely "move" the coefficients: Baseline **reverses sign**
  ($-0.0233 \to +0.0631$), the intercept stops being significant ($p = .043 \to .106$),
  and $R^2$ goes **up** ($.583 \to .625$) because the deletion took proportionally more out
  of SSE than out of SST. Sessions, the actual conclusion, survives at a 12% smaller slope.
  Also added, because the plot invites it: the $4/N$ rule flags **three** people here
  (26, 40, 60), and only one of them changed anything.

### [CH19-P02] VIF gets a formula but no R — add the one-liner
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Ch_19_Regression_Diagnostics.qmd → "Multicollinearity" (search anchor: "VIF_j=\\frac{1}{1-R_j^2}")
- **Problem:** Every other diagnostic in the chapter has a plot or computation; multicollinearity gets only algebra. The reader leaves without knowing `car::vif(TherapyModel)` exists — the single command they'll actually use — or what magnitude should worry them.
- **Fix:** Add `car::vif(TherapyModel)` with output and two sentences: conventional worry thresholds (5–10) are folklore, not law; what matters is whether the inflated SEs damage the question being asked. Optional: one line simulating two r = .9 predictors to show a VIF ≈ 5 in action. (Also connects back to CH13-P01's "controlled slopes cost precision" point — cross-reference it.)
- **Approved:** [ x] — IMPLEMENTED 2026-08-17. `library(car)` + `vif(TherapyModel)` added
  (§14b: named at first visible use).
  **The item's "optional" simulation turned out to be mandatory.** `vif(TherapyModel)` returns
  **1.01** on this data, because Sessions and Baseline correlate at only $-.12$. Printing that
  alone teaches nothing, so the section now shows it as "this is what fine looks like" and then
  runs a four-row demo at $r = 0, .5, .9, .99$. The demo holds `X1` and `Y` *identical* across
  rows (the seed is reset inside the function, so only `X2` changes), which makes the point
  unarguable: same true effect, and $p$ goes $< .0001 \to .039 \to .43$.
  **A verified identity worth keeping:** $\sqrt{VIF}$ *is* the SE inflation factor. VIF 5.13
  gives $\sqrt{}=2.27$, and the SE ratio in the table is 2.26. Built prose on it.
  Cross-reference done, and it pays a debt: `Ch_13_Multiple_Regression.qmd:466`
  already says "A later chapter measures exactly this with something called *variance
  inflation*." This is that chapter, so the link closes a promise rather than just pointing.
  Added a `callout-warning` making the 5-and-10 rule folklore explicitly, plus a paragraph on
  why dropping a correlated predictor is not a fix (it answers a different question).

### [CH19-P03] Heteroscedasticity fixes are named but not shown — give grads the sandwich
- **Priority:** LOW
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Ch_19_Regression_Diagnostics.qmd → "When the Variance Changes" (search anchor: "reporting heteroscedasticity-consistent standard errors")
- **Problem:** HC standard errors are recommended twice, but the reader is never shown how — and this is the fix they'll need most often (it's also CCAW-adjacent material). One chunk closes the loop.
- **Fix:** Add: `lmtest::coeftest(TherapyModel, vcov = sandwich::vcovHC(TherapyModel, type = "HC3"))` with one sentence ("same slopes, more honest SEs when the spread misbehaves") and a pointer that `performance::check_model()` bundles most of this chapter's plots into one call — worth knowing even if the hand-built versions teach better.
- **Approved:** [ x] — IMPLEMENTED 2026-08-17 with **one deviation, flagged in the file as an
  `---Alex---` comment.** The `coeftest` one-liner and the `check_model()` pointer are both in.
  **The item's drafted sentence would have been false, so it was not used.** "More honest SEs
  when the spread misbehaves" implies this data is heteroscedastic. It is not: Breusch-Pagan
  returns $p = .19$, and the chapter *builds* the variance constant on purpose. The SEs grow
  anyway (Sessions $0.22 \to 0.29$), and the cause is participant 60. Verified by refitting
  without them, where HC3 and OLS land within 1% of each other.
  So the section keeps the code and tells the truth about it, in a callout: robust SEs are also
  *responsive to a single high-leverage case*, which makes "my robust SEs are much bigger than
  my ordinary ones" a diagnostic finding about influence rather than spread. This turns an
  awkward demo into the chapter's third participant-60 callback.
  `check_model()` is mentioned but **not run** — `qqplotr` is not installed on this machine and
  the call would need it. Mentioning it costs nothing and adds no dependency.

### [CH19-B01] Cross-link the intro chapter's "five questions," fix the vague mixed-models pointer, bullet the Short Story
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Ch_19_Regression_Diagnostics.qmd → three spots (search anchors: "## Advanced Topic: Who Is This For?", "in the graduate mixed-model section", "## The Short Story")
- **Problem:** (1) The Intro-to-Regression chapter frames assumptions as five questions; this chapter re-derives the same list without referencing it — a free continuity win missed. (2) "We will do that in the graduate mixed-model section" — vague; Ch_18_Mixed_Regression.qmd is active and linkable. (3) The Short Story here is a paragraph while every other chapter uses bullets — trivial inconsistency, but this is the recap format students learn to scan. (4) Typo: workflow step 4 "inspect" is lowercase (search: "4. inspect Q–Q behavior").
- **Fix:** (1) Open with "In the Intro to Regression chapter we asked five questions about the line; this chapter is those questions with a magnifying glass" + link. (2) Link the mixed chapter. (3) Convert Short Story to 4–5 bullets. (4) Capitalize.
- **Approved:** [x ] — IMPLEMENTED 2026-08-17, all four parts.
  (1) The five-questions bridge is in, and it landed better than planned: the cold open now
  sits above it, and question 5 in `Ch_11_Intro_Regression.qmd:271` is literally "Is one
  strange person steering the entire line while everyone else watches?" So the bridge reads
  "You have just seen question five win." (2) Linked to `Ch_18_Mixed_Regression.qmd`, plus
  two sentences on why independence is the one assumption a diagnostic plot cannot rescue you
  from. (3) Short Story is now 7 bullets. (4) Capitalized.
  **Also fixed, not in any item (two of Alex's slips, both invisible in code and only findable
  by looking at the rendered PNGs):** the `"60"` text label was clipped off the plot in *both*
  figures that use it. In `residual-fitted` the point sits against the right edge and `pos = 4`
  ran the text off the panel, so only "6" showed; changed to `pos = 2`. In `influence-plot` the
  label sat above the tallest spike at the very top of the default y range and was cut off
  entirely; added `ylim` headroom. Both re-rendered and re-checked visually.

---

**Global items that also apply here:** missing `fig-alt`. (YAML already clean — use this
file as the target state for the global YAML item.)

**G02 DONE 2026-08-17:** all three figures now carry `fig-alt`, written against the rendered
PNGs rather than the plotting code, per the standing rule. The three chunks were converted from
`{r label, fig.width=...}` headers to `#|` option style to carry it, matching the convention in
`Ch_17_Categorical_Interaction` and `Ch_15_Statistical_Control`. Chunk labels are unchanged, so figure
filenames and the freeze cache are unaffected.

**Chapter length**, ~1,350 words to 3,078 after the first pass, then to **4,516** after Alex's
2026-08-17 follow-up (below). Em-dash density 0.22, at the floor.

---

## Alex's follow-up, 2026-08-17: "add the formula for VIF", "sandwich and HC3 need a lot more explanation", "explain the packages and tell them each contains the references"

All three done in one pass. Every formula was verified numerically against R before prose was
written about it.

**1. VIF now has the formula that makes it matter.** The chapter already had
$VIF_j = 1/(1-R_j^2)$, which says how it is computed and not why anyone cares. Added the
standard-error decomposition that shows where VIF actually lives:

$$SE(b_j)=\frac{\widehat\sigma}{\sqrt{\sum_i (X_{ij}-\overline X_j)^2}}\times\sqrt{\frac{1}{1-R_j^2}}$$

with the two factors read separately: the left one is the SE you would earn if $X_j$ stood alone
(and is the algebraic reason restricted range hurts), the right one is $\sqrt{VIF_j}$, never less
than 1. **Verified exactly on two models:** $0.2178867 \times \sqrt{1.013679} = 0.2193719$, which
is `lm()`'s printed SE to the last digit; and on the $r = .9$ demo
$0.333999 \times \sqrt{5.132198} = 0.7566531$, also exact.
Added two chunks: `vif-by-hand` (auxiliary regression, $R^2_j$, divide, matched against
`car::vif()`) and `vif-se-decomposition` (the identity above, printed three ways).
**Consequence: the later $\sqrt{VIF}$ paragraph was rewritten.** It used to announce "a tidy
identity hiding in that table," which is now backwards, since the formula arrives first. It now
reads as prediction-then-check, and picks up the $r = .99$ row as the warning ($VIF = 50$, a
$\sqrt{}$ tax of 7.1, same true effect of exactly 2).

**2. The sandwich is now derived rather than named.** New subsections: *Where the Ordinary
Standard Errors Come From*, *Estimating the Filling*, *Building It Yourself*. The spine is that
$\widehat\sigma^2(\mathbf X'\mathbf X)^{-1}$ **is** the sandwich with the homoscedasticity
assumption still in it, so the classical and robust SEs are one formula, not two theories. The
bread/filling/bread labels are on the general form, so the name is explained. The `HC0`–`HC3`
table gives each diagonal entry, and **the $h_{ii}$ in HC2/HC3 is explicitly named as the same
leverage from the hat-matrix section**, which is where the two halves of the chapter meet.
`sandwich-by-hand` builds `Bread %*% Filling %*% Bread` from `model.matrix()` and matches
`vcovHC()` exactly (7.5973832, 0.2895539, 0.1306439). `hc-ladder` prints const/HC0/HC1/HC2/HC3
and they increase monotonically as the table predicts. HC3-by-default is now attributed to
Long & Ervin's simulations rather than asserted.
**The participant-60 callout is now mechanical instead of hand-wavy.** New `hc3-weights` chunk:
participant 60 supplies **37%** of the total HC3 filling, against 8.5% for the next largest and
1.7% if everyone contributed equally. That is *why* the robust SEs grew on data that is not
heteroscedastic, and it makes the callout's claim checkable.

**3. Packages explained, with their bibliographies.** New section *The Four Packages, and Where
the Real Derivations Live*: a table of `car` / `sandwich` / `lmtest` / `performance` saying what
each does here and where it came from, plus a paragraph on the `sandwich`-versus-`lmtest`
division of labor, which is what makes the two-function `coeftest(m, vcov = vcovHC(m))` call
stop looking fussy. A `callout-tip` teaches `citation("sandwich")` and
`vignette(package = "sandwich")` as the general move, with the point that the Zeileis (2004)
paper deriving every `HC` type ships *inside the installed package*. Ends on citing the packages
you analyze with.

---

## Alex's edit pass + follow-up, 2026-08-17 (second round)

**His request:** "for VIF, I like show side by side, an example that is perfectly collinear in the
regression, then them one at a time and show what happens in estimates. I thought I had that in
one of my lectures before you adapted it."

**Answer on provenance: it was never in this repo.** Searched every `.qmd` (including the
commented-out drafts) and `git log --all -S` for "perfectly collinear", "aliased", "singular",
"rank deficient", "not defined because". Nothing. So it was not adapted away by any session; it
lives in a lecture file outside the project.

**Built it as three new subsections**, all verified before writing:
- `### The Extreme Case: Two Predictors That Are Secretly One`. `FreeLunch` and
  `PaidLunch = 1 - FreeLunch`, correlation exactly $-1$, chosen to match Alex's own free-lunch /
  voucher paragraph further down so the demo and his theory point are the same example. `lm()`
  prints **`Coefficients: (1 not defined because of singularities)`** and returns `NA`.
  `alias(BothModel)` prints the dependency (`PaidLunch = 1 - FreeLunch`), which is a nice touch
  most people have never seen. `vif()` **errors** with "there are aliased coefficients in the
  model"; shown live using `#| error: true` so the reader sees the real message.
- `### Now Enter Them One at a Time` — the side-by-side Alex asked for. Verified identities:
  the two single-predictor models have **identical SE (2.0078), identical $|t|$ (12.1449), and
  identical $R^2$ (0.5556)**, with slopes equal and opposite ($-24.38$ vs $+24.38$), and the
  both-in model's $R^2$ is the same again. Fitted values agree to 1.4e-14. "They are not two
  findings. They are one finding, and the direction is a decision you made."
- `### The Version That Does Not Warn You` — the same pair with measurement error of sd $= 0.01$
  added, so $r = -0.9993$. **Nothing errors.** Verified: free-lunch slope goes $-24.4 \to -95.2$,
  **both predictors become nonsignificant** ($p = .088$ and $p = .202$) in data where the effect
  is real and was overwhelming, VIF $= 762$, and $R^2$ barely moves ($.5556 \to .5617$). This is
  the concrete version of Alex's "they will eat each other" and the text says so by name.
- The existing $r = 0/.5/.9/.99$ table now follows as "the middle of the continuum" and its
  heading changed to `What Trouble Actually Looks Like Across the Range`.

**Alex's four edits to this chapter were read and kept.** The callout retitle ("Not Divine Law"),
his new multicollinearity-as-theory-problem paragraph, his rewrite of the sandwich lead-in, and
his deletion of the Breusch-Pagan sentence. **Genuine slips fixed in his new prose** (per §13,
these were errors that were not *doing* anything): "be theory problem" → "be a theory problem";
"Firs," → "First,"; "if you have to predictors" → "two predictors"; "the second is is the student
part of" → "whether the student is part of"; "said they independent" → "said they are
independent"; "who this sample" → "who the sample"; and the fragment "However, most people who
could not say what is being made robust to what" → "most people using them could not say". Split
his one long paragraph into three and linked it forward to the free-lunch demo. **The jokes and
the casual register were left alone**, including "they will eat each other" and "cause".

**Knock-on from his Breusch-Pagan deletion:** the packages table still advertised `bptest()`,
which the chapter no longer calls. Cell rewritten to `coeftest()` only.

**Bug found while verifying:** `` `PaidLunch` $= 1 - $ `FreeLunch` `` rendered as literal dollar
signs, because pandoc will not parse inline math with a space immediately before the closing `$`.
Rewrote in words. Swept both chapters for stray `$` in rendered prose afterwards: zero.

Chapter is now **5,296 words**, em-dash density **0.19**.

---

**Five references added to `references.bib`**, all taken from each package's own `citation()`
output rather than from memory: `white1980`, `longervin2000`, `fox2019`, `zeileis2004`,
`zeileis2002`, `ludecke2021`. All verified to resolve in the rendered chapter.
Note `ludecke2021` carries `ü`; that is safe, because `references.bib` already contains `ä`
(Mächler, in the glmmTMB entry) which ships in the Mixed Regression chapter today.

**Not flagged (deliberate):** "Residuals should not organize a protest" and "driving the
statistical bus" as plot titles; the hat-matrix section placed at the end where only the
willing will find it; the refusal to hand out hard VIF/Cook cutoffs as laws. The
"Deleting the Problem Is Not Diagnosing the Problem" callout is the ethical core of the
chapter — protect it.
