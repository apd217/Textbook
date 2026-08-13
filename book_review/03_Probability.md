# Chapter 3 — Probability: The Gods Are Fickle (Chapter_Probability.qmd)

**Snapshot:** ~2,400 words. Monty Hall opener is a model hook; the Bayes/base-rate advanced
section (counting imaginary people) is genuinely excellent pedagogy. The chapter's one
structural flaw is big, though: the global chunk option is `echo = FALSE`, so **a stats-and-R
book teaches an entire chapter with zero visible R code** — the same week the 242 lab has
students using `sample()` and `rbinom()`-style simulation.

---

### [CH03-U01] No visible R code in the whole chapter — show the simulations
- **Priority:** HIGH
- **Perspective:** Student + Professor
- **Effort:** M
- **Location:** Chapter_Probability.qmd → setup chunk (search anchor: "echo = FALSE") and "Chance Is Fickle" section (search anchor: "set.seed(242343)")
- **Problem:** The preface promises "Actual R code you can run yourself." Chapter 2 shows all its code. This chapter hides everything behind `echo = FALSE`, so students see one figure appear by magic. Meanwhile the Week 4 lab (per the curriculum) has students sampling from distributions with `sample()` and building histograms. Probability is *the* topic where 5 lines of simulation beat 5 paragraphs — and simulation is the book's own stated philosophy.
- **Fix:** (1) Add a visible, runnable Monty Hall simulation right after the reveal ("You should switch") — ~10 lines using `sample()`, printing the win proportion for stay vs. switch across 10,000 games, with a one-liner: "If you don't believe me — and you shouldn't, that's the point of the class — make R play the game ten thousand times." (2) Make the coin-flip figure chunk `echo: true` so students see `rbinom()` and the running-proportion trick. (3) Keep decorative-figure chunks hidden. Net effect: two visible chunks, both directly reusable in the lab.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (Monty Hall sim over 10,000 games prints stay = .338, switch = .662; coin-flip chunk echoed; decorative chunks left hidden)

### [CH03-U02] Curriculum names three intuition failures the chapter demonstrates but never names
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Probability.qmd → "Chance Is Fickle, Not Obligated to Look Random" (search anchor: "Real coins have no taste.")
- **Problem:** 242 Week 4 Class 1 explicitly teaches "availability heuristic, representativeness bias, gambler's fallacy" with the fear-of-flying and hot-streak-lottery examples. The chapter *demonstrates* representativeness (invented coin sequences) and the gambler's fallacy (streaks are part of randomness) but never uses the terms, and availability isn't touched. Students will meet these as exam vocabulary with no anchor in the book.
- **Fix:** Add a compact callout (note type) after the streaks paragraph: three rows — **Gambler's fallacy** ("the coin is 'due'… it isn't; coins have no memory"), **Representativeness** ("real randomness looks streakier than the tidy sequences humans invent — you just watched yourself do this"), **Availability** ("vivid events feel more probable: plane crashes make the news, car crashes make traffic reports — which one kills more people?"). Three sentences each, max. This is vocabulary insurance, not a new section.
- **Approved:** [x ] — IMPLEMENTED 2026-08-12 (callout "Three Ways Your Brain Gets This Wrong (They Have Names)")

