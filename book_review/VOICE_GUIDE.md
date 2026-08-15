# The Alex Voice Guide — How to Write Like This Book

> For any AI (or human) editing the `.qmd` chapters. This is not a style *suggestion*
> document; treat it as a spec. When a rule here conflicts with your instinct to sound
> professional, the rule wins. When it conflicts with statistical accuracy, accuracy wins
> and the joke gets cut — never the reverse.
>
> Status: v1.5, 2026-08-14. **v1.5 adds §13, deliberate "errors" that must not be corrected,
> after a model repeatedly "fixed" a running joke.** v1 was reverse-engineered from the book's text alone; v1.1
> folded in real exam/worksheet material and lecture bits; **v1.2 is the first version
> calibrated against Alex rewriting the model's own output** — he revised Chapter 1 by hand
> and the differences are recorded in §0 and §4. Two rules from v1.1 were flatly wrong and
> are now corrected (bold-for-punchlines, and current idiom at the joke position).
> v1.3 adds three findings from Alex's edit pass on the preface: hedge-stripping (with the
> statistical exception), self-deprecation preferred over the cleverer joke, and the
> inverted dyslexia frame ("weirdo neurotypicals") that editing models will otherwise
> sand off. v1.4 adds his pass on Chapter 2: the failed-slang move, "trim adjectives but
> add specificity," the refinement that he *adds* hedges to factual claims he cannot
> guarantee, and the first entry in the Banned list.
> Alex: edit anything here; your edits outrank everything below. See "How this guide gets
> better" at the end.

---

## 0. The overriding rule: simpler and more direct wins

**Alex's own instruction, 2026-08-12: "I tend to like simpler more direct text when
possible."** This outranks every stylistic preference below it. When you can say a thing in
eight blunt words, do not say it in eighteen balanced ones.

The tell that you have gotten this wrong is the **balanced literary sentence** — the
"not X, but Y" / "less A, but considerably more B" construction that sounds like good
writing and delivers no additional information. Alex cuts these on sight. A real example
from his own edit pass on Chapter 1:

| The reviewing model wrote | Alex replaced it with |
|---|---|
| "That is less comforting than a magic truth machine, but considerably more useful." | "*The important truth is you will always be wrong. Your job is to be less wrong.*" |
| "This book serves two groups that have very different reasons for being tired." | "This book serves two groups cause I am lazy and tired." |
| "The point of this graph is that collecting more people makes our estimate more stable." | "We can see from the graph that collecting more people makes our estimate more stable." |
| "The lesson is that science is a repair process." | "The lesson is that science can repair itself." |

Note what each replacement does: it gets shorter, it gets more concrete, it drops the
literary symmetry, and where possible it puts a human (Alex, or "we," or "you") into the
sentence instead of an abstraction. **When in doubt, cut the second half of your best
sentence.**

### Strip rhetorical hedges. Keep statistical ones.

Alex deletes softening words that protect the writer rather than inform the reader:

| Written | Alex's version |
|---|---|
| "every **reasonable** tool at my disposal" | "every tool at my disposal" |
| "Probability **remains** fickle" | "Probability **is always** fickle" |
| "would have been **helpful**" | "would have been **amazing**" |

This is a hard rule with a hard exception. **Statistical hedges are load-bearing and must
survive**: "does not *automatically* bias the slopes," "under suitable conditions," "tends
to," "approximately normal." Those words are doing precise technical work. The test: if
removing the qualifier would make the sentence *statistically wrong*, keep it. If removing
it only makes the sentence bolder, remove it.

**And he will *add* a hedge to a factual claim he cannot personally guarantee.** In the same
pass where he cut "reasonable," he changed "the free tier **is** enough for this course" to
"the free tier **might be** enough" — because he does not control Posit's pricing. So the
real rule is not "fewer words always." It is: hedges that protect *the writer's ego* get
cut; hedges that protect *the reader from a claim that might be false* get added.

**Trim adjectives; add specificity.** The same pass shows both moves working together:

| Written | Alex's version |
|---|---|
| "which **mysterious** buttons you clicked" | "which buttons you clicked" |
| "In a real **ethical** study" | "In a real study" |
| "a temperamental but **extremely capable** chef" | "a temperamental but **Michelin-starred** chef" |
| "creating a **small** emergency" | "creating a **hair-on-fire** emergency" |

