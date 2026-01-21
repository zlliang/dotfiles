---
name: irasutoya
description: Generates images in the Japanese "irasutoya" (いらすとや) clip art style. Use when asked to create irasutoya-style illustrations, cute Japanese clip art, or convert images to irasutoya style.
---

# Generating Irasutoya-Style Images

Creates images in the distinctive style of [Irasutoya](https://www.irasutoya.com/) (いらすとや), Japan's iconic free clip art website created by illustrator Takashi Mifune.

## Prerequisites

This skill requires an image generation tool. In Amp, use the `painter` tool. If no image generation tool is available, inform the user that generating images is not possible in the current environment.

## Irasutoya style characteristics

The irasutoya style has these defining visual elements:

### Line work

- Soft, rounded outlines with consistent stroke width
- Clean, simple lines without excessive detail
- Gentle curves preferred over sharp angles
- Black or dark brown outlines

### Colors

- Soft, pastel color palette with gentle saturation
- Warm, friendly tones (peach skin tones, soft pinks, light blues, gentle greens)
- Minimal gradients; mostly flat coloring with subtle shading
- White or transparent backgrounds

### Character design

- Simple, round faces with dot eyes and minimal facial features
- Small, curved mouths (often just a simple arc)
- Rosy cheeks (pink circles) on human characters
- Chibi-like proportions with slightly oversized heads
- Simple, rounded body shapes
- Expressive but minimalist poses

### Overall aesthetic

- Kawaii (cute) but not overly childish
- Universally friendly and approachable
- Culturally neutral enough for official/corporate use
- Hyper-specific scenarios depicted in a simple way
- Manga-influenced but simplified

## Generating images

When generating irasutoya-style images:

1. **For text prompts**: Incorporate the style characteristics above into the prompt

   Example prompt structure:
   ```
   Irasutoya-style illustration of [subject]. Soft pastel colors, simple rounded outlines, 
   chibi proportions, dot eyes, rosy cheeks, flat coloring with minimal shading, 
   clean white background, cute Japanese clip art style.
   ```

2. **For image conversion**: When converting an existing image to irasutoya style, use the source image as a reference and describe the transformation

   Example prompt structure:
   ```
   Convert to irasutoya-style illustration. Simplify to soft rounded outlines, 
   use pastel color palette, add chibi proportions with oversized head, 
   dot eyes, rosy cheeks, flat coloring, white background, 
   cute Japanese clip art aesthetic like irasutoya.com illustrations.
   ```

## Reference examples

Use the bundled examples in the `examples/` folder as visual references when generating images. There are 21 diverse examples covering common topics:

### Human figures

- `person_gift.png` — Man holding gift box, rosy cheeks, simple features
- `money_success_woman.png` — Business woman celebrating, arms raised
- `money_success_man.png` — Business man celebrating pose
- `money_joucho_woman.png` — Woman showing stressed emotion
- `money_ohagya.png` — Person in morning panic expression
- `taxi_driver.png` — Professional in uniform (taxi driver)
- `marie_antoinette.png` — Historical/fantasy costume character
- `cult_kanyuu.png` — Two people interaction scene
- `christmas_boy.png` — Child with Christmas gift (seasonal)

### Animals

- `animal_sloth.png` — Cute sloth with soft curves
- `dog_chihuahua.png` — Small dog breed illustration
- `fish_tako.png` — Octopus with simple rounded shape
- `eto_uma_banzai.png` — Horse in celebration pose
- `eto_uma_couple.png` — Two horses together
- `eto_uma_family.png` — Horse family group
- `eto_centaur_takoage.png` — Fantasy centaur flying kite

### Food and objects

- `food_samugetan.png` — Korean soup dish
- `money_500.png` — 500 yen coin with clean lines
- `mark_batsu.png` — Simple X mark icon

### Scenes

- `setsubun_mamemaki.png` — Festival scene with person throwing beans
- `time_yuu.png` — Evening/sunset scenic illustration

When using the `painter` tool, pass example images as `inputImagePaths` for style reference.

If more examples are needed for a specific topic, search https://www.irasutoya.com/ for additional references.

## Usage notes

- The actual irasutoya illustrations are copyrighted by Takashi Mifune
- Generated images are *in the style of* irasutoya, not actual irasutoya assets
- For official projects, consider using actual irasutoya illustrations from https://www.irasutoya.com/ under their terms
