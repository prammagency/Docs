# Production Pipeline — Generating & Driving the Scroll/3D Effect

> Companion to `zinzino-omega3-website-blueprint.md`. This covers **how** to
> build the scroll-driven 3D effect using AI image + video generation
> (Higgsfield / Replicate) and how to wire it to scroll in the browser.

---

## 0. The one decision that matters

There are three ways to build this. Pick the right one up front:

| Approach | What it is | Verdict |
|---|---|---|
| **A. Live AI transitions** | Ask Higgsfield/Replicate to morph between images *in the browser at runtime* | ❌ Don't. Too slow, costs per view, non-deterministic, can't scrub. |
| **B. Real-time 3D (Three.js/R3F)** | Model the tree/olive/fish as real 3D geometry | ✅ Most flexible, but heavy to build/model. Overkill unless you want true interactivity. |
| **C. Pre-rendered video, scrubbed by scroll** | Generate ONE continuous cinematic clip with AI, then tie its playhead to the scrollbar | ✅✅ **This is the move.** It's exactly how Apple's AirPods Pro page works. |

**Go with C.** The "3D" is baked into a pre-rendered video (the camera physically
dollies through the olive, into the molecule, out to the bottle). Scroll doesn't
*generate* anything — it just **scrubs the playhead** of an already-rendered film.
Buttery, deterministic, cheap to serve, works offline.

So the whole job becomes: **produce one seamless ~30–60s master video, then
scrub it on scroll.**

---

## 1. The pipeline (end to end)

```
[1] Generate keyframe STILLS        → Replicate (Flux / Imagen / Nano-Banana)
        every scene start + end frame, consistent style, black bg
                │
[2] IMAGE-TO-VIDEO each segment     → Kling 3.0 / Veo / Wan (Replicate) OR Higgsfield
        feed START frame + END frame → model interpolates the camera move
                │
[3] STITCH segments into 1 master   → ffmpeg concat (end frame of A == start of B)
                │
[4] EXPORT to a scrubbable asset    → either:
        (a) numbered frame sequence (Apple method, best for mobile), or
        (b) a single optimized .mp4/.webm
                │
[5] DRIVE with scroll               → GSAP ScrollTrigger (scrub), native scroll
        text overlays as real DOM, synced to the same timeline
```

### Why generate START **and** END frames (the crux of "transition into them")
Every modern i2v model (Kling 3.0, Veo 3.1, Runway, Wan) accepts a **first
frame and a last frame** and interpolates the motion between them. This is how
you get *seamless* scene-to-scene transitions:

- Scene 1 end frame = "extreme close-up of olive skin, gold particles visible"
- Scene 2 start frame = **the exact same image**.

When you concat the clips, there's no visible cut — the camera appears to fly
continuously from tree → olive → molecule → bottle. **Always make the last
frame of clip N identical to the first frame of clip N+1.**

---

## 2. Tool split: Higgsfield vs Replicate

Use both, for what each is best at.

**Higgsfield — use for the camera-driven hero shots.**
- Best-in-class **camera-motion presets**: push-in, dolly, *crash zoom*,
  pull-out, orbit — one click, physically believable.
- **Cinema Studio** lets you pick a virtual camera body, lens, focal length and
  depth of field, and **stack multiple camera moves** in one shot.
- Gives access to Kling 3.0 / Veo / Sora under the hood.
- Best for: the tree push-in (Scene 0→1), the crash-zoom into the molecule
  (Scene 4), the pull-back to the bottle (Scene 5).

**Replicate — use for programmatic, batch, and exact frame control.**
- Run **Flux 1.1 Pro** (or Imagen / Nano-Banana / Recraft / SDXL) for the
  keyframe stills, with a **fixed seed + style reference** for consistency.
- Run **Kling / Wan / Veo** via API with explicit **start+end frame**
  conditioning — scriptable, reproducible, version-controllable.
- Best for: generating all keyframes in one style, and any shot where you need
  the precise end frame to match the next clip.

> Practical combo: **stills + exact transitions on Replicate (API, in your
> repo), hero camera moves in Higgsfield (manual, art-directed).** Export
> everything to a common 1920×1080 (or vertical for mobile) @ 24–30 fps.

---

## 3. Zoom effect vs scroll effect — what to actually do

You asked whether to do a zoom (site zooms into each section) or a scroll
(transition happens in the background as you scroll). **Do both at once, and
bake the zoom into the video — don't do it with CSS.**