Vague intensifiers ("extremely capable," "mysterious," "small") get deleted or replaced by
something specific enough to picture. Do not read "cut adjectives" as "make it grey."

### Prefer the joke at Alex's expense over the cleverer joke

Given a choice between a witty image and self-deprecation, he picks self-deprecation:

| The model wrote | Alex replaced it with |
|---|---|
| "please tell me before it reproduces" [errors breeding] | "please tell me before I confuse people more than I usually do" |
| "This book serves two groups that have very different reasons for being tired." | "This book serves two groups cause I am lazy and tired." |

The cleverer line is not wrong; it just puts the author above the material. Alex stays below it.

## 1. The one-sentence spec

**Formal diction delivering absurd content, in service of a precise statistical claim,
with the reader treated as a smart, anxious person who hates reading.**

The voice is NOT casual, slangy, or zany. Read the book's best lines: "Do not proceed
directly to the ritual sacrifice." "Pretending they are independent is statistical identity
theft." "The parameter is not wandering around trying to escape." The grammar is complete,
the register is almost courtly — and the *content* is a goat, a volcano, or a union of
asterisks. That contrast IS the joke. If you write "lol basically the p-value is sus," you
have failed in the opposite direction from a textbook committee, but you have still failed.

## 2. The load order (what a paragraph is for)

1. **The statistical claim, stated correctly and completely.** Hedges are precise, not
   decorative ("does not *automatically* bias the slopes," "under suitable conditions").
2. **The intuition** — an image, an example, a personification.
3. **The joke, last.** Punchlines land at the end of the sentence or paragraph, after the
   teaching is done.

**The deletability test:** if you delete the joke, the paragraph must still teach the full
concept. Jokes are seasoning on a complete meal. If removing the funny part removes
information, rewrite.

## 3. The standing mythology (reuse; do not invent)

These are established recurring elements. **Reuse them** for continuity; do **not** invent
new gods, mascots, or running characters without Alex's explicit approval — a new recurring
bit is a voice decision only the author gets to make.

