# Chapter 24 — Advanced: Bootstrapping, the Jackknife, and Resampling (Chapter_Bootstrapping.qmd)

**Snapshot:** ~2,900 words of genuinely graduate-level material handled better than most
dedicated resampling texts: jackknife with pseudovalues and the median failure case, the
plug-in principle, the 63.2% derivation, five CI flavors with honest coverage talk,
case/residual/wild/parametric regression bootstraps, design-preserving resampling, and the
estimation-vs-testing distinction that trips up most users. Statistically I found nothing
wrong. The findings are about connecting dots the chapter already drew.

---

### [CH24-P01] The regression data are heteroscedastic *on purpose* — but the chapter never says so, wasting its own punchline
- **Priority:** MED
- **Perspective:** Professor (grad reader)
- **Effort:** S
- **Location:** Chapter_Bootstrapping.qmd → "Bootstrapping a Regression Slope" (search anchor: "rnorm(90, 0, 3 + RegressionData$Sleep)")
- **Problem:** The simulated data generate errors with SD = 3 + Sleep — deliberately heteroscedastic. Then the residual bootstrap section warns it's "questionable under heteroscedasticity," and the wild bootstrap section says it "preserves the way residual size changes across X." The reader is standing inside a perfect demonstration and is never told: the three SEs just computed (case ≈ honest, residual ≈ wrong-because-communal-bucket, wild ≈ honest again) differ *because this dataset has the disease being discussed*. Three chunks that read as a catalog could read as an experiment.
- **Fix:** (1) After the data-generation chunk, one sentence: "Look closely at that `rnorm()` call — the noise grows with Sleep. I built heteroscedasticity in on purpose; watch what it does to each bootstrap flavor." (2) After the wild bootstrap, add a 3-row comparison (case SE, residual SE, wild SE) with two sentences: case and wild agree because both respect the changing spread; the residual bootstrap's communal bucket misstates the uncertainty — this is why the flavor matters. Verify by running (the difference should be visible; if the seed makes it underwhelming, nudge the heteroscedasticity).
- **Approved:** [x] — IMPLEMENTED 2026-08-17, both halves, plus a design change the item
  authorized. **The seed was untouched; the design was changed.**

  **Run it first, and the item's own premise was underwhelming.** On the original data
  (`rnorm(90, 0, 3 + Sleep)`) the three SEs came out case 0.561, residual 0.539, wild 0.557.
  That is a 4% spread, which a student would correctly call noise. The Breusch-Pagan test
  said the heteroscedasticity was real ($p = .007$), but it was not *doing* anything to the
  bootstraps, because $\sigma$ grows linearly while the high-leverage cases sit at *both*
  ends of a uniform $X$: the quiet low-Sleep end cancels most of the loud high-Sleep end.

  Fixed by concentrating the noise where the leverage is, `rnorm(90, 0, Sleep^3 / 30)`,
  which climbs from about 1 point to about 24 across the range. Five designs were tried and
  compared against `sandwich::vcovHC(type = "HC3")` as ground truth before one was picked;
  the linear variants topped out at a 9% spread and only the cubic separated cleanly.
  `set.seed(347)`, `set.seed(348)` and `set.seed(349)` are all unchanged.

  Result, in the new "The Three Flavors, Side by Side" section:

  | | SE |
  |---|---|
  | Ordinary `lm()` | 0.678 |
  | HC3 sandwich | 0.851 |
  | Case bootstrap | 0.818 |
  | Residual bootstrap | **0.677** |
  | Wild bootstrap | 0.828 |

  **The residual bootstrap reproduces the ordinary `lm()` SE to within 0.001**, which is a
  better punchline than the item asked for: three thousand resamples bought a number we
  already had. Case and wild land next to HC3. Adding the OLS and HC3 rows goes beyond the
  item's "3-row comparison" and it is the reason the demonstration has any authority, since
  otherwise the reader has three numbers and no way to tell which two are right. It also
  pays a real debt to the Advanced Regression Diagnostics chapter, which derives HC3 and
  already loads `sandwich`, so no new package enters the book.

  Note the chunk output in `bootstrap-regression` changes (slope 3.95, wider CI). No prose
  quoted those numbers, so nothing else needed rewriting.

