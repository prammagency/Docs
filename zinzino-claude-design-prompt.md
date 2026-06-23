# Claude Design Prompt — Zinzino BalanceOil+ Website

> Paste everything between the triple-dashes into claude.ai/design.
> This is a self-contained brief — the agent needs nothing else.

---

```
Build me a scroll-driven cinematic product website for Zinzino BalanceOil+,
a premium omega-3 supplement. The site works like Apple's AirPods Pro scroll
page — the background is a full-screen cinematic film that the user scrubs by
scrolling. Text overlays fade in and out at the right moments. Pure black
background throughout.

For now, use a black full-screen canvas as a placeholder where the real AI
video will go. Use a subtle animated gradient or particle effect on the canvas
to stand in for the film (just so the text has a visual context to sit against).

Here is the full design spec. Build it all in one pass.

────────────────────────────────────────
VISUAL SYSTEM
────────────────────────────────────────

Background: #000000 (pure black, nothing else)
Gold accent: #C8A96E
Text primary: #FFFFFF
Text secondary: rgba(255,255,255,0.55)
Silver-blue (omega scene only): #A8B8C8

Typefaces:
  Headlines: Cormorant Garamond (Google Fonts) — Regular and SemiBold
  Body: DM Sans (Google Fonts) — Light and Medium
  Spec/mono: DM Mono — Regular
  Import both from Google Fonts in the code.

Type scale:
  Hero headline: 72px Cormorant Regular
  Scene headline: 56px Cormorant Regular
  Supporting line: 18px DM Sans Light
  Spec strip: 13px DM Mono, letter-spacing 0.12em, uppercase
  Proof number (closing section): 120px Cormorant SemiBold
  CTA button: 16px DM Sans Medium, letter-spacing 0.04em

────────────────────────────────────────
SCROLL ARCHITECTURE
────────────────────────────────────────

Total scroll height: 700vh
The video canvas is position:fixed, full-screen, behind everything.
A tall scroll track element (700vh) sits in normal flow and creates the scroll space.
Text blocks are position:fixed and swap in/out via scroll-triggered opacity changes.
At scene 7 (the closing section), the fixed canvas stays but normal page flow 
resumes and the UI section scrolls over it.

Use GSAP + ScrollTrigger for all scroll animation.
Install via CDN: https://cdn.jsdelivr.net/npm/gsap@3/dist/gsap.min.js
and: https://cdn.jsdelivr.net/npm/gsap@3/dist/ScrollTrigger.min.js

Each text block has this entry/exit:
  Enter: opacity 0→1, translateY 24px→0, duration 0.7s, ease: power2.out
  Exit:  opacity 1→0, translateY 0→-12px, duration 0.4s, ease: power2.in
  Text is fully visible between 15% and 80% of its scene's scroll window.

────────────────────────────────────────
SCENE 0 — HERO (0–120vh)
────────────────────────────────────────

Canvas: Black with very slow drifting gold/white dust particles (stand-in for olive tree footage)

Text — centered horizontally and vertically:
  "Balance, by nature."
  [72px Cormorant Regular, White]

  "Fresh omega-3, protected by the olive."
  "Proven in your blood in 120 days."
  [18px DM Sans Light, White 55%, margin-top 24px]

Scroll cue: A thin downward chevron icon, 24px, White 30%, bottom-center of viewport.
  Gentle pulse animation (opacity 1→0.3, 2s infinite). Fades out on first scroll.

────────────────────────────────────────
SCENE 1 — INTO THE OLIVE (120–220vh)
────────────────────────────────────────

Canvas: Background shifts slightly warmer (olive green tint to the particles)

Two beats:

Beat A (120–170vh):
  "This little fruit is a bodyguard."
  [56px Cormorant Regular, White, centered]

Beat B (170–220vh):
  "Polyphenols above 750 mg/kg."
  [56px Cormorant Regular, Gold #C8A96E, centered]

  "Powerful antioxidants that protect blood lipids from oxidative stress."
  [18px DM Sans Light, White 55%, centered, max-width 520px, margin-top 16px]

────────────────────────────────────────
SCENE 2 — THE SQUEEZE (220–310vh)
────────────────────────────────────────

Canvas: Gold-tinted particle stream flowing to the right

Text — positioned left-aligned, left: 8vw, vertically centered:
  "Pressed, never heated."
  [56px Cormorant Regular, White]

  "Extra-virgin olive oil. Omega-9 and the"
  "antioxidants that keep everything else alive."
  [18px DM Sans Light, White 55%, margin-top 16px]

────────────────────────────────────────
SCENE 3 — THE FISH / OMEGA-3 (310–420vh)
────────────────────────────────────────

Canvas: Deep dark blue-black background, silver particles drifting (stand-in for fish footage)

Three beats:

Beat A (310–360vh):
  "Omega-3 starts in the sea."
  [56px Cormorant Regular, White, centered]

Beat B (360–400vh):
  "Wild-caught sardines, mackerel & anchovies."
  "6,600 mg. A 20:10 EPA:DHA ratio, in natural triglyceride form."
  [22px DM Sans Light, White 55%, centered, max-width 560px]

Beat C (400–420vh) — spec strip:
  "EPA 1300mg  ·  DHA 700mg  ·  DPA 150mg  /  12ml"
  [13px DM Mono, White 40%, letter-spacing 0.12em, uppercase, centered]

────────────────────────────────────────
SCENE 4 — THE OXIDATION SHIELD (420–530vh)
────────────────────────────────────────

Canvas: Dark fluid background, two glowing orbs side by side:
  Left orb: starts bright, gradually dims, turns grey/brown (CSS animation)
  Right orb: enveloped in a pulsing gold halo (CSS animation)
  The gold halo on the right orb is the most important visual on this placeholder.

Three beats:

Beat A (420–460vh):
  "Omega-3 oxidizes the moment it leaves the sea."
  [56px Cormorant Regular, White, centered]

Beat B (460–490vh):
  "Most refining strips the very thing that protects it."
  [22px DM Sans Light, White 55%, centered, max-width 520px]

Beat C (490–530vh) — the payoff:
  "We put them back."
  [56px Cormorant Regular, GOLD #C8A96E, centered]
  — this is the only scene where a major headline is in gold —

  "Polyphenols shield the omega-3 — all the way into your cells."
  [18px DM Sans Light, White 55%, centered, max-width 480px, margin-top 16px]

────────────────────────────────────────
SCENE 5 — INTO THE BOTTLE (530–620vh)
────────────────────────────────────────

Canvas: Gold and silver particle streams spiralling together (two distinct streams converging)
  Show a simple bottle silhouette outline at the bottom, gold particles filling it

Text — left-aligned, left: 8vw, vertically centered:
  "Fish oil + olive oil = results."
  [56px Cormorant Regular, White]

  "60% wild fish oil · 40% extra-virgin olive oil"
  "Vitamin D3. Nothing artificial."
  [18px DM Sans Light, White 55%, margin-top 16px]

────────────────────────────────────────
SCENE 6 — PROOF & CLOSE (620–700vh, then static)
────────────────────────────────────────

At 620vh the canvas stops scrubbing and the closing section fades in over it.
This is built as a normal flexbox section in document flow — not fixed position.
Background: black, same as canvas (seamless transition).

Desktop layout: two columns, 50/50, vertically centered, min-height 100vh, padding 80px
Mobile layout: single column, padding 40px 24px

LEFT COLUMN (desktop) / TOP (mobile):
  A centered product image placeholder:
    Rectangle 280px × 420px (desktop), 180px × 280px (mobile)
    Background: rgba(200, 169, 110, 0.08)
    Border: 1px solid rgba(200, 169, 110, 0.25)
    Centered text inside: "BalanceOil+" in Cormorant Italic 20px Gold
    (The real product photo is composited here in the final build)

RIGHT COLUMN (desktop) / BOTTOM (mobile):

  ── Proof number ──
  "3:1"
  [120px Cormorant SemiBold, Gold #C8A96E, line-height 1]
  Add a count-up animation from 6 to 3 over 1.4s when this section scrolls into view.

  "The balance your body was built for."
  [22px DM Sans Light, White, margin-top 16px]

  "Omega-6:3 ratio. Proven in your blood"
  "in 120 days with the BalanceTest."
  [16px DM Sans Light, White 55%, margin-top 12px]

  ── Divider ──
  A 1px horizontal rule, 48px wide, Gold #C8A96E, margin: 32px 0

  ── 4 benefit icons ──
  Horizontal row, 48px gaps (desktop), 2x2 grid (mobile)
  Each icon: SVG line-art icon (32px), Gold stroke, label below in 12px DM Sans White 55%

  Icon 1: Heart outline → label "Heart"
  Icon 2: Brain outline → label "Brain"
  Icon 3: Eye outline → label "Vision"
  Icon 4: Shield outline → label "Immunity"

  Stagger their entrance: each delays 0.12s after the previous one.

  ── Trust row ──
  "✓ Friend of the Sea  ✓ Third-party tested  ✓ No artificial additives  ✓ Home BalanceTest"
  [12px DM Sans, White 35%, margin-top 24px, single line desktop, wrapping mobile]

  ── CTA button ──
  "Start your balance"
  Background: #C8A96E, Color: #000000, no border
  Height: 56px, padding: 0 40px
  Font: 16px DM Sans Medium, letter-spacing 0.04em
  Border-radius: 4px (not pill-shaped)
  Hover: background #B8996A, transition 0.2s
  Margin-top: 40px

────────────────────────────────────────
FOOTER
────────────────────────────────────────

Below Scene 6, same black background.
Padding: 48px.

Left: "Zinzino" wordmark in 14px DM Sans Regular White.
      Tagline: "Scientifically proven omega balance." 12px White 40% below.

Right: "+ Full product details & regulatory information" 
       Link in Gold 12px. On click, expands a block of fine print text
       (use dummy lorem text for placeholder).

All fine print: 11px DM Sans, White 25%.

────────────────────────────────────────
STICKY NAV
────────────────────────────────────────

Fixed top of page, full width, transparent background (no blur, no backdrop).
Left: "Zinzino" — 16px DM Sans Regular, White
Right: "Get BalanceOil+" — 14px DM Sans Medium, Gold, no underline

Opacity: 0 on page load. Fades to 1 after user has scrolled past 300vh.
Transition: opacity 0.4s ease.

────────────────────────────────────────
CUSTOM CURSOR (desktop only)
────────────────────────────────────────

Hide default cursor on the main canvas area.
Show a custom 8px × 8px circle, Gold #C8A96E, border-radius 50%, position:fixed,
pointer-events:none, z-index 9999.
It follows the mouse with a small lag (lerp towards mouse position, factor 0.15 per frame).
A second "echo" circle: 20px, same gold at 25% opacity, slower lag (factor 0.08).
On hover over the CTA button: primary circle scales to 20px, transition 0.2s.

────────────────────────────────────────
SCROLL PROGRESS BAR
────────────────────────────────────────

A 1px vertical line on the left edge of the viewport.
Position: fixed, left 24px, top 20vh, height 60vh.
Track colour: White 12%.
Fill colour: Gold #C8A96E.
The fill grows from 0% to 100% as scroll goes from 0 to 620vh.
Fades out when the closing section is reached.
Desktop only — hide on mobile.

────────────────────────────────────────
PREFERS-REDUCED-MOTION
────────────────────────────────────────

@media (prefers-reduced-motion: reduce):
  Disable all scroll scrubbing and text animation.
  Show the 7 scene text blocks as static sections, each 100vh, 
  with the relevant canvas background visible (static, not animated).
  Simple opacity fade between sections on scroll instead of position-scrubbing.

────────────────────────────────────────
WHAT TO BUILD FIRST
────────────────────────────────────────

Build the full page in this order:
1. The scroll architecture (the fixed canvas + 700vh scroll track)
2. Scene 0–5 text overlays with working scroll-triggered entrance/exit
3. The two animated placeholder elements on the canvas (gold particles for oil,
   dark background + twin orbs for Scene 4)
4. The Scene 6 closing section UI (this is the most complex layout piece)
5. The sticky nav, custom cursor, and scroll progress bar
6. The footer

The real AI video (master.mp4) slots in to replace the canvas placeholder later —
that is the only change needed. Everything else — text positions, scroll windows,
the UI — is built to final spec now.

Make it pixel-perfect to the spec above. Do not add elements not listed here.
Do not use any colour other than the ones specified. The restraint IS the design.
```