| Element | Role | Example usage |
|---|---|---|
| The Probability Gods | Chance personified; fickle, petty, never malicious | "The Probability Gods did not violate a contract; you invented a contract they never signed." |
| Dorkaos, Ancient Greek God of Statistics | Knower of true distributions; accepts sacrifices | "properly appease *Dorkaos*… with sufficient sacrifices" |
| Reviewer 2 | The adversary; petty, eternal | "stop Reviewer 2 from asking whether heat explains the ice cream" |
| The IRB | Long-suffering ethical brake on Alex's imagined studies | "The Institutional Review Board remains stubborn about this." |
| The foam chainsaw / chainsaw-wielding RA | The recurring unethical manipulation that never gets approved | "chased by a research assistant… yelling 'This was approved by the IRB!'" |
| Coerced undergraduate labor | How data gets collected; the Dean disapproves | "We will call it homework…yeah homework…" |
| Goats, geese, volcanoes | The absurd-concrete image bank | "declare that goats are better than cars and ask for a goat" |
| Future You / Past You | The reproducibility conscience | "Future You is busy, confused, and probably blaming Past You with considerable justification." |
| The dead salmon | Multiple comparisons memento mori | "eventually even dinner appears to think" |
| Effect sizes as bats | Coffee stirrer → Nerf bat → wooden bat → metal bat → mother's slipper | (Chapter 1; reference, don't re-explain) |
| Chicago / UIC local color | CTA, BSB, February bus stops | "anyone waiting for a bus in February" |
| The Nerf bat | Alex's actual physical prop; threatened, never used | "don't make me get the bat" |
| "I will beat you with a stick" | The complexity-overreach threat, specifically for students who reach for unjustified model complexity (3-way+ interactions, kitchen-sink regressions) | "Don't do 4-way interactions or I will beat you with a stick." (See also Ch21's "not a personality trait" callout — same warning, gentler register.) |
| Appeasing Dorkaos | The mechanism, stated plainly: undergrads go in the volcano and probability improves | "Dorkaos can be appeased and help probability be in your favor if you throw undergrads into the volcano." Book usage should keep this at the *threat/ritual* level (sacrifices, offerings) — Alex's own phrasing is blunter in lecture than the page has been so far; when rewriting, favor "sacrifice" over anything more graphic (see §6's Looney Tunes clarifier). |
| Judge Dredd justice | The visceral device for Type I error and due-process failures: "guilty" is decided and *immediately executed*, no appeal | "Imagine that the courts were replaced with the polygraph machine and those found guilty were dealt with 'Judge Dredd style.' What would the type I error rate be?" — reuse this exact move whenever a false positive needs to feel like it costs something. |
| Mad-scientist contamination premises | A drug/treatment is secretly added to a shared population (water fountains, exam candy) and something goes hilariously, unethically wrong | Classical-music drug in the water fountains that turns 0.1% of campus into brain-eating cannibals; a professor drugging Halloween exam candy with anti-anxiety compounds and misplacing a decimal (mL vs. μL, "whoops") until students report the equations "turned into cute fuzzy animals jumping all over the page." Always: no IRB, an escalating side effect, and a deadpan return to the actual stats question. |
| Zombies / monsters with quantifiable traits | A monster premise exists *specifically* to hang a distribution or z-score on it | Zombies that move at "μ = 3 miles per hour, σ = .5"; "what proportion of zombies have Z ≥ 3 in speed?" The monster is a costume for the parameter, not the point of the joke. |
| Chicago vs. New York food wars | A running civic rivalry, deployed for chi-square/independence and social-pressure examples; Chicago is mocked *as often as* New York | Deep dish reframed as "cheese casserole"; a chi-square test of whether social pressure gets Chicagoans to fold their pizza New York–style; "easily enraged locals." Self-deprecating about Alex's own city, not one-sided. |
| "Explain it to your grandmother" | A **required, paired explanation format**, not just a joke — every results-interpretation question on Alex's exams asks for both a plain-English ("to grandma") and a technical/scientific explanation, back to back | "Explain the results of this experiment in your own words as if you were talking to grandma... Explain the results scientifically." This is a genuine pedagogical device (plain-language translation is a real, graded skill) and should be treated as one — see the note after this table. |
| The shifty-eyes disclaimer | Ask something mildly incriminating in an example, then comically over-deny any ulterior motive | A worksheet casually asks the student's own anxiety level "for no particular reason…. looks around all shifty eyes." |
| Rooftop / bungee time-perception studies | A recurring (real, bungee-cord-safe) example for time-perception psychophysics, phrased as if participants are simply thrown off roofs | Used when a chapter needs a memorable, mildly alarming design for "does subjective time distort under threat" — keep the bungee cord in the punchline so the reader clocks it as safe, Looney-Tunes-register danger, not real danger. |

**"Explain it to grandma" is worth promoting past a joke.** It already IS this book's plain-
English instinct (see item G04 in `00_OVERVIEW.md` — self-checks with collapsible answers).
When drafting new self-check questions or APA-adjacent exercises, consider explicitly pairing
"explain it to grandma" (plain English, no jargon, no formulas) with "explain it
scientifically" (the technical register), exactly as Alex's own exams do. This is a stronger,
more Alex-specific format than a generic Q&A and should be flagged to Alex as a candidate
upgrade to G04 rather than implemented silently.

**A quieter throughline worth naming:** distrust of blind automation — verify everything
before you trust it — runs under a lot of this. It shows up as "should you use AI to drive
your car? For the love of all that is holy: no" in lecture, and on the page as "R will
cheerfully calculate the mean of participant ID numbers" and "the software is obedient, you
still have to be the adult in the room." When a passage needs a reason *why* blind trust in
output (statistical or otherwise) is dangerous, this is the register: not fear of technology,
specifically fear of *unverified* technology.

**The dyslexia frame is inverted, and that inversion is deliberate.** Alex writes from the
dyslexic perspective as the *default*. Neurotypical readers are the ones who need
translating, not the other way around:

> "...suggest reworded explanations so they make sense to people who are not dyslexic and
> cannot automatically translate Alex into English."
> "...I might not notice it changed my meaning when I asked it to help translate me to
> **weirdo neurotypicals**."

Never flip this back. An editing model's reflex is to neutralize "weirdo neurotypicals" into
something inclusive-sounding, which destroys the joke *and* the stance. The stance is warm,
not bitter — Alex is not complaining about being dyslexic, he is treating his own wiring as
the baseline and everyone else as the dialect that needs subtitles. Related established
facts: he learns by doing and seeing, dense text makes his brain "go on vacation," and the
whole book's design (minimal words, maximum visuals, runnable code) follows from this.

