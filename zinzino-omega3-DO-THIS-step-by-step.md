# 🛠️ DO THIS — Step-by-Step Build Guide (copy-paste ready)

> The simple, follow-along version. Everything you need to generate the visuals
> and build the scrolling olive-tree → bottle website. No jargon. Just do the
> steps in order and copy-paste the prompts.
>
> Companion docs (more detail if you want it): `zinzino-omega3-website-blueprint.md`
> (the story + text on screen) and `zinzino-omega3-production-pipeline.md`
> (the technical pipeline).

---

## What you need before you start
1. A **Replicate account** (replicate.com) — pay-as-you-go, no subscription.
2. One **real photo of the Zinzino BalanceOil+ bottle** (for the final shot — AI
   can't draw the real label correctly).
3. That's it. No Higgsfield, no photographer.

## The 3 models you'll use (all on Replicate)
- **FLUX.2** → makes the still pictures (the olive, oil, gold drops, molecule).
- **Imagen 4** → makes the two "must look like a real photo" stills (the tree, the fish).
- **Kling (latest Pro)** → turns each pair of pictures into a short moving clip.
  *(Backup: Veo 3.1, only if a Kling clip looks weak.)*

---

## ⭐ The golden rule that makes it all seamless
You will make **8 still pictures** (the key "moments"), then make **7 short
clips** that move from one picture to the next. The trick: **the picture a clip
ENDS on is the exact same picture the next clip STARTS on.** That's why the final
film feels like one continuous flight with no jumps.

```
Picture 1 ──clip 1──▶ Picture 2 ──clip 2──▶ Picture 3 ── ... ──▶ Picture 8
 (tree)               (olive)               (squeeze)            (bottle)
```

---

# STEP 1 — Make the 8 still pictures (FLUX.2 / Imagen 4)

**First, copy this STYLE LINE. Paste it at the START of every picture prompt
below** so all 8 share one look:

```
Cinematic product-film still, pure black background (#000000), volumetric light,
shallow depth of field, hyper-real macro detail, gold and deep-green palette,
premium and minimalist, photorealistic, 8k, no text, no words, no logo.
```

> Tip: on Replicate, set a **fixed seed** (any number, e.g. 12345) and keep it
> the same for all 8 so the style stays consistent. Generate a few, keep the best.

### Picture 1 — The olive tree  *(use Imagen 4)*
```
A single olive tree isolated on a pure black background, soft top light, fine
dust particles catching the light, gentle volumetric glow, wide cinematic shot,
calm and premium.
```

### Picture 2 — Extreme close-up of one olive  *(use FLUX.2)*
```
Extreme macro close-up of one ripe green Picual olive on a pure black background,
skin slightly translucent, tiny suspended golden particles glowing faintly inside
the flesh, dewy, hyper-real.
```

### Picture 3 — The olive pressed, oil flows  *(use FLUX.2)*
```
Macro shot of an olive being cold-pressed, a stream of luminous golden-green
olive oil flowing out, glowing gold polyphenol micro-particles carried inside the
stream, light refracting through the viscous oil, pure black background.
```

### Picture 4 — Oil stream meets the sea, fish appear  *(use Imagen 4)*
```
A golden-green oil stream descending into deep dark ocean water, a shoal of small
silver fish (sardines and anchovies) swimming in from the depths, god-rays of
light from above, dark blue-black water, cinematic.
```

### Picture 5 — Two omega-3 molecules in dark fluid  *(use FLUX.2)*
```
Abstract macro: two glowing omega-3 molecule structures suspended side by side in
dark fluid, the left one just beginning to dim and brown, the right one bright and
intact, soft particles, pure black background.
```

### Picture 6 — The shield + the cell  *(use FLUX.2)*
```
Abstract macro: the left omega-3 molecule cracked, browned and oxidized; the right
molecule wrapped in a glowing gold protective shield of polyphenols, bright and
intact, docking into a luminous glowing cell-membrane lipid bilayer, pure black
background.
```

### Picture 7 — Streams pour into the bottle  *(use FLUX.2, then composite real bottle)*
```
A golden olive-oil stream and a silver omega-3 stream spiralling together and
pouring down into a premium glass supplement bottle on a black pedestal, soft rim
light, oil filling the bottle, pure black background.
```
> ⚠️ Leave the **label blank/plain** in this picture. You'll drop your real
> bottle photo on top later (Step 5b).

### Picture 8 — Hero bottle, settled  *(use FLUX.2, then composite real bottle)*
```
Hero product shot of a filled premium glass supplement bottle, centered on a pure
black background, soft premium lighting, gentle oil sheen, generous empty space
around the bottle for text.
```

---

# STEP 2 — Quick check before animating
- You now have **8 pictures**. Look at them as a sequence — do they flow like a
  story (tree → olive → oil → sea → molecule → shield → bottle filling → bottle)?
- Re-generate any you're not happy with **now**, before spending on video.
- The look you lock here is the look of the whole site.

---

# STEP 3 — Turn each pair into a moving clip (Kling, latest Pro)

On Replicate, open the **Kling** model. For each clip:
1. Put the **first picture** in the `start_image` field.
2. Put the **next picture** in the `end_image` field.
3. Paste the matching **motion prompt** below.
4. Settings: **5 seconds**, **1080p**, and the **image-to-video (silent) tier**.

### Clip 1 — Tree ➜ Olive   (Picture 1 → 2)
```
Slow continuous dolly push-in from the wide olive tree toward a single olive until
it fills the frame, smooth gentle acceleration, no cuts, the camera flies into the
fruit, subtle dust particles drifting.
```

### Clip 2 — Olive ➜ Pressed   (Picture 2 → 3)
```
The olive gently compresses and is pressed; golden-green oil and glowing gold
particles pour out and flow downward, fluid and viscous, light refracting through
the oil.
```

### Clip 3 — Oil ➜ Sea & fish   (Picture 3 → 4)
```
The camera follows the oil stream down into deep dark water; a shoal of small
silver fish swims into frame and the camera begins to track one of them, soft
volumetric light shafts, slow graceful motion.
```

### Clip 4 — Into the fish ➜ Molecules   (Picture 4 → 5)
```
Fast crash-zoom into a single fish, then smoothly slowing into an abstract macro of
two glowing omega-3 molecules suspended in dark fluid, the left one starting to dim.
```

### Clip 5 — The shield ➜ The cell   (Picture 5 → 6)   ⭐ the key shot
```
The left omega-3 molecule oxidizes — it dims, browns and fractures; meanwhile
glowing gold polyphenol particles flow in and wrap the right molecule in a
protective shield, keeping it bright and intact, then it travels and locks into a
glowing cell membrane.
```
> Give this one the most attention — generate a few takes and pick the best. It's
> the most important shot on the site.

### Clip 6 — Cell ➜ Bottle fills   (Picture 6 → 7)
```
The camera pulls back from the cell; a gold stream and a silver stream spiral
together and pour down into the bottle, which fills with oil under soft rim light,
slow elegant reveal.
```

### Clip 7 — Bottle fills ➜ Hero   (Picture 7 → 8)
```
Motion calms to an almost-still slow hover on the finished bottle, faint breathing
light, the scene settles, leaving calm space for text to appear.
```

---

# STEP 4 — Join the 7 clips into one film
You now have 7 short clips. They join cleanly because each one ends where the next
begins. Your developer joins them into a single video file with this one command
(free tool called ffmpeg):

```
ffmpeg -f concat -safe 0 -i list.txt -c copy master.mp4
```
…where `list.txt` simply lists the 7 clips in order. Result: **one ~35-second
film** that flies from tree to bottle. Watch it start to finish — if one
transition looks off, re-make just that clip (not the pictures).

---

# STEP 5 — Put it on the website (hand this part to a developer)

This is the only developer part. Give them the `master.mp4` and these 3 notes:

**5a. Make scroll drive the film.** Use **GSAP ScrollTrigger** so scrolling
scrubs the video like dragging a progress bar (scroll down = play forward, stop =
freeze, scroll up = rewind). Full working code is in
`zinzino-omega3-production-pipeline.md` §4. For phones, use the "image-sequence on
canvas" method in that same section (smoother on iPhone).

**5b. Drop the real bottle in.** Composite your real Zinzino BalanceOil+ photo
over the plain bottle in the last scene so the label is correct.

**5c. Add the words on top.** The headlines/text sit *on top* of the video as
normal web text (not baked into the video), fading in at the right moment. The
exact lines for each scene are in `zinzino-omega3-website-blueprint.md` (Part 2).
The closing screen shows: **3:1 ratio · proven in 120 days**, four benefit icons
(heart, brain, cells, immunity), and one button.

---

## ✅ Simple checklist
- [ ] Replicate account ready + real bottle photo saved
- [ ] Step 1: 8 still pictures generated (same style/seed), happy with all 8
- [ ] Step 3: 7 clips generated (5s, 1080p, silent tier), Clip 5 looks great
- [ ] Step 4: clips joined into one `master.mp4`, watched end-to-end
- [ ] Step 5: developer wires scroll, drops in real bottle, adds the text
- [ ] Checked it on a phone

## Settings cheat-sheet
| Thing | Setting |
|---|---|
| Still pictures | FLUX.2 (Imagen 4 for tree + fish), fixed seed, black background |
| Clips | Kling latest Pro, **start_image + end_image**, 5s, 1080p, silent tier |
| Backup video model | Veo 3.1 (only if a Kling clip is weak) |
| Final film | ~35s, 24–30 fps |
| Website motion | GSAP ScrollTrigger (scrub on scroll); image-sequence on phones |
