# Chapter 9 — Power and Effect Size (Chapter_Power_Effect_Size.qmd)

**Snapshot:** ~7,000 words — the longest chapter, and it earns most of its length. The
undergrad/advanced split (Short Story at the natural stopping point, then an unnumbered
"Advanced Topics" section) is exactly the structure the preface promises, and the advanced
material (observed-d sampling distributions, safeguard power, simulation-based power with
dropout) is better than what most graduate courses teach. The opening "hidden code is
deliberate" callout and the closing figure-credit callout are both patterns worth
propagating. Findings here are few and mostly small — but one explanation conflates the very
two counts the Standard Error chapter warns about.

---

### [CH09-P01] "The Answer Is Unpleasant" blames the 13 children for a wobble caused by the 10 studies
- **Priority:** MED
- **Perspective:** Professor
- **Effort:** M
- **Location:** Chapter_Power_Effect_Size.qmd → "The Answer Is Unpleasant" (search anchor: "Our samples were small. With only thirteen children")
- **Problem:** The demo computes `SD(10 sample means)` and compares it to the theoretical SEM, then explains the mismatch and left-skew by saying "with only thirteen children, we are most likely to grab people from the fat middle." But the quantity in the histogram is an SD estimated from **10 values** (the 10 study means) — its downward bias and right-skew come from estimating an SD with k=10, and would persist no matter how many children were in each study. The 13 children set the *true* SEM (5/√13); the 10 studies set how badly we estimate it. As written, the explanation commits the exact "two different counts are hiding in this example" confusion the Standard Error chapter has a callout warning against. The underlying lesson (S underestimates σ; hence Gosset; hence t) is right — it's aimed at the wrong count.
- **Fix:** Two options. (a) Minimal rewording: attribute the wobble correctly — "we estimated a standard deviation from only ten numbers (the ten study means), and SDs estimated from few values run small and skewed — the same disease that infects the S you compute from thirteen children, which is Gosset's problem." (b) Cleaner demo (preferred): drop the two-layer construction; simulate the distribution of `sd(rnorm(13, 50, 5))` across 5,000 studies directly against σ = 5 — one count, same histogram shape, same red line, and the "13 children miss the extremes" explanation becomes *correct*. Then the existing bridge to the t-distribution lands unchanged. Verify by running.
- **Approved:** [ x]

### [CH09-P02] Homer's episode is S2:E2, not S7:E2
- **Priority:** LOW
- **Perspective:** Publisher (fact-check)
- **Effort:** S
- **Location:** Chapter_Power_Effect_Size.qmd → Homer Simpson callout (search anchor: "Simpson and Delilah")
- **Problem:** "Simpson and Delilah" is Season 2, Episode 2 (production code 7F02 — likely the source of the "7"). The book's fans include exactly the kind of people who will email about this, and the callout is otherwise one of the best statistical-vs-clinical-significance explanations in print.
- **Fix:** Change "(The Simpsons, S7:E2)" to "(The Simpsons, S2:E2)".
- **Approved:** [ x]

### [CH09-P03] "Radio and radar" again — same fix as CH06-P05
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Power_Effect_Size.qmd → "Signal Detection Theory" (search anchor: "developed alongside radio and radar")
- **Problem:** Same anachronism as the one-sample chapter (SDT is WWII-radar-era, not radio-era). If CH06-P05 is approved, this instance should be fixed identically so the two chapters keep telling the same story.
- **Fix:** "…borrowed from signal detection theory, developed for radar operators deciding whether a blip was a plane or noise." Apply to both chapters in one pass.
- **Approved:** [ ]

### [CH09-U01] Give the Week-10 student a roadmap — the exam material starts a third of the way in
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Power_Effect_Size.qmd → after the opening callout (search anchor: "## Probability Is Fickle")
- **Problem:** The 242 Week 10 exam content (Type I/II, α, β, power) begins at the "Type I and Type II Error" section; the opening SEM-wobble demonstration, while good, is the most conceptually demanding way into the chapter. A time-pressed student needs one sentence telling them the layout — especially in a 7,000-word chapter where the last third is explicitly optional.
- **Fix:** Add two sentences after the code callout: "This chapter has three altitudes. The first section explains *why* power exists (small samples flatter you); the middle is the vocabulary your exam wants (Type I/II error, α, β, power) and how to compute power in R; the Advanced Topics at the end are for when someone you love runs a pilot study." Adjust wording to taste.
- **Approved:** [ x]

### [CH09-B01] Duplicated SDT/Cohen's-d block with Chapter 6 — decide who owns it
- **Priority:** LOW
- **Perspective:** Publisher
- **Effort:** M
- **Location:** Chapter_Power_Effect_Size.qmd → "Signal Detection Theory" through "Cohen's d" (search anchor: "The hearing-test version of the table above")
- **Problem:** The SDT origin story, the d formula pair, and the small/medium/large/huge table all appear in both Chapter 6 and here (~1 page of duplication). The "You Have Met These Curves Already" callout shows the author noticed. The *new* content here (hit/miss/false-alarm table mapped onto the power 2×2) is genuinely valuable; the repeated formula/table are padding in an already-long chapter.
- **Fix:** Keep the hearing-test 2×2 and its mapping (that's this chapter's insight). Compress the rest to two sentences + cross-reference to Chapter 6 ("d is the standardized distance between the noise and signal+noise curves — Chapter 6 built this; here's what it buys us"). Cut the duplicated benchmarks table here OR cut it in Ch6 and keep it here — one home, one cross-ref. Alex's call which; recommend keeping the table here since power calculations are where the benchmarks get *used*.
- **Approved:** [ x]

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Not flagged (deliberate):** The Advanced Topics split (template for other chapters — see
cross-cutting); the "Per Group Means Per Group" warning (this exact mistake is endemic);
the safeguard-power section including the negative-lower-bound example ("a wish with decimal
places"); the simulate-your-power pattern validated against the closed form before extending
it — that's how simulation should always be taught. The Kicinski publication-bias citation,
Button et al., Hoenig & Heisey, Perugini et al. are all correctly deployed. This chapter and
Paired-t are the book's quality ceiling; the cross-cutting recommendation is to pull other
chapters *up to* these two, not to trim these down.