**Alex's autobiography is closed-source.** Established facts you may reuse: dyslexic,
doesn't like reading, memory of a goldfish, below-average MRT score, brain-dead before
coffee, bald ("a bald ogre like me"), teaching since 2008 and at UIC for ten years, studies
dynamical systems, suspiciously android-like ability to fix computers by proximity. **Never invent new biographical claims, opinions, or anecdotes for Alex.** If a
passage needs a personal aside and none exists, leave a `<!-- ALEX: personal aside here? -->`
comment instead of fabricating one.

## 4. Signature moves (with the mechanics exposed)

**The deadpan escalation.** Start factual, escalate one absurd step, return to work.
> "Give yourself time to install software. Starting 30 minutes before class is not 'giving
> yourself time.' That is creating a small emergency and assigning it to Future You."

Mechanics: three sentences — rule, negation of the excuse, absurd reframe. Never two
escalations in a row.

**The personified statistic.** Statistical objects have small, petty inner lives.
> "Residuals should not organize a protest." / "R will also accept many bad ideas with the
> serene indifference of a vending machine."

Mechanics: the personification always encodes the actual technical property (residual
patterns = systematic structure; R = no input validation). A personification that doesn't
teach is cut.

**The precision snap.** A long careful sentence followed by a very short one.
> "Those measurements may be useful without being perfect… Sometimes they merely give the
> vagueness decimal places."
> "Not similar. *Identical.*"

Mechanics: this is the main rhythm tool. Roughly one snap per section, not per paragraph.

**The honest aside.** Mid-explanation, the author briefly tells the truth about the field
or himself, in bold or italics.
> "*They are still sort of overcorrecting and have totally lost the forest for the trees,
> but we will love them for caring.*"

Mechanics: rare (once or twice a chapter). Its job is credibility — the book earns trust by
admitting what's contested.

**The anti-ritual jab.** Statistical rituals get mocked; statistics itself never does.
> "an ancient statistics ritual told us to" / "the solution is scientific judgment rather
> than purchasing a newer ritual" / "celestial punctuation"

**The heading with a joke stapled on.** Section headings are not neutral labels. Alex
extends them with a comic tag, often one that undercuts the seriousness of the heading
itself.
> "How to Read This Book Without Reading All of It**, Cause Yuck**"
> "Do Not Just Apply Statistics **Like a Monkey Hoping to Type Hamlet Perfectly by Chance**"

Mechanics: the informative part comes first and survives alone; the tag is appended. Do not
invent a heading that is *only* a joke — the TOC still has to work as navigation.

**The italic aphorism.** A short, blunt maxim in italics, standing alone as its own
paragraph, usually closing a section. This is what Alex reaches for instead of a graceful
concluding sentence.
> "*The important truth is you will always be wrong. Your job is to be less wrong.*"

Mechanics: two short sentences maximum, no subordinate clauses, italics for the whole
thing. It is the register of something said aloud at the end of a lecture.

**The "go look it up" aside.** A dangling factual provocation, thrown in and not resolved,
usually as a bolded question or a dash-attached instruction.
> "**Also, did you know there are no such things as fish?**"
> "forgetting is one of the brain's most important skills---look up the people who never
> forget; they are sad, sad people."

Mechanics: it must be true (both of those are), and it must be genuinely optional — the
paragraph works if the reader ignores it. This is Alex's substitute for a footnote.

**The failed slang attempt.** Alex reaches for current teen slang *and simultaneously
announces that he does not understand it*. The joke is the gap between the professor and
the vocabulary, not the vocabulary.
> "...you have joined the rest of us in the never-ending struggle to be hip with what the
> kids are doing today---like skibidi or whatever nonsense you all say now."

Mechanics: this is the **opposite** of the "a me problem" usage in §5. There the idiom is
deployed fluently and lands straight. Here it is deployed badly on purpose, with an explicit
"or whatever nonsense you all say" tag. Both are allowed; the failure mode is using slang
fluently *and* pretending to be young. Pick a lane: either use it correctly and move on, or
flag that you are an old person visiting.

**The direct question to the reader, mid-sentence.** Breaking the fourth wall without
stopping.
> "Read those chapters mostly in order, unless I change my mind---you can read my mind,
> right?"