- The **camera dolly/zoom is rendered into the clip** (real parallax, real
  depth, light reacting). The browser then just scrubs that footage to scroll.
  Result: scrolling *feels* like zooming, because the footage is a continuous
  push-in. This is the Apple effect and it's far more convincing than CSS
  `scale()` on a flat image (which looks like a cheap zoom on a photo).
- Keep **one continuous camera** through the whole film so there are no section
  "jumps" — the user is always flying through one space.
- Layer **pinning** on top: pin each text block while its segment of the video
  scrubs, then release. Native scroll drives it — **never scroll-jack** (don't
  hijack the wheel; let the OS scroll and just map progress).

---

## 4. Browser implementation (scrub on scroll)

**Recommended: image-sequence on `<canvas>` for the hero, GSAP ScrollTrigger.**
Video `currentTime` scrubbing is janky/unreliable on iOS Safari; a numbered
frame sequence drawn to canvas scrubs smoothly everywhere.

```js
// Extract frames from the master video first:
//   ffmpeg -i master.mp4 -vf fps=30 frames/%04d.jpg
// ~30–60s at 30fps is a lot of frames — see §5 for trimming.

const canvas = document.querySelector('#scene');
const ctx = canvas.getContext('2d');
const frameCount = 300;                 // total frames you exported
const images = [];
const state = { frame: 0 };

// preload (progressive: load every Nth first, then fill in)
for (let i = 1; i <= frameCount; i++) {
  const img = new Image();
  img.src = `frames/${String(i).padStart(4,'0')}.jpg`;
  images.push(img);
}

function render() {
  const img = images[state.frame];
  if (img?.complete) ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
}

gsap.to(state, {
  frame: frameCount - 1,
  snap: 'frame',
  ease: 'none',
  scrollTrigger: {
    trigger: '#scroll-track',   // a tall spacer element = total scroll length
    start: 'top top',
    end: 'bottom bottom',
    scrub: 1,                    // smoothing: playhead eases toward scrollbar
    pin: '#scene-wrapper',
  },
  onUpdate: render,
});

// Sync text beats to the SAME timeline by frame range:
ScrollTrigger.create({
  trigger: '#scroll-track',
  start: 'top top', end: 'bottom bottom', scrub: true,
  onUpdate: (self) => {
    const f = self.progress * frameCount;
    toggleBeat('beat-polyphenols', f > 40 && f < 90);   // Scene 1 window
    toggleBeat('beat-shield',      f > 180 && f < 230);  // Scene 4 window
    // ...
  }
});
```

**Single-video alternative** (lighter, fine for desktop / non-critical scenes):
```js
const v = document.querySelector('video');
v.pause();
gsap.to({}, {
  scrollTrigger: { trigger:'#track', start:'top top', end:'bottom bottom', scrub:1,
    onUpdate: self => { v.currentTime = self.progress * v.duration; }
});
// Encode for seeking: many keyframes — ffmpeg ... -g 1 -force_key_frames 'expr:gte(t,n_forced/30)'
```

---

## 5. Specs & performance (don't skip)

- **Master length:** aim 30–45s of footage total (≈6 segments × 5–7s). More =
  more frames = heavier.
- **Frame sequence size:** 300 frames @ ~1080p JPG ≈ a lot. Tactics:
  - Export at the *display* resolution, not 4K. Use **WebP/AVIF**, quality ~70.
  - **Two sequences**: low-res that loads instantly, swap to high-res when ready.
  - Mobile: fewer frames (e.g., 150) + smaller dimensions.
- **Source fps:** generate/render at 24–30 fps; ScrollTrigger `scrub` smoothing
  makes it feel 60fps.
- **Preload + progressive decode:** load every 5th frame first so the scrub
  works immediately, then backfill.
- **`prefers-reduced-motion`:** serve static hero stills + simple fades. Build
  this from day one — it's also your low-end-device fallback.
- **Mobile Safari:** prefer the canvas/frame-sequence path; video seeking
  stutters there.
- **SEO/accessibility:** keep all headlines as real DOM text over the canvas,
  not baked into the video.

---

## 6. The prompts (per scene)

For each scene you need a **keyframe still prompt** (Replicate image model) and a
**motion prompt** (i2v / Higgsfield). Global style block — prepend to every
still prompt for consistency:

