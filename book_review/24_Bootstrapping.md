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
- **Approved:** [x ]

### [CH24-U01] Hoekstra CI-misinterpretation callout is a verbatim repeat of the Standard Error chapter's
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Bootstrapping.qmd → CI callout (search anchor: "442 first-year students, 34 master's students, and 118 researchers")
- **Problem:** The same study, same numbers, and near-same phrasing appear in Chapter 5. Repetition of the *lesson* is fine (arguably good); repeating the full study description verbatim reads like an accident and costs a paragraph in an already-dense chapter.
- **Fix:** Compress here to two sentences + cross-reference: "The long-run-procedure interpretation applies to bootstrap intervals too — and the evidence says almost nobody holds onto it (see the Standard Error chapter for the depressing Hoekstra et al. numbers). Reread that callout if the word 'confidence' has started whispering probability statements to you."
- **Approved:** [ x]

### [CH24-B01] Short Story is prose; convert to bullets (same as CH19/CH21)
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Bootstrapping.qmd → "The Short Story" (search anchor: "computation is not forgiveness.")
- **Problem:** Prose recap in the bullet-recap book. Content is right; format inconsistent.
- **Fix:** Bullet it: jackknife = leave-one-out (bias, SE, influence; fails on medians); bootstrap = resample-with-replacement from the sample-as-population; resample the unit that was sampled; pick the CI flavor to fit the estimator (percentile is intuitive, BCa is usually better, normal assumes symmetry); B controls Monte Carlo error, not information; estimation ≠ null-hypothesis testing — make the null true before resampling for a test. Keep "computation is not forgiveness" as the closing line.
- **Approved:** [ x]

---

**Global items that also apply here:** missing `fig-alt` (YAML clean, like Ch19/21).

**Not flagged (deliberate):** "A very stable estimate of the wrong uncertainty"; "ten
thousand wrong resamples are wrong with excellent numerical stability"; the jackknife
returning inside BCa "wearing a fake mustache"; the histogram of 5,000 medians; the
"Resample the Unit That Was Sampled" callout (the single most important sentence in applied
bootstrapping). This chapter, Ch14, and Ch21 are the book's grad-level spine — when the
mixed-models part ships, it should be written to this standard.