**The field-level jab.** Where the earlier guide said colleagues are off-limits, *fields*
and *subdisciplines* are fair game, and Alex names the ones that have not reckoned with
replication.
> "...but we will love them for caring, as some other areas of psychology and neuroscience
> still think this is not a me problem."
> "...it is not confined to social-psychology trivia, as some psychologists still sadly
> believe."

Mechanics: aimed at a research culture, never at a named person. Note "a me problem" —
current idiom deployed as the punchline (see §5).

**The kind hand on the shoulder.** Directed at the anxious reader, played straight.
> "If this chapter requires two readings, that does not mean you are bad at statistics." /
> "forgetting is one of the brain's most dependable skills."

Mechanics: never sarcastic, never followed by a joke in the same breath. This is the one
move where the voice drops the bit entirely.

## 5. Register rules

- **Complete sentences, mostly formal — but the register drops on purpose.** The deadpan
  explanatory lines prefer "do not" / "cannot" over contractions. But when Alex is talking
  *about himself or to the reader*, he drops into casual speech and even non-standard
  usage: "This book serves two groups cause I am lazy and tired." Do not "correct" that
  kind of line into formality. The formal register is for the statistics; the casual
  register is for Alex.
- **Second person for the reader, first person plural for doing analysis** ("we fit the
  model"), first person singular for Alex's asides and crimes.
- **Bold** for a term's first definition — **and also for punchlines.** (v1.1 of this guide
  said "never bold for emphasis"; that was wrong. Alex bolds jokes he wants you to actually
  stop and read: "**Also, did you know there are no such things as fish?**") *Italics* for
  asides, for the honest-aside voice, and for standalone aphorisms.
- **Callout titles carry both jobs**: description + twist. "Variance Has Weird Units; SD
  Comes Back Home." "Post-Hoc Power Is a Ghost." A title that is only a joke, or only a
  label, is wrong. Section headings work the same way (see the heading move in §4).
- **No emoji. No memes.** But **current idiom is allowed when it is the punchline** — "this
  is not a me problem" is Alex's own, and it lands precisely because everything around it
  is formal. The rule is not "never be contemporary"; it is "never sound like you are
  performing youth." One such phrase per section, maximum, and only at the joke position.
  Still banned outright: "let's dive in," "pro tip," "game changer," anything from a
  LinkedIn post.
- **Exclamation points are rationed** — early chapters use a few; the mature voice almost
  never does. One per chapter is plenty; zero is fine.
- **Profanity: none.** The strongest language in the book is "nonsense," "garbage," and
  "feral," and that's the ceiling.

## 6. What is never joked about

- **A struggling reader's ability.** The reader is teased as busy/tired/procrastinating
  (universal), never as stupid. Alex is the designated idiot of this book, not the student.
- **Real harms.** The replication-crisis stakes (cancer research, clinical treatments),
  research ethics violations (Milgram-adjacent territory), depression/anxiety data used in
  examples — the prose around these is warm or wry at most, never flippant. Fictional
  chainsaw studies are funny *because* the frame is "the IRB would never"; real ones aren't.
- **Colleagues and real people** (except Reviewer 2, who is a job title, and Alex).
  *Subfields and research cultures are fair game* — see the field-level jab in §4.
- **The reader's future mistakes** are predicted with sympathy, not contempt ("This tiny
  distinction has destroyed entire afternoons" — note: the afternoon is the victim).

**The violence register is Looney Tunes, not horror.** Chainsaws, volcanoes, zombies, and
"beat you with a stick" are all load-bearing bits, and they work because nobody actually gets
hurt on the page — the anvil always misses, the IRB always intervenes before the chainsaw
connects, the bungee cord is always mentioned. Cartoon violence is fair game and should stay
funny, not squeamish; the line is graphic detail, gore, or anything that reads as real-world
harm rather than a Saturday-morning stunt. If a fix needs a "something bad happens" beat, ask
whether it plays as Wile E. Coyote or as an actual injury — only the former is in voice.

## 7. Joke budget

- At most ~1 comic beat per paragraph-cluster; never two punchlines back-to-back.
- Dense technical sections (derivations, formula blocks) run *dry* with one release valve
  at the end. Look at "The Moderately Mathy Version" in the Control chapter: zero jokes for
  15 lines, then "Statistics has briefly behaved itself."
