# Chapter 14 — Statistical Control: What Are We Actually Removing? (Chapter_Control.qmd)

**Snapshot:** ~3,500 words. Outstanding. Residuals-first (formulas later), the sr²=ΔR²
bridge, Frisch–Waugh–Lovell demonstrated live, an honest "partial looks bigger because the
denominator shrank" explanation, and — uniquely in the whole book — **end-of-chapter self-test
questions with collapsible answers**. That Q&A pattern is named in 00_OVERVIEW.md as the
model for every core chapter. Only small fixes here.

---

### [CH14-B01] `callout-danger` is not a Quarto callout type
- **Priority:** MED
- **Perspective:** Publisher
- **Effort:** S
- **Location:** Chapter_Control.qmd → "Statistical Control Is Not Experimental Control" (search anchor: "callout-danger")
- **Problem:** Quarto's callout types are note, tip, warning, caution, and important. `{.callout-danger}` is not one of them — depending on Quarto version it renders as an unstyled div or falls back with a warning, and in the PDF pipeline it can lose its box entirely. This is the chapter's most important warning ("Control Does Not Manufacture Causality") and it's the one styled with an invalid type.
- **Fix:** Change to `{.callout-important}` (matching how other chapters style their top-priority warnings). Then grep the whole book for `callout-danger` and fix any other instances in the same pass. Verify in both HTML and PDF render.
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Changed to `callout-important`. Book-wide grep confirms this was the only instance, matching the count in `00_OVERVIEW.md`. Verified in HTML: the box renders and `callout-danger` no longer appears anywhere in the output. **Not verified in PDF** — the known space-in-filename PDF failure makes a clean PDF build unavailable from this checkout, per the README. Also did the second half of G10, which this item belongs to: the callout convention (important / warning / note / tip, and "there is no callout-danger") is now written down as a comment at the top of `_quarto.yml`.

### [CH14-P01] FWL slope equivalence: add the one-sentence SE caveat for grad readers
- **Priority:** LOW
- **Perspective:** Professor
- **Effort:** S
- **Location:** Chapter_Control.qmd → "How This Becomes the Multiple-Regression Slope" (search anchor: "This result is sometimes called the **Frisch–Waugh–Lovell theorem**")
- **Problem:** The three-slope demonstration is correct and lovely. The one thing a grad student will overgeneralize: the *slopes* match, but the standard errors and df from the two auxiliary regressions do NOT match the full model's (the residualized regressions don't know a degree of freedom was spent estimating the Anxiety adjustment). Someone will run the shortcut regression and report its t-value.
- **Fix:** Add one sentence after the FWL paragraph: "One caution: the slopes match, but the standard errors and t-tests from these shortcut regressions do not (they don't know Anxiety already spent a degree of freedom). Report inference from the full model; use the residual regressions to *understand* it."
- **Approved:** [x] — IMPLEMENTED 2026-08-16. Added as its own paragraph directly after the FWL paragraph, so that paragraph still lands on its own punchline. Drafted text used with light fitting: contractions expanded to match the chapter's explanatory register, and the sentence split so the "report from the full model" instruction stands alone. **Verified by running.** All three slopes are 1.4149. Standard errors are 0.3693 (full model), 0.4056 (original Y on residualized X), 0.3674 (both sides residualized); residual df are 97, 98, 98. So the shortcut regressions are genuinely one df richer than they earned, which is exactly the mechanism the item names. Worth noting for the record: the partial route's SE comes out slightly *smaller* than the full model's, not larger, so the prose says only that they do not match rather than implying a direction.

### [CH14-U01] The four self-test questions deserve a signpost earlier in the book
- **Priority:** LOW
- **Perspective:** Student
- **Effort:** S
- **Location:** Chapter_Control.qmd → "Four Questions Before You Escape" (search anchor: "### 1. Caffeine, Sleep, and Exam Scores")
- **Problem:** Nothing wrong here — this section is the book's only self-assessment and it works beautifully (collapsible answers keep the think-first pressure). The issue is scarcity: it exists only in this chapter, so no reader learns to *expect* it. Logged here as the anchor for the cross-cutting item (add 3–5 "Questions Before You Escape" + collapsible answers to every core chapter, reusing this exact format and title).
- **Fix:** No change to this chapter. See cross-cutting item in 00_OVERVIEW.md.
- **Approved:** [x] — NO CHANGE NEEDED 2026-08-16, as the item itself specifies. The chapter is untouched here. Still open as the anchor for G04.

---

**Global items that also apply here:** chapter YAML residue; missing `fig-alt`.

**Global items implemented in this chapter, 2026-08-16:** G01 (YAML stripped to `title:` only);
G02 (`fig-alt` on all four figures: the Ballantine, the residual-lines plot, and both
two-panel comparison plots); G10 (see CH14-B01). Em-dash density was already at 0.83 and
needed no sweep. The chapter's only remaining dashes are the en dashes in "Frisch–Waugh–Lovell"
and "Study Hours–Exam Score", which are safe in the PDF fonts and are not em-dashes.

**Not flagged (deliberate):** Everything else. The "Semi-partial leaves Y alone. Partial
residualizes both sides." box is the best two-sentence summary of this topic in existence;
the beta/sr/pr comparison table with a Meaning column is exactly what CCAW Chapter 3 readers
need in advance; "making the software eat the entire refrigerator" earns its place. The
opening "your brain may file a complaint" callout models the right way to license difficulty
for anxious readers.