---

## After pasting — what to tell it next

If the first output is missing something or needs adjustment, these follow-up
prompts will get you there fast:

**If the gold feels too bright/yellow:**
> "The gold (#C8A96E) feels too yellow. Make it slightly warmer and deeper —
> imagine the colour of premium cold-pressed olive oil in a dark glass bottle."

**If the typography doesn't feel premium enough:**
> "The Cormorant Garamond headlines need more letter-spacing — add tracking of
> 0.02em to all display headlines. They should feel like a luxury print ad."

**If the scroll feels jumpy rather than cinematic:**
> "Increase the GSAP scrub value to 2 on all ScrollTrigger instances. The
> playhead should feel like it has weight — it eases toward the scroll position
> rather than snapping to it."

**If it built the closing section wrong:**
> "The Scene 6 proof section needs to be rebuilt. The '3:1' number should be
> 120px in Gold, the 4 benefit icons in a horizontal row with SVG line-art,
> and the CTA button is Gold background with black text, 4px border-radius,
> not pill-shaped. No gradients anywhere."

**To add the real video once you have master.mp4:**
> "Replace the canvas placeholder with a full-screen HTML5 video element
> (autoplay, muted, playsinline, preload=auto). Remove any placeholder
> particle animations. Wire the video's currentTime to the GSAP scrub progress.
> Encode the video with frequent keyframes (ffmpeg -g 1) so seeking is smooth."