> *Cinematic product film still, pure black background (#000000), volumetric
> light, shallow depth of field, hyper-real macro detail, gold and deep-green
> palette, premium minimalist, photoreal, 8k, no text.* — fixed seed, same
> reference image across all stills.

### Scene 0→1 — Tree → into the olive
- **Still A (start):** *A single olive tree, isolated on pure black, soft top
  light, fine dust particles catching light, gentle volumetric glow, wide shot.*
- **Still B (end):** *Extreme macro of one ripe green Picual olive on black,
  skin translucent, tiny suspended golden particles glowing faintly inside the
  flesh.*
- **Motion (Higgsfield/Kling, start+end frame):** *Slow continuous dolly push-in
  from the wide tree toward a single olive until it fills frame; smooth
  acceleration, no cuts, camera flies into the fruit. Subtle particle drift.*
  Higgsfield preset: **Dolly / Push-in.**

### Scene 1→2 — Olive squeezed, polyphenols flow
- **Still:** *Macro olive being cold-pressed, a stream of luminous golden-green
  oil flowing out, glowing gold polyphenol particles carried in the stream,
  black background.*
- **Motion:** *The olive gently compresses; golden oil and glowing gold
  particles pour downward and flow to the right of frame, fluid and viscous,
  light refracting through the oil.* Keep particles bright (they're the visual
  thread for Scene 4).

### Scene 2→3 — Oil stream into the sea, fish appear
- **Still:** *The golden oil stream descends into deep dark ocean water; a shoal
  of small silvery fish (sardine/anchovy) swimming in from the depths, god-rays
  of light from above, black-blue water.*
- **Motion:** *Camera follows the stream down into dark water; a silver shoal
  swims into frame and the camera tracks one fish; volumetric light shafts,
  particles, slow graceful motion.* Higgsfield preset: **Follow / Tracking.**

### Scene 3→4 — Into the fish, the oxidation shield (the money shot)
- **Still A:** *Macro dive toward a single fish, then abstract: one glowing
  omega-3 molecule suspended in dark fluid, two molecules side by side.*
- **Still B:** *Left molecule dim, browning, cracking apart (oxidizing); right
  molecule wrapped in a glowing gold polyphenol shield, bright and intact,
  docking into a luminous cell-membrane lipid bilayer.*
- **Motion:** *Crash-zoom into the fish, then macro: left omega-3 molecule
  oxidizes — dims, browns, fractures; right molecule is enveloped by inflowing
  gold particles forming a protective glowing shell, then travels and locks
  into a glowing cell membrane.* Higgsfield preset: **Crash Zoom → slow macro.**
  This is the emotional peak — give it the most render time.

### Scene 4→5 — Convergence into the bottle
- **Still:** *A golden olive-oil stream and a silver omega-3 stream spiral
  together and pour down into a Zinzino BalanceOil+ glass bottle on a black
  pedestal, soft rim light, liquid filling, label resolving.*
- **Motion:** *Camera pulls back from the cell; two streams (gold + silver)
  spiral and pour into the bottle which assembles and fills with oil; elegant
  rim-lit reveal, slow rotation.* Higgsfield preset: **Pull-out / Reveal.**

### Scene 5→6 — Settle on product
- **Still:** *Hero shot of the filled BalanceOil+ bottle, centered, black
  background, soft premium lighting, condensation/oil sheen, space around it
  for text.*
- **Motion:** *Motion calms to a slow, almost-static hover; faint light
  breathing.* This is where the flat proof UI (3:1, 120 days, benefit icons,
  CTA) fades in over the still.

---

## 7. Suggested build order

1. Lock the **6 keyframe stills** (Replicate, one style/seed) — these define the
   whole look before any video spend.
2. Make sure **each end frame == next start frame.**
3. Generate the **6 motion clips** (Higgsfield for camera shots, Kling/Wan on
   Replicate for exact-frame transitions).
4. **ffmpeg concat** → review the seamless master. Iterate clips, not stills.
5. Export frame sequence(s), wire **GSAP ScrollTrigger** scrub + pinned text.
6. Add **reduced-motion / mobile** fallbacks. Ship.

---

### Sources
- [Higgsfield camera controls (50+ cinematic presets)](https://higgsfield.ai/camera-controls)
- [Higgsfield image-to-video guide 2026](https://scribehow.com/page/How_to_Use_Higgsfield_for_Image-to-Video_Generation_in_2026__JDh1WehUTUWJ5J4P0OAcxA)
- [Best image-to-video models 2026 (Kling/Veo/Wan)](https://fal.ai/learn/tools/ai-image-to-video-generators)
- [GSAP ScrollTrigger docs](https://gsap.com/docs/v3/Plugins/ScrollTrigger/)
- [GSAP image-sequence scrub (Apple AirPods technique)](https://webflow.com/made-in-webflow/website/gsap-video-animation-on-scroll)
- [Building a 3D scroll animation with GSAP + AI video](https://www.builder.io/blog/3d-gsap)
