# Chapter 23 — Nonparametric Tests (Ch_35_Nonparametric_Tests.qmd)

**Snapshot:** ~1,800 words. Modern and unusually correct: rank tests are *not* sold as
"tests of medians," the paired-formula footgun is explicitly warned against, follow-ups get
Holm, and the decision-guide table is exactly what a student needs. Minor findings only —
mostly explaining output the chapter already produces.

---

### [CH23-P01] The Hodges–Lehmann estimate appears in the output and is never named or explained
- **Priority:** MED
- **Perspective:** Professor (grad reader) + Student
- **Effort:** S
- **Location:** Ch_35_Nonparametric_Tests.qmd → Wilcoxon rank-sum chunk (search anchor: "conf.int = TRUE")
- **Problem:** Both `wilcox.test(..., conf.int = TRUE)` calls print "difference in location" with a CI — the Hodges–Lehmann shift estimate, which is precisely the effect-size-with-uncertainty the chapter's own reporting checklist (item 4) demands. The reader is never told what that number is, so the chapter's best output line goes unread. There's also no standardized effect size (rank-biserial r) anywhere, which grad students will be asked for.
- **Fix:** After the rank-sum output, add ~4 sentences: the "difference in location" is the Hodges–Lehmann estimate (median of all between-group pairwise differences — a location-shift effect size in raw units) and its CI; that plus the group medians/IQRs satisfies the reporting checklist. Add one line for the standardized option: rank-biserial correlation (e.g., `effectsize::rank_biserial()` or the r = Z/√N approximation), with the usual caveat that raw-units effects communicate better.
- **Approved:** [x] — IMPLEMENTED 2026-08-17 as a new section, "Reading the Line Everyone
  Skips", after the rank-sum output. The Hodges–Lehmann estimate is named, defined, and then
  **rebuilt by hand in a chunk**: `median(outer(breathing, chainsaw, "-"))` over all 100
  pairwise differences returns exactly the $-4$ R printed, so the reader recognises the
  number instead of being told about it (VOICE_GUIDE §17, the identity payoff). The section
  also warns that the shift is *not* the difference of the two medians, points at checklist
  items 3 and 4, and adds `effectsize::rank_biserial()` ($r = -0.98$, 95% CI
  $[-0.99, -0.94]$) as the standardized option with the item's caveat that raw units
  communicate better. **The paired call is covered too**, since it labels the same quantity
  "(pseudo)median" and would otherwise read as a third unexplained number.

### [CH23-U01] `exact = FALSE` is used five times and never explained
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_35_Nonparametric_Tests.qmd → first wilcox.test (search anchor: "exact = FALSE,")
- **Problem:** Every rank-test call sets `exact = FALSE` silently. Students who omit it get warnings about ties ("cannot compute exact p-value with ties") and think they broke something — the same anxiety the Spearman section of the correlation chapter needs a sentence for (CH10-P03). One explanation, first use.
- **Fix:** At first use: "`exact = FALSE` asks for the normal approximation. With tied ranks (psychology data always ties), R cannot compute exact p-values and would warn you before falling back anyway — we're just telling it upfront so nobody panics." 
- **Approved:** [x] — IMPLEMENTED 2026-08-17 at first use, which is the rank-sum call, using
  the item's wording. One added sentence notes that every other rank test in the chapter
  does the same thing for the same reason, so the single explanation covers all five uses.

### [CH23-U02] No Short Story
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Ch_35_Nonparametric_Tests.qmd → end (search anchor: "offended a normality test at 2:00 a.m.")
- **Problem:** Cross-cutting item; the decision-guide table + reporting checklist provide most of the material.
- **Fix:** Add `## The Short Story`: nonparametric ≠ assumption-free; counts/signs/ranks answer different questions than means; pick by design and question, not by a 2 a.m. normality test; the decision table is the map; follow-ups need Holm; report medians/IQRs + HL shift, and state how ties were handled.
- **Approved:** [x] — IMPLEMENTED 2026-08-17. Six bullets covering everything the item
  listed, placed after the reporting checklist and before the closing callout so the callout
  still gets the last word.

---

### Done alongside the items, 2026-08-17

- **G01 (YAML strip): DONE.** `fontsize`, `geometry` and the `format: pdf:` block removed.
- **`fig-alt`: still n/a.** The chapter has no figures. The reviewer's optional suggestion,
  a figure showing the raw fear scores against their ranks so the reader can see what
  ranking does to the chainsaw group, was **not** implemented: it was listed as optional and
  effort M rather than approved as an item. It is still a good idea and is now the only
  outstanding suggestion on this chapter.
- **Em-dash density: 2.81 → 0.49**, the floor. This was the worst chapter in the book outside
  the two untouchable Part 1 chapters. Three real dashes, all cut to commas.
- **Chunk names: DONE**, twelve anonymous chunks named.
- **`library(effectsize)` sits at first use** of `rank_biserial()`, per §14b rule 2. It is
  the only non-base package the chapter needs, and there is no hidden `load-libraries` block
  here, so G05b does not apply to this file.
- **The opening was checked against §15 and flagged to Alex, who said leave it alone.**
  Worth recording: that is the **first no** after six consecutive chapters (15, 16, 18, 19,
  21, 22) where flagging an opening produced a yes. The device offered was a cold open
  running `shapiro.test()` on a big clean sample and a small dirty one to show it getting
  both backwards. Do not re-propose it.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt` (n/a — the
chapter has no figures, which is itself worth a thought: one figure showing raw scores vs.
their ranks for the fear data would visualize what ranking does to the chainsaw outlier;
optional, effort M).

**Not flagged (deliberate):** "Laziness is not a covariance structure" (frame it); the
noise-canceling-headphones analogy for discarded information; the honest "rank tests change
the question" framing; the warning against normality-test-driven test selection (stated
twice, deserves to be). The decision-guide table should be cross-referenced from the
Reporting appendix if that chapter gets a test-chooser (check when reviewing Ch25).
