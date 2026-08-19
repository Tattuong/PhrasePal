#!/usr/bin/env python3
"""PhrasePal mark — 1024px square, full-bleed, no rounded canvas."""
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

SIZE = 2048  # draw large, then downscale
OUT_SIZE = 1024

NAVY = (26, 46, 90, 255)
NAVY_DEEP = (12, 22, 48, 255)
NAVY_MID = (36, 62, 118, 255)
CREAM = (252, 248, 241, 255)
CREAM_DIM = (236, 226, 206, 255)
GOLD = (212, 168, 58, 255)
INK = (22, 38, 78, 255)


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3)) + (255,)


def radial_bg(size: int) -> Image.Image:
    img = Image.new("RGBA", (size, size), NAVY_DEEP)
    px = img.load()
    cx = cy = size / 2
    max_r = (2 * cx * cx) ** 0.5
    for y in range(size):
        for x in range(size):
            t = (((x - cx) ** 2 + (y - cy) ** 2) ** 0.5) / max_r
            t = min(1.0, t ** 0.85)
            px[x, y] = lerp(NAVY_MID, NAVY_DEEP, t)
    return img


def rounded_rect(draw, box, radius, fill):
    draw.rounded_rectangle(box, radius=radius, fill=fill)


def load_font(candidates, size):
    for path, index in candidates:
        p = Path(path)
        if not p.exists():
            continue
        try:
            return ImageFont.truetype(str(p), size=size, index=index)
        except OSError:
            continue
    return ImageFont.load_default()


def main() -> None:
    img = radial_bg(SIZE)
    overlay = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    d = ImageDraw.Draw(overlay)

    # Soft gold wash behind the mark
    glow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    gd = ImageDraw.Draw(glow)
    gd.ellipse([420, 380, 1628, 1580], fill=(212, 168, 58, 48))
    glow = glow.filter(ImageFilter.GaussianBlur(90))
    img = Image.alpha_composite(img, glow)

    # Shadow
    shadow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow)
    sd.rounded_rectangle([430, 500, 1640, 1480], radius=180, fill=(0, 0, 0, 90))
    sd.polygon([(620, 1420), (820, 1420), (560, 1640)], fill=(0, 0, 0, 90))
    shadow = shadow.filter(ImageFilter.GaussianBlur(48))
    img = Image.alpha_composite(img, shadow)

    # Rear bubble (gold, conversation / second language)
    d.rounded_rectangle([620, 360, 1680, 1180], radius=160, fill=GOLD)
    d.polygon([(1380, 1140), (1580, 1140), (1720, 1380)], fill=GOLD)

    # Front bubble
    bx0, by0, bx1, by1 = 360, 430, 1460, 1410
    rounded_rect(d, [bx0, by0, bx1, by1], 170, CREAM)
    d.polygon([(560, 1360), (860, 1360), (430, 1660)], fill=CREAM)

    img = Image.alpha_composite(img, overlay)
    t = ImageDraw.Draw(img)

    ja = load_font(
        [
            ("/System/Library/Fonts/Hiragino Sans GB.ttc", 2),
            ("/System/Library/Fonts/Hiragino Sans GB.ttc", 0),
            ("/System/Library/Fonts/Supplemental/Arial Unicode.ttf", 0),
        ],
        620,
    )
    latin = load_font(
        [
            ("/System/Library/Fonts/Supplemental/Arial Rounded Bold.ttf", 0),
            ("/System/Library/Fonts/HelveticaNeue.ttc", 0),
        ],
        220,
    )

    glyph = "あ"
    bbox = t.textbbox((0, 0), glyph, font=ja)
    tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
    tx = (bx0 + bx1) / 2 - tw / 2 - bbox[0]
    ty = (by0 + by1) / 2 - th / 2 - bbox[1] - 20
    t.text((tx, ty), glyph, font=ja, fill=INK)

    t.text((1124, 1140), "A", font=latin, fill=GOLD)

    out_img = img.resize((OUT_SIZE, OUT_SIZE), Image.Resampling.LANCZOS).convert("RGB")
    out = Path(__file__).resolve().parents[1] / "assets" / "logo.png"
    out.parent.mkdir(parents=True, exist_ok=True)
    out_img.save(out, "PNG", optimize=True)
    print(f"Wrote {out} {out_img.size}")


if __name__ == "__main__":
    main()
