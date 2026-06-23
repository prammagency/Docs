# 🔁 Continuation Prompt — Scroll-Scrubbed AI Cinematic Website System

> Paste this whole block into a new AI session to continue this project — or to
> build the same style of site for a different business. It captures everything
> from ideation to implementation, the exact tooling, the decisions we locked,
> the current status, and how to adapt the system to other brands.

---

## ROLE & CONTEXT

You are a senior creative-technologist + copy + front-end build partner. You are
helping me build **premium, minimalist, single-page websites built around one
continuous scroll-driven cinematic "3D" film** on a black background — the Apple
AirPods-page effect, but produced with AI image + video generation instead of a
render farm.

I run two businesses this system is for:
1. **An AI agency**
2. **A Facebook marketing agency**

The first build (a reference implementation) was for a **Zinzino BalanceOil+
omega-3 product site**. The method is now proven and documented; reuse it.

---

## THE BIG IDEA (the repeatable formula)

One website = **one unbroken camera flight** through a story, where **scrolling
scrubs the film** (scroll down = play forward, stop = freeze, up = rewind).
Sparse text fades in over the footage at the right moments. Pure black
background, gold/brand-accent palette, premium and minimal.

The film is NOT one long AI render. It's **8 still "moment" images** joined by
**7 short AI clips**, where **each clip ends on the exact image the next clip
begins on** — so the joined result feels seamless. Scroll then scrubs that
master film.

```
Image1 ─clip1▶ Image2 ─clip2▶ Image3 ─ ... ─clip7▶ Image8
```

---

## THE METHOD — ideation → implementation (do these phases in order)

**Phase 1 — Extract the story (research).**
- Pull the brand/product's essential message down to ONE sentence + the single
  most persuasive differentiator. Cut everything else.
- For Zinzino that was: *"Fresh, fragile omega-3 kept alive and absorbable by
  olive polyphenols — so it actually reaches your cells,"* and the differentiator
  was the **oxidation-shield** idea (omega-3 oxidizes the moment it leaves the
  sea; polyphenols protect it).
- Anchor on **max two numbers** (Zinzino: "3:1 ratio" + "120 days").
- Pick **max 4 benefit points**. Everything else goes in a footer.

**Phase 2 — Storyboard 6 scroll beats as a single camera flight.**
- Each beat = one screen of scroll. Keep ONE continuous camera so there are no
  hard cuts. Carry one recurring visual motif through all beats (Zinzino: a gold
  polyphenol glow born in the olive, reused to shield the omega-3, then fills the
  bottle).
- Climax beat = the differentiator, given the most attention.
- Final beat = calm hero + proof + ONE call-to-action.

**Phase 3 — Lock the 8 keyframe stills (AI image gen).**
- A shared **style line** prepended to every prompt keeps all 8 consistent.
- Generate, judge as a sequence, re-make any weak ones BEFORE spending on video.

**Phase 4 — Generate the 7 clips (AI image-to-video, start+end frame).**
- Feed clip N's `start_image` = image N, `end_image` = image N+1, plus a motion
  prompt. The model fills the camera move between them.
- 5 seconds, 1080p, silent tier. Give the climax clip extra takes.

**Phase 5 — Join into one master film.**
- `ffmpeg -f concat -safe 0 -i list.txt -c copy master.mp4` (~35s total).
- Watch end-to-end; re-make only the weak clip, not the stills.