### [CH24-U01] Hoekstra CI-misinterpretation callout is a verbatim repeat of the Standard Error chapter's
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Bootstrapping.qmd → CI callout (search anchor: "442 first-year students, 34 master's students, and 118 researchers")
- **Problem:** The same study, same numbers, and near-same phrasing appear in Chapter 5. Repetition of the *lesson* is fine (arguably good); repeating the full study description verbatim reads like an accident and costs a paragraph in an already-dense chapter.
- **Fix:** Compress here to two sentences + cross-reference: "The long-run-procedure interpretation applies to bootstrap intervals too — and the evidence says almost nobody holds onto it (see the Standard Error chapter for the depressing Hoekstra et al. numbers). Reread that callout if the word 'confidence' has started whispering probability statements to you."
- **Approved:** [x] — IMPLEMENTED 2026-08-17 using the item's drafted text essentially
  verbatim. The `@hoekstra2014` citation is kept so the reference still resolves; the
  Standard Error chapter carries the full study description and still cites it once.
  Callout dropped from 87 words to 46.

### [CH24-B01] Short Story is prose; convert to bullets (same as CH19/CH21)
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Bootstrapping.qmd → "The Short Story" (search anchor: "computation is not forgiveness.")
- **Problem:** Prose recap in the bullet-recap book. Content is right; format inconsistent.
- **Fix:** Bullet it: jackknife = leave-one-out (bias, SE, influence; fails on medians); bootstrap = resample-with-replacement from the sample-as-population; resample the unit that was sampled; pick the CI flavor to fit the estimator (percentile is intuitive, BCa is usually better, normal assumes symmetry); B controls Monte Carlo error, not information; estimation ≠ null-hypothesis testing — make the null true before resampling for a test. Keep "computation is not forgiveness" as the closing line.
- **Approved:** [x] — IMPLEMENTED 2026-08-17. Seven bullets, all the content the item listed,
  and "computation is not forgiveness" kept as the closing line on its own. One bullet was
  added that the item could not have known about: pick the *regression* flavor to fit the
  errors, because CH24-P01 now gives the chapter a demonstration to recap.

---

**Global items that also apply here:** missing `fig-alt` (YAML clean, like Ch19/21).

### Done alongside the items, 2026-08-17

- **G02 (`fig-alt`): DONE**, both figures, written against the rendered PNGs and checked
  against the actual bin counts and jackknife values.
- **A third clipped figure label**, after the two in Ch22 and the two in Ch19. The jackknife
  plot's `text(12, ..., pos = 3)` annotation rendered as "190-minute studer" because it was
  centered above the last point, which sits hard against the right edge. Changed to
  `pos = 2` so the label runs leftward from the point. Verified in the re-rendered PNG.
  **Three sessions running, five figures. Treat `text()` near a plot boundary as a defect
  on sight, and look at the image every time.**
- **Em-dash density: 0.41 → 0.35.** Already under target; nothing needed cutting.
- **YAML was already clean**, so G01 did not apply. No hidden `load-libraries` block either,
  so G05b does not apply to this file. `library(sandwich)` is the one library call added,
  and it sits at first use per §14b rule 2.
- **The opening was checked against §15 and flagged to Alex, who said leave it alone.**
  It is abstract-first but it answers "why do I care" in its first two paragraphs and
  carries two jokes, which puts it closer to Ch20's opener than Ch10's. Do not re-propose.

**Not flagged (deliberate):** "A very stable estimate of the wrong uncertainty"; "ten
thousand wrong resamples are wrong with excellent numerical stability"; the jackknife
returning inside BCa "wearing a fake mustache"; the histogram of 5,000 medians; the
"Resample the Unit That Was Sampled" callout (the single most important sentence in applied
bootstrapping). This chapter, Ch14, and Ch21 are the book's grad-level spine — when the
mixed-models part ships, it should be written to this standard.