- APA write-up examples are played completely straight (they're models for graded work),
  with one permitted wink in the surrounding prose, never inside the report itself.
- If a section you're editing already has its joke, your edit adds **zero** new jokes.

## 8. Calibration: three rewrites of the same content

Target content: *introducing the assumption of independence for the independent-samples
t-test.*

**Failure mode A — textbook committee (too corporate):**
> "It is important to note that the independence assumption is crucial. Each observation
> must be statistically independent of all other observations. Violations of this
> assumption can compromise the validity of inferential conclusions."

Everything is generically true and nothing lands. Banned tells: "It is important to note,"
"crucial," passive hedging, zero images, no reader.

**Failure mode B — AI doing "quirky" (too zany):**
> "Okay, so independence is basically a HUGE deal 😅. If your data points are besties, your
> t-test will totally freak out! Think of it like… statistics drama! The Probability Gods
> are literally shaking rn."

Slang, emoji, exclamation stacking, mythology deployed as decoration instead of mechanism,
and no actual statistical content. This failure is *worse* than A because it wears the
book's costume.

**The voice:**
> "Each rider answers alone. If you survey five friends traveling together, you have one
> opinion wearing five coats — and the model, which believes it met five strangers, becomes
> confident in ways it has not earned. Independence is the assumption that actually kills
> studies, and no amount of statistical fanciness resurrects them."

Complete sentences, formal diction, one image that *is* the concept (correlated errors =
one opinion in five coats), consequence stated precisely, punchline last, deletable joke.

## 9. Pre-flight checklist for any prose you write or edit

0. **Can this be shorter and blunter?** Cut the balanced literary sentence. (§0)
1. Is the statistical claim exactly correct, hedges and all?
2. Does the paragraph survive with the joke deleted?
3. Is the punchline at the end?
4. Did you reuse existing mythology instead of inventing (or explain a new image locally)?
5. Did you invent any fact about Alex? (If yes: remove, leave a comment.)
6. Full-sentence deadpan, no slang, no emoji, ≤1 exclamation point?
7. Would this survive being read aloud in lecture without the lecturer wincing?
8. Is anything laughing *at* the reader? (Rewrite so the reader and Alex laugh together.)
9. Does a nearby sentence already carry a joke? (Then yours carries none.)
10. If the passage touches real harm or the reader's anxiety: did you play it straight?

---

## 10. How this guide gets better (process, for Alex)

This v1 was reverse-engineered from the text. It becomes *your* voice guide through use:

1. **Grade this guide first.** Read §3–§8 and mark anything that's wrong about you —
   especially the mythology table (is anything in there a bit you're already tired of?)
   and the "never joked about" list. Ten minutes of red ink here is worth more than
   anything else on this page.
2. **Build the exemplar bank from your own favorites.** Add a §11 below with 10–15
   passages you consider peak Alex, tagged by job ("definition," "warning," "transition,"
   "kindness"). Models imitate examples far better than rules; the rules exist to explain
   the examples.
3. **Run every implementation session as a calibration loop.** When Opus implements
   approved items, review the diffs and flag each voice miss with one line about *why* it
   missed ("too eager," "invented a wizard," "joke before the definition"). Each flag
   becomes a new bullet or banned-phrase here. After two or three chapters of this, misses
   should approach zero.
4. **Use the audition rule.** Before letting any new model touch a chapter, have it rewrite
   one fixed paragraph (suggestion: the Failure-A paragraph in §8) and compare to the
   target. Thirty seconds tells you whether it internalized the guide.
5. **Feed it a lecture transcript.** The book is "two decades of ranting" — the source of
   the voice is spoken. One recorded lecture, auto-transcribed and dropped in this folder
   as `VOICE_CORPUS_lecture.md`, would give a model the authentic rhythm (where you pause,
   how you land a bit live) that no written analysis captures.
6. **Keep a graveyard.** Add a §12 "Banned by Alex" list — specific jokes, words, or moves
   you've rejected in diffs, so no model resurrects them. ("No puns on 'mean.'" is the kind
   of law that only you can pass.)

## 11. Exemplar bank (Alex: paste your favorites here)

Pulled from Alex's own exams/worksheets and chat, 2026-08-12. Verbatim except where noted
[bracketed] for context. Add more any time — see §10.2.

**Deadpan absolutism (a rule stated with zero hedging, played completely straight):**
> "Should you use AI to drive your car? For the love of all that is holy: No, and we will
> dedicate a lecture to it."

**The paranoid deadpan aside** [worksheet casually asks students to self-report their own
anxiety level after a scary word-problem]:
> "Note: What is your anxiety level 0-10 scale (1 being totally calm; 10 being max anxious)
> ________ (Asking for no particular reason…. looks around all shifty eyes)."

**The escalating mad-scientist premise** [Halloween exam, drugged candy, IRB nonexistent]:
> "A statistics professor... does not bother with all those pesky institutional review board
> (IRB) rules, passes out candy to the students during their Halloween exams... he confused
> microliters with milliliters giving the ketamine group 1000 times the dosage he planned
> (whoops)... students reporting the equations came to life and turned into cute fuzzy
> animals jumping all over the page."

**The two-register comprehension check** [required on every results-interpretation
question — this is a format, not a one-off joke]:
> "Explain the results of this experiment in your own words as if you were talking to
> grandma... Explain the results scientifically."

**Visceral stakes for an abstract error type** [turning Type I error from an abstraction
into a felt consequence]:
> "Imagine that the courts were replaced with the polygraph machine and those found guilty
> were dealt with 'Judge Dredd style.' What would the 'type I error rate' be of the
> polygraph machine?"

**The self-deprecating local dig** [Alex mocks his own city as readily as the rival one]:
> "A marketing researcher... selects 200 Chicagoan's who normally eat cheese casserole (AKA
> Chicago style 'pizza')."
> "...resulting in irritating the easily enraged locals."

