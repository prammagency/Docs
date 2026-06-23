# Zinzino BalanceOil+ — Design System & UX Spec

> The single source of truth for how this site looks, feels, moves, and reads.
> Everything a designer or developer needs to build it correctly, with no guesswork.
> The companion production file (`zinzino-omega3-production-pipeline.md`) covers
> the video generation pipeline. This file covers everything that lives on top.

---

## 1. Creative Direction

**North star:** *Nature's precision, rendered cinematic.*

We are not building a supplement website. We are building a film about what happens
inside your body — and then letting people buy the thing that changes it. The design
must never feel like wellness marketing. It should feel like a Nature documentary
directed by Apple.

**Three reference points:**
- **Apple AirPods Pro page** — the scroll mechanic and typographic restraint
- **Loro Piana / Bottega Veneta campaigns** — the confidence of extreme negative space
- **National Geographic cinematography** — the footage aesthetic; nature as subject, not prop

**What this means in practice:**
- Every element that isn't essential gets removed. Decoration is distrust.
- The film does the work. Typography supports; it never competes.
- One accent colour carries all meaning. White is structural. Black is the world.
- Numbers and facts convince more than claims. Give them room.
- The scroll should feel like flying, not like clicking through slides.

**Tone:** scientific confidence. Not clinical, not woo. The copy says "proven in your blood"
— the design should feel the same way. Earned. Precise. Calm.

---

## 2. Colour System

```
#000000   Background — pure black. Not #0a0a0a. Actual black.
#C8A96E   Gold — the polyphenol / accent colour. The visual thread.
#FFFFFF   Text primary
rgba(255,255,255,0.55)   Text secondary / supporting lines
#A8B8C8   Silver-blue — the omega-3 / fish visual register
#3D9B7A   Bioluminescent teal — cell membrane scene only
#2D4A2B   Deep olive — nature/tree moments, used sparingly
```