### [CH03-U03] The Bayes walk-through begs for a natural-frequency tree diagram
- **Priority:** MED
- **Perspective:** Student + Publisher
- **Effort:** M
- **Location:** Chapter_Probability.qmd → "Advanced Section: Bayes, Base Rates, and a Scary Positive Test" (search anchor: "### Step 1: Who Has the Condition?")
- **Problem:** Steps 1–5 are done with counts (the right method — this is textbook Gigerenzer natural frequencies), but as five sequential prose steps spanning ~2 pages. The evidence on teaching base-rate problems says the *picture* of the 10,000 people splitting into four boxes is what sticks. There is no figure in the entire advanced section.
- **Fix:** Add one figure after Step 4: a tree diagram (10,000 → 100 have it / 9,900 don't → 95 TP + 5 FN / 495 FP + 9,405 TN), with the two "positive" boxes highlighted in the same color so the 95-out-of-590 answer is visually inevitable. Base R (rect/arrows like the Ch1 causal diagram) or Graphviz — match the book's homemade-diagram aesthetic. Caption in voice, e.g., "Ten thousand imaginary people, none of whom will email my chair." Keep the prose steps; the figure is a companion, not a replacement.
- **Approved:** [x ] — IMPLEMENTED 2026-08-12 (base-R tree after Step 4; both positive boxes shaded orange; caption is the "none of whom will email my chair" line)

### [CH03-U04] Ending: strong closing paragraph, no scannable recap
- **Priority:** MED
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Probability.qmd → "What This Has to Do with Statistics" (search anchor: "stop blaming divine intervention for bad design.")
- **Problem:** Same as CH01-U01/CH02-U04 — see the cross-cutting "Short Story everywhere" item in 00_OVERVIEW.md. The six-bullet "we need to know" list is close to a recap already; the chapter just needs the standard header and one-line-per-concept treatment (rules of probability, conditional ≠ reversed conditional, streaks are normal, expected value is a long-run average, base rates matter).
- **Fix:** Covered by the cross-cutting item; when implementing, keep the final two sentences ("The Probability Gods remain fickle…") as the closer.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (7 bullets; the "Probability Gods remain fickle" paragraph kept as the closer, per the item)

### [CH03-P01] Dead salmon deserves its citation
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Probability.qmd → "What This Has to Do with Statistics" (search anchor: "possibly inside a dead salmon")
- **Problem:** The chapter is otherwise carefully cited (Ang 2014 for the 50/50 fallacy!), but the dead-salmon fMRI reference — a real study (Bennett et al. 2009 poster / 2010 JSUR) and a perfect multiple-comparisons teaser — floats uncited. Grad students should be handed this paper; it also plants a seed for the Multiple Comparisons chapter.
- **Fix:** Add the Bennett et al. reference to references.bib and cite it here, plus a forward pointer: "(We will meet the salmon again in the multiple comparisons chapter.)" — verify that chapter actually mentions it; if not, note the cross-ref goes one way.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (verified: `bennett2010` was already in references.bib AND already cited in Chapter_Multiple_Comparisons, so the forward pointer resolves in both directions)

### [CH03-P02] "With replacement" is used before it's defined, and assumes deck-of-cards fluency
- **Priority:** LOW
- **Perspective:** Professor + Student
- **Effort:** S
- **Location:** Chapter_Probability.qmd → "The multiplication rule" (search anchor: "Drawing two hearts **with replacement**")
- **Problem:** The hearts example does double duty (independence and conditioning) but leans on two assumptions about the reader: they know a deck has 52 cards with 13 hearts, and they can infer what "with replacement" means from bolding alone. Increasingly, neither is safe. The concept also matters later (bootstrapping resamples *with replacement* — same phrase, chapters later).
- **Fix:** Add one parenthetical sentence before the example: a standard deck = 52 cards, 13 per suit; "with replacement" = put the card back and reshuffle, so the deck resets; "without replacement" = the card stays out, so the deck remembers. Two sentences max, then the existing math stands.
- **Approved:** [ x] — IMPLEMENTED 2026-08-12 (deck composition + both replacement senses defined, with a forward pointer to bootstrapping)

---

**Global items that also apply here:** chapter YAML residue (see CH01-B01 / cross-cutting),
missing `fig-alt` (CH01-B02 / cross-cutting).

**Not flagged (deliberate):** The goat-preference bits, the raccoon-in-a-convenience-store
line, and the "assumption from someone in 1974" jab are all pulling weight. The decision to
put Bayes in an explicitly labeled Advanced section with the counts method (not the formula
first) is exactly right — the formula appearing only at the end should be preserved through
any edit.