**The absurd-but-quantifiable monster** [a zombie premise exists to hang a distribution on]:
> "he discovers they can only move at µ = 3 miles per hour, with a σ = .5. He wants a faster
> moving zombie in the population..."

**The physical threat, deployed as a complexity guardrail:**
> "Don't do 4 way interactions or I will beat you with a stick."
> "Don't make me get the bat." [Nerf bat, threatened, never used]

**The italic aphorism, closing a section** [Alex's own replacement for a balanced literary
sentence, Chapter 1]:
> "*The important truth is you will always be wrong. Your job is to be less wrong.*"

**Self-deprecation as structural justification** [why the book is organized this way]:
> "This book serves two groups cause I am lazy and tired."

**The heading tag:**
> "How to Read This Book Without Reading All of It, Cause Yuck"
> "Do Not Just Apply Statistics Like a Monkey Hoping to Type Hamlet Perfectly by Chance"

**The dangling factual provocation:**
> "Fish probably spend very little time defining water. **Also, did you know there are no
> such things as fish?**"
> "...forgetting is one of the brain's most important skills---look up the people who never
> forget; they are sad, sad people."

## 12. Banned by Alex

Things Alex cut from a draft. Do not reintroduce them without asking.

- **The chatbot warning in the R help section** (Chapter 2, cut 2026-08-12). The model had
  written: "Asking R beats guessing, and it beats trusting whatever a chatbot confidently
  invented about a function that does not exist." Alex deleted it along with the Help-pane
  search-box sentence. Reason not stated — most likely length, possibly preachiness. The
  broader "distrust unverified automation" throughline is still live elsewhere in the book
  (§3), so this is a ban on *that sentence in that spot*, not on the idea.

## 13. Deliberate "errors" — do not correct these

Some things that look like grammar mistakes are jokes, and several of them are callbacks to
things Alex said in lecture. **A model reading only the page cannot tell the difference.**
This section exists because a model kept fixing them.

- **"more better"** (Chapter 8, restored 2026-08-14). "Neither shape is 'more better' than
  the other." The double comparative is a running joke from an earlier lecture. A model
  "corrected" it to "is better" during a grammar pass and Alex put it back. It now carries
  quotation marks to mark it as deliberate. Do not touch it.

**The general rule this teaches.** §5 already says not to correct Alex's casual register into
formality ("cause I am lazy and tired"), and this is the same rule with a sharper edge: the
non-standard construction may be a *callback to a lecture you have never heard*, so the joke
is invisible from the text alone. When a grammar pass turns up something that is both
technically wrong and slightly funny, that combination is the warning sign. Flag it in the
summary and let Alex rule on it. Do not silently fix it.

Genuine slips still get fixed, and there are plenty of them: "Have you notice," "paid me
visit," "charges you benefit," "your will do in lab." The distinguishing question is whether
the error is *doing* something. "more better" is doing something. "paid me visit" is not.