**The gold (#C8A96E) is the single most important design decision.**
It is born inside the olive (Scene 1), reappears to shield the omega-3 molecule
(Scene 4), fills the bottle (Scene 5), and becomes the CTA button (Scene 6).
That thread is the design. Never use it arbitrarily — every time it appears,
it should carry the meaning: *protection, life, the thing that makes this work.*

Warm enough to feel natural and organic. Cool enough to feel premium. Not butter,
not honey, not mustard. This specific value.

**Colour budget:** black, white, gold. Two accent notes (silver-blue, teal) appear
only in their specific scenes. The closing UI section (Scene 6) uses only black,
white, and gold.

---

## 3. Typography

### Typefaces
```
Display / Headline:   Cormorant Garamond
Body / Supporting:    DM Sans
Monospace / Spec:     DM Mono (or system monospace)
```

**Why Cormorant Garamond:**
High-contrast hairline-to-stroke ratio mirrors the visual world of the film — pure
black, blazing gold, delicate detail. Its italic is extraordinarily graceful. At
large display sizes it reads as "science and nature," never as "supplement brand."
Free on Google Fonts.

**Why DM Sans:**
Geometric, neutral, does not compete. Legible at 12px (spec strip, trust row).
Its geometric structure subtly echoes scientific precision. Pairs with Cormorant
without fighting it.

### Type Scale
```
Hero headline (Scene 0):     72px / 4.5rem   Cormorant Garamond Regular
Scene headline:              56px / 3.5rem   Cormorant Garamond Regular
Scene sub-headline:          22px / 1.375rem  DM Sans Light, tracking +0.02em
Supporting / body line:      18px / 1.125rem  DM Sans Light
Spec strip (EPA/DHA):        13px / 0.8125rem DM Mono, tracking +0.12em, uppercase
Proof numbers (Scene 6):    120px / 7.5rem   Cormorant Garamond SemiBold
Benefit label:               14px / 0.875rem  DM Sans Regular
Trust row:                   12px / 0.75rem   DM Sans Regular, #ffffff at 40% opacity
CTA button:                  16px / 1rem      DM Sans Medium, tracking +0.04em
```

### Line length
All scene text: **max-width 560px**, centered. Never let a headline stretch full-screen
— the black space on either side is doing work.

### Hierarchy rule
One headline. One supporting line. That is a scene. If you find yourself writing
three lines of body copy under a headline, you have too much — cut to the one
sentence that could not be removed.

---

## 4. Motion & Interaction Design

### The fundamental principle
**Scroll is the only input.** There are no hover states on the canvas, no click-to-play,
no auto-advancing carousels. The user's scroll wheel is the director's cut knob.
Going up should rewind as elegantly as going forward plays.

### Scroll architecture
```
Total scroll distance:   ~700vh (7 viewport heights)
Per scene:               ~100vh
Canvas:                  pinned full-screen for the full 700vh
Text blocks:             each pinned for their scene's 100vh window
Scene 6 (closing):       releases the pin; normal document flow resumes
```

The ~100vh per scene is not rigid — give the opening tree (Scene 0) 120vh
(a slow, building reveal) and the spec-strip beat inside Scene 3 only 60vh
(it's a small data moment, not a full beat).

### Video scrub
```
GSAP ScrollTrigger scrub: 1.5   (smoothing — playhead eases toward scroll)
ease on scrub:            "none"   (scroll IS the easing; don't double-ease)
```

A scrub value of 1.5 means the playhead takes 1.5 seconds to catch up to the
scroll position. This gives the impression of filmic momentum — the camera
appears to have weight.

### Text animation
```
Fade in:   0.7s, ease: power2.out, translateY(24px → 0px), opacity(0 → 1)
Fade out:  0.4s, ease: power2.in,  translateY(0px → -12px), opacity(1 → 0)
```

The entry travels *up* into position (suggests arrival, depth). The exit travels
*further up* and out (suggests continuity upward — the camera is flying forward).

**Never bounce or spring the text.** The film has all the kinetic energy. Typography
enters and exits like a breath.

Text fade-in starts when the scene is 15% into view; starts fading out at 80%.
This creates a clean 65% window where the text is fully visible and unmoving —
enough time to be read at scroll speed without hunting.

### Scene 6 — proof numbers (the exception)
Once the film settles, the UI is the show. The numbers earn more drama:
```
"3:1" count-up:        1.4s, ease: expo.out (from 6:1 → 3:1)
"120" count-up:        1.2s, ease: expo.out (from 0 → 120)
Benefit icons:         stagger 0.12s, scale(0.7 → 1) + opacity(0 → 1), ease: back.out(1.4)
Trust row:             0.6s delay after icons, opacity(0 → 1), no transform
CTA button:            0.8s delay, opacity(0 → 1) + subtle scale(0.96 → 1)
```

The CTA is the last thing to arrive. It should feel like a conclusion, not a demand.

---

## 5. Layout — Scene by Scene

### How to read this section
Each scene specifies: where text sits, what's on screen, and the exact copy.
Video is always full-bleed, full-screen behind everything.

---

### Scene 0 — Hero: The Olive Tree
```
Film:     Wide olive tree, black background, ambient particle dust
Duration: ~120vh of scroll

Text position:  Centered, vertically centered, ~45% from top
─────────────────────────────────────────────────
Balance, by nature.
[72px Cormorant Regular — White]

Fresh omega-3, protected by the olive.
Proven in your blood in 120 days.
[18px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Scroll cue:     Fine downward chevron, 24px, White 30%, bottom-center
                Pulses gently (opacity 1→0.3→1, 2s loop) then fades out
                on first scroll.

Sticky nav:     Zinzino wordmark — White, top-left, 16px DM Sans Regular
                "Get BalanceOil+" — Gold, top-right, 14px DM Sans Medium
                Both at 0% opacity on Scene 0. Fade to 100% from Scene 3 onwards.
                Never add a hamburger menu or navigation links — just these two.
```

---

### Scene 1 — Into the Olive / Polyphenols
```
Film:     Dolly push-in into single olive; gold particles appear inside flesh
Duration: ~100vh

Text appears in two beats as scroll progresses:

Beat A (first 50vh):
─────────────────────────────────────────────────
This little fruit is a bodyguard.
[56px Cormorant Regular — White]
─────────────────────────────────────────────────

Beat B (second 50vh):
─────────────────────────────────────────────────
Polyphenols above 750 mg/kg.
[56px Cormorant Regular — Gold #C8A96E]

Powerful antioxidants that protect
blood lipids from oxidative stress.
[18px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Molecule callout labels (appear as gold particles become visible):
  "Hydroxytyrosol"  — 11px DM Mono, Gold, with a 1px Gold line to nearest particle
  "Oleuropein"      — same
  (Max 2 labels — do not list all 5 polyphenols here)
  Labels fade in with a 0.3s delay after the headline; positioned wherever the
  gold particles appear in the actual frame (adjust after video is locked).
```

---

### Scene 2 — The Squeeze / Oil Flows
```
Film:     Olive compresses, luminous golden-green oil + gold particles pour out
Duration: ~90vh

─────────────────────────────────────────────────
Pressed, never heated.
[56px Cormorant Regular — White]

Extra-virgin olive oil. Omega-9 and the
antioxidants that keep everything else alive.
[18px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Text position: Lower-left of frame (oil flows right; text stays left)
This is the only scene where text is not centered.
Left edge at 8% of viewport width. This creates dynamic asymmetry as the
gold stream flows across the right side of the frame.
```

---

### Scene 3 — The Fish / Omega-3
```
Film:     Oil stream into dark sea; silver shoal; camera tracks one fish
Duration: ~110vh (three beats)

Beat A:
─────────────────────────────────────────────────
Omega-3 starts in the sea.
[56px Cormorant Regular — White]
─────────────────────────────────────────────────

Beat B:
─────────────────────────────────────────────────
Wild-caught sardines, mackerel & anchovies.
6,600 mg. A 20:10 EPA:DHA ratio,
in natural triglyceride form.
[22px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Beat C (spec strip — small, fades below):
─────────────────────────────────────────────────
EPA 1300mg  ·  DHA 700mg  ·  DPA 150mg  /  12ml
[13px DM Mono — White 40% — tracking +0.12em]
─────────────────────────────────────────────────

Text position: Lower-center (fish swim mid-to-upper frame)
The spec strip sits 72px below the body text; it's data, not a headline.
```

---

### Scene 4 — The Oxidation Shield (the money shot)
```
Film:     Macro: two molecules side by side — left dims/fractures, right
          enveloped in gold shield → docks into glowing cell membrane
Duration: ~110vh (three beats — this scene earns the most scroll time)

Beat A:
─────────────────────────────────────────────────
Omega-3 oxidizes the moment it leaves the sea.
[56px Cormorant Regular — White]
─────────────────────────────────────────────────

Beat B (when left molecule is visibly degrading):
─────────────────────────────────────────────────
Most refining strips the very thing that protects it.
[22px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Beat C (when right molecule is shielded and docking):
─────────────────────────────────────────────────
We put them back.
[56px Cormorant Regular — Gold #C8A96E]

Polyphenols shield the omega-3 —
all the way into your cells.
[18px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Text position: Upper-center (molecules are in lower half of frame)
Beat C uses gold for the headline — the only scene where gold is used for
a major headline. It earns it: this is the product's entire reason for existing.
```

---

### Scene 5 — Convergence: Into the Bottle
```
Film:     Gold stream + silver stream spiral and pour into the BalanceOil+ bottle
Duration: ~90vh

─────────────────────────────────────────────────
Fish oil + olive oil = results.
[56px Cormorant Regular — White]

60% wild fish oil · 40% extra-virgin olive oil
Vitamin D3. Nothing artificial.
[18px DM Sans Light — White 55%]
─────────────────────────────────────────────────

Text position: Left-center (bottle is center-to-right of frame)
As the film plays, the bottle label should be either composited with the real
product photo, or left plain — do not let the AI render a fake label.
```

---

### Scene 6 — Proof & Closing (static UI, no film scrubbing)
```
Film:     Settled. Bottle holds center-left, slow breathing light. This is the
          only section where the video is not scrubbing — it rests.
          Pin releases here; normal page scroll resumes.

Layout (desktop): Two-column
  Left 45%:   Bottle (from the film, now static, with real product photo composited)
  Right 55%:  The proof UI stack (below)

Layout (mobile):  Single column, bottle image above, proof stack below
```

**Proof UI Stack (right column on desktop, below bottle on mobile):**
```
┌─────────────────────────────────────────────────┐
│                                                 │
│   3:1                                           │
│   [120px Cormorant SemiBold — Gold]             │
│                                                 │
│   The balance your body was built for.          │
│   [22px DM Sans Light — White]                  │
│                                                 │
│   Omega-6:3 ratio. Proven in your blood         │
│   in 120 days with the BalanceTest.             │
│   [16px DM Sans Light — White 55%]              │
│                                                 │
│   ─── ─── ─── ───                              │
│   [1px Gold divider, 48px wide]                 │
│                                                 │
│   [Heart]  [Brain]  [Eye]  [Shield]             │
│   Heart    Brain    Vision  Immunity            │
│   [Icons: 32px, Gold stroke; Labels: 12px       │
│    DM Sans Regular, White 55%]                  │
│                                                 │
│   ─── ─── ─── ───                              │
│                                                 │
│   ✓ Friend of the Sea  ✓ Third-party tested     │
│   ✓ No artificial additives  ✓ Home BalanceTest │
│   [12px DM Sans — White 35%]                    │
│                                                 │
│   [  Start your balance  ]                      │
│   [Gold bg, Black text, 16px DM Sans Medium,   │
│    56px height, 32px horizontal padding,        │
│    no border-radius OR 4px — never pill shape] │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Button behaviour:**
No hover animation that feels playful. On hover: Gold darkens slightly (#B8996A),
0.2s ease. On click: brief scale(0.97) then normal. That's it.

**Footer (below the proof section):**
```
Background: #000 (continuous with the page)
Two columns:
  Left: Zinzino logo wordmark + tagline (1 line)
  Right: Fine print — health claim disclaimers, EU regulation references, 
         ingredients list, certifications — all at 11px DM Sans, White 25%

Collapsed by default behind a "Full details +" text link in Gold.
This is where the regulatory fine print lives. It does not belong on the journey.
```

---

## 6. Navigation & Page Chrome

**Sticky nav:** top-left wordmark + top-right "Get BalanceOil+" only.
- Transparent background at all times (the video is the background)
- Appears at 0% opacity during Scene 0 (hero); fades to 100% from Scene 3 onward
- "Get BalanceOil+" in Gold — it's a nav link, not a button (no border)
- On mobile: wordmark left only; no link until Scene 6 (the film is too narrow for both)

**Custom cursor (desktop only):**
- Replace the default cursor with a small (8px) Gold dot
- It has a subtle trailing echo (a second, slightly larger dot at 40% opacity, 80ms delay)
- On hover over the CTA: cursor expands to 20px, transition 0.2s
- This detail alone elevates the feel from "website" to "experience"

**Scroll progress indicator:**
- A 1px vertical line, left edge of the viewport, 20px from left, 60vh tall
- Colour: White 15% (the unfilled track)
- The filled portion is Gold and grows with scroll progress
- Fades out at Scene 6 (the scrolling experience is over)
- Mobile: omit

---

## 7. Loading State

The site preloads the frame sequence before the user can scroll. Show:
```
Black screen (full page) with:
- Zinzino wordmark, centered, White
- Fine Gold horizontal line below the wordmark, 120px wide
  → This line is the progress indicator: it grows from 0 → 120px as frames load
- No spinner, no percentage text, no animation beyond the line growing
- When load completes: wordmark + line fade out together (0.6s), then the hero scene fades in
```

The loading experience should feel like the film is being threaded into the projector.

---

## 8. Mobile Design

- Video: 16:9 footage, center-cropped to portrait. Keep all key subjects centered in
  stills so the crop lands correctly.
- Text: same scale hierarchy but all type slightly reduced (hero: 40px, scene: 36px).
  Max-width 90vw on all text blocks.
- Scene 4 (molecule): text goes bottom-center; on mobile portrait, the two molecules
  are stacked vertically, so text must not cover them.
- Scene 6: single column. Bottle image (composited) top-half, proof stack below.
- Scroll distance: ~500vh (shorter than desktop — mobile scrolling is faster).
- Frame sequence: load every other frame (half the frames) to keep load time
  acceptable; the scrub smoothing hides the halved rate.
- Omit: custom cursor, scroll progress line, molecule callout labels.

---

## 9. Accessibility

- **`prefers-reduced-motion`:** serve the site as 7 static full-bleed stills (one per
  scene) with text visible on each, and simple scroll-triggered opacity fades between
  them. No scrubbing, no frame sequence. Build this as an alternate CSS class on
  `<body>` so it's a real, maintained path, not an afterthought.
- **Text contrast:** all text on the video is white or gold against the black
  background. In practice the video may introduce a lighter area — add a very subtle
  radial gradient overlay (black, 0% center → 35% edge, behind the text) to guarantee
  legibility without killing the film.
- **Real DOM text:** every headline, supporting line, spec, and CTA is real HTML text
  over the canvas — never baked into the video. This is non-negotiable for screen
  readers and SEO.
- **Alt text on stills:** the 8 keyframe stills (used in the reduced-motion path)
  each need descriptive alt text.

---

## 10. Design Decisions That Must Not Change

These are fixed. They're the things that make the site what it is:

1. **Pure black (#000000) background.** Not dark grey, not near-black. Absolute black.
2. **One accent colour.** Gold. Nothing else is coloured.
3. **The gold is the visual thread** that runs tree → olive → polyphenols → shield →
   bottle → CTA. Do not add gold highlights to any element that isn't part of this thread.
4. **One headline per scene beat.** Not two. One.
5. **No hero image.** The film IS the hero. Do not add a static hero section before the scroll.
6. **No gradient backgrounds, cards, or boxes** behind text. Text floats on black/film.
7. **The CTA button is not pill-shaped.** It has either zero or a 4px border-radius.
   Pill buttons belong to a different aesthetic register.
8. **The closing scene is not a popup or modal.** It's a section. Users scroll into it.