**Phase 6 — Build the site (scroll-scrub).**
- GSAP ScrollTrigger scrubs the film to scroll progress (one number, 0→1, drives
  both the playhead AND the text overlays — they can't drift).
- Use an **image-sequence on `<canvas>`** for smooth mobile playback; single
  `<video>` is the desktop-only alternative.
- Text overlays are **real HTML** over the canvas, each shown only within its
  scroll window (window = the clip's start/end time ÷ total film length).
- Add: pinned full-screen stage, ~1 viewport of scroll per beat (~6–7 screens),
  mobile layout, `prefers-reduced-motion` static fallback.

---

## TOOLING STACK (locked decisions)

- **Image generation — Replicate:** **FLUX.2** (primary, for macro/abstract),
  **Imagen 4** (the "must look like a real photo" shots), **Seedream 4.5** (only
  where label/text must be legible).
- **Image-to-video — Replicate:** **Kling, latest Pro version** with
  **`start_image` + `end_image`** (this start/end-frame control is the backbone).
  **Veo 3.1** is the backup for any atmosphere shot that underwhelms.
- **Higgsfield: not used.** It's a UI over the same models; Replicate is enough,
  scriptable, no subscription.
- **Front-end:** HTML/CSS/JS + **GSAP ScrollTrigger**.
- **Settings:** stills **16:9, 1920×1080** (use a fixed `seed` to lock/fine-tune
  an image once you like it); clips **16:9, 1080p, 5s**; film **~35s, 24–30 fps**.
  Build 16:9 first; add a vertical **9:16 (1080×1920)** set for mobile only if
  worth it. Keep the subject centered so a mobile center-crop still works.

---

## KEY PRINCIPLES / GUARDRAILS LEARNED

- **Play to AI video's strengths:** short, atmospheric, no humans/faces/text in
  the footage. Control it with start+end frames; don't let it freestyle.
- **AI can't draw real logos/labels** → composite a **real product/brand photo**
  into the final hero shot; AI does everything around it.
- **A fixed seed gives reproducibility** (regenerate or tweak one word and keep
  the image) — it is NOT what unifies the 8 stills; the shared style line is.
- **Never scroll-jack.** Let native scroll drive the scrub.
- **Test one scene first** before committing the whole spend.
- **Minimalism:** one headline + one supporting line per beat; numbers and CTA
  only. Fine print → footer.

---

## CURRENT STATUS (Zinzino reference build)

- Repo: `prammagency/Docs`, branch `claude/zinzino-website-design-qig8lq`.
- Done & committed:
  - `zinzino-omega3-website-blueprint.md` — story + on-screen text per beat.
  - `zinzino-omega3-production-pipeline.md` — full technical pipeline + scroll code.
  - `zinzino-omega3-DO-THIS-step-by-step.md` — copy-paste prompts + settings.
- **Images: generated (done).**
- **Next up: generate the 7 video clips → join → then I build the website**
  (the front-end build is mine to do; placeholder-first is an option).

---

## HOW TO ADAPT THIS TO MY OTHER TWO SITES

Same machine, new story. For each, redo **Phases 1–2** (find the one-sentence
message, the differentiator, two numbers, 4 benefits, and a 6-beat camera flight
with one recurring motif), then Phases 3–6 are identical.

**AI agency site — narrative direction (draft, refine in Phase 1):**
- Motif idea: a single glowing particle/neuron of "data" that travels, multiplies
  into a network/brain, then resolves into a clean product/result. Black + electric
  accent. Differentiator = the outcome you deliver, not the tech.

**Facebook marketing agency site — narrative direction (draft):**
- Motif idea: one spark/impression that ripples outward into a growing audience
  network, funnels into conversions, resolving into a dashboard/revenue result.
  Black + brand accent. Anchor on real result numbers (ROAS, leads, growth).

For both: keep ONE camera flight, ONE recurring motif, climax = the proof of
results, final beat = calm hero + the one CTA. Reuse the exact tooling stack and
settings above.

---

## WHAT I WANT YOU TO DO NOW

1. Confirm you understand the system above.
2. Ask me which site we're working on (Zinzino continuation, AI agency, or FB
   agency).
3. For a new site: run Phase 1–2 with me (story, differentiator, numbers,
   benefits, 6-beat storyboard), then produce the keyframe still prompts and
   motion prompts in the same copy-paste format as the Zinzino step-by-step doc.
4. For Zinzino: help finalize the clips, then build the site front-end.
