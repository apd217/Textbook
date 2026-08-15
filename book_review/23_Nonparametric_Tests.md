# Chapter 23 — Nonparametric Tests (Chapter_Nonparametric_Tests.qmd)

**Snapshot:** ~1,800 words. Modern and unusually correct: rank tests are *not* sold as
"tests of medians," the paired-formula footgun is explicitly warned against, follow-ups get
Holm, and the decision-guide table is exactly what a student needs. Minor findings only —
mostly explaining output the chapter already produces.

---

### [CH23-P01] The Hodges–Lehmann estimate appears in the output and is never named or explained
- **Priority:** MED
- **Perspective:** Professor (grad reader) + Student
- **Effort:** S
- **Location:** Chapter_Nonparametric_Tests.qmd → Wilcoxon rank-sum chunk (search anchor: "conf.int = TRUE")
- **Problem:** Both `wilcox.test(..., conf.int = TRUE)` calls print "difference in location" with a CI — the Hodges–Lehmann shift estimate, which is precisely the effect-size-with-uncertainty the chapter's own reporting checklist (item 4) demands. The reader is never told what that number is, so the chapter's best output line goes unread. There's also no standardized effect size (rank-biserial r) anywhere, which grad students will be asked for.
- **Fix:** After the rank-sum output, add ~4 sentences: the "difference in location" is the Hodges–Lehmann estimate (median of all between-group pairwise differences — a location-shift effect size in raw units) and its CI; that plus the group medians/IQRs satisfies the reporting checklist. Add one line for the standardized option: rank-biserial correlation (e.g., `effectsize::rank_biserial()` or the r = Z/√N approximation), with the usual caveat that raw-units effects communicate better.
- **Approved:** [ x]

### [CH23-U01] `exact = FALSE` is used five times and never explained
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Nonparametric_Tests.qmd → first wilcox.test (search anchor: "exact = FALSE,")
- **Problem:** Every rank-test call sets `exact = FALSE` silently. Students who omit it get warnings about ties ("cannot compute exact p-value with ties") and think they broke something — the same anxiety the Spearman section of the correlation chapter needs a sentence for (CH10-P03). One explanation, first use.
- **Fix:** At first use: "`exact = FALSE` asks for the normal approximation. With tied ranks (psychology data always ties), R cannot compute exact p-values and would warn you before falling back anyway — we're just telling it upfront so nobody panics." 
- **Approved:** [ x]

### [CH23-U02] No Short Story
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Nonparametric_Tests.qmd → end (search anchor: "offended a normality test at 2:00 a.m.")
- **Problem:** Cross-cutting item; the decision-guide table + reporting checklist provide most of the material.
- **Fix:** Add `## The Short Story`: nonparametric ≠ assumption-free; counts/signs/ranks answer different questions than means; pick by design and question, not by a 2 a.m. normality test; the decision table is the map; follow-ups need Holm; report medians/IQRs + HL shift, and state how ties were handled.
- **Approved:** [ x]

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
