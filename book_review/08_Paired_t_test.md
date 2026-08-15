# Chapter 8 — Paired-Samples t-Test (Chapter_Paired_t_test.qmd)

**Snapshot:** ~1,500 words. This is the best-engineered chapter in Part 1 — visible
simulation code with named chunks, the spaghetti pairs plot ("rectangular coffins"), a real
assumptions section, correct R-4.4 formula-syntax warning, dz with the multiple-denominators
caveat, Short Story, and a routing pointer to mixed regression. **Use this chapter as the
structural template for the cross-cutting fixes to other chapters.** Only two content gaps,
both from the Week 12 curriculum: order effects/counterbalancing, and the
paired-vs-independent power comparison.

---

### [CH08-U01] Order effects and counterbalancing are missing — and the chocolate design begs the question
- **Priority:** HIGH
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_Paired_t_test.qmd → "A Chocolate-Fixation Study" (search anchor: "We measure 48 students twice:")
- **Problem:** 242 Week 12 Class 1 explicitly teaches "Order effects and fatigue effects: why design matters. Counterbalancing." The chapter never mentions them — yet its own running example is exposed to exactly this confound: if every student does no-chocolate first and chocolate second, "chocolate improves fixation" is indistinguishable from "students settle down in the second session" (or fatigue makes it worse). The book's design description doesn't even say which order the conditions ran in. The key *disadvantage* of within-subjects designs (carryover), named in the curriculum as the counterweight to the power advantage, is absent.
- **Fix:** Add a short section (or callout) after the study description, ~150 words: (1) name the threat — practice, fatigue, and carryover effects ride along with any repeated measurement; (2) state the fix — counterbalance: half the students get chocolate first, half second, so order effects cancel out of the condition comparison on average; (3) one sentence amending the study description ("assume we counterbalanced, because we are professionals"); (4) one sentence on carryover that counterbalancing can't fix (chocolate eaten in session 1 doesn't un-eat itself if sessions are ten minutes apart — spacing matters). Keep the voice.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14 as a `callout-warning` ("The Price of Measuring the Same Person Twice") placed directly after the study description, before the simulation chunk. All four pieces from the drafted fix: the three threats named as a bulleted list (practice, fatigue, carryover), the confound stated in terms of this study ("chocolate increased fixation time" and "students settled down in the second session" are the same sentence), counterbalancing as the fix with the drafted "because we are professionals" line, and the closing note that carryover survives counterbalancing when sessions sit close together.

### [CH08-U02] Show the payoff: same data as independent vs. paired — the three-line demo
- **Priority:** MED
- **Perspective:** Student + Professor
- **Effort:** S
- **Location:** Chapter_Paired_t_test.qmd → "Why Pairing Can Help" (search anchor: "This often gives a smaller standard error than an independent-samples analysis.")
- **Problem:** The curriculum (Week 12 Class 2) wants students to see that within-subjects designs "reduce unexplained variance and increase power… comparing effect sizes to between-subjects equivalents." The chapter gives the variance-of-differences formula (correct, elegant) but never runs the one comparison that makes it visceral: analyze the same 96 numbers *ignoring* the pairing and watch the t shrink. The data and correlation are already sitting in `paired_wide`.
- **Fix:** Add a visible 4-line chunk after the formula discussion: `cor(paired_wide$chocolate, paired_wide$no_chocolate)` (show r ≈ .7 from the simulation's shared participant effect), then `t.test(paired_wide$chocolate, paired_wide$no_chocolate)` (unpaired, wrong on purpose) beside the earlier paired result. Two-sentence interpretation: "Same numbers, same means. Ignoring the pairing hands all the stable person-to-person variability back to the error term, and the t-value deflates accordingly. This is why the design chapter of every methods book keeps yelling about within-subjects power." Label the unpaired call clearly as deliberately wrong so nobody copies it.
- **Approved:** [ x] — IMPLEMENTED 2026-08-14 as a new subsection, "How Much Does Pairing Actually Buy You?", with a visible chunk running `cor()` and the deliberately-unpaired `t.test()`, both labelled as wrong-on-purpose in a code comment and in the prose. **Correction to this item:** it predicted r ≈ .7, but the *sample* correlation here is **.46**. The .69 figure is the theoretical value implied by the simulation (participant SD 1.20, noise SD 0.80), and n = 48 pulls the realized value well below it. Every number in the new prose is inline rather than typed, so this cannot drift: paired t(47) = 4.34 against unpaired t(89) = 3.21, a ratio of 1.35, with SE 0.18 versus 0.24. Ends by pointing out that .46 is a mediocre correlation and a stronger one would have bought more, which makes the $-2rS_1S_2$ term concrete.

### [CH08-P01] Matched-pairs gets defined, then silently dropped
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Paired_t_test.qmd → "Why Pair the Scores?" (search anchor: "matched strangers are not magical clones")
- **Problem:** The matched-pairs paragraph is good (and funny), but the design never reappears — the assumptions section says "observations form genuine pairs" without noting that for matched (rather than repeated) pairs, the analysis is identical but the correlation is usually much weaker, so the power benefit often underwhelms. One sentence would complete the thought and preempt a classic exam misconception (matching = same benefit as repeated measures).
- **Fix:** Add one sentence at the end of the matched-pairs paragraph: "The analysis is identical — pair, difference, test — but matched strangers usually correlate far less than a person with themself, so the power benefit is real but smaller. See the $-2rS_1S_2$ term below: everything depends on that r."
- **Approved:** [ x] — IMPLEMENTED 2026-08-14, appended to the matched-pairs paragraph. Used the drafted sentence with two adjustments: the em-dashes became parentheses and a comma per Alex's standing request, and "the power benefit is real but smaller" became "real and smaller" so the sentence does not read as though the benefit were in doubt. The forward pointer to $-2rS_1S_2$ now also pays off in the new CH08-U02 subsection, which ends on the realized correlation.

---

**Also done in this pass (approved global items):**

- **G01** (YAML strip): reduced to `title:` only. This was the last of the three t-test chapters still carrying the dead `fontsize`/`geometry`/`format: pdf` block.
- **G02** (fig-alt): both figures now carry `fig-cap` and `fig-alt`. The `inspect-differences` chunk also had its `fig.width`/`fig.height` moved from the chunk header into `#|` options.

**Em-dash discipline:** zero em-dashes in the chapter, including all new prose.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Not flagged (deliberate):** Nearly everything. This chapter's architecture — hook callout →
design taxonomy → simulate → *plot the pairs before testing* → test as disguised one-sample →
unit-of-analysis callout → effect size with denominators caveat → assumptions on the
differences → APA report → routing forward — is the template. The cross-cutting recommendation
in 00_OVERVIEW.md names this chapter as the pattern for retrofitting Chapters 6–7 and several
Part 2 chapters. The "R Has Become Picky" section is exactly the kind of version-aware detail
that makes a free web book more current than published competitors — keep it maintained.
