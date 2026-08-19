#!/usr/bin/env python3
"""Generate bundled WAV clips from phrase_catalog.dart using macOS say."""

from __future__ import annotations

import re
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / "lib/data/phrase_catalog.dart"
OUT = ROOT / "assets/audio"

VOICES = {
    "ja": "Kyoko",
    "ko": "Yuna",
    "th": "Kanya",
    "es": "Mónica",
    "fr": "Thomas",
    "vi": "Linh",
    "it": "Alice",
    "de": "Anna",
    "zh": "Tingting",
}

PHRASE_RE = re.compile(
    r"Phrase\(\s*id:\s*'([^']+)'\s*,\s*categoryId:\s*'[^']+'\s*,\s*native:\s*'((?:\\'|[^'])*)'",
    re.S,
)


def _strip_wav(path: Path) -> None:
    import wave

    with wave.open(str(path), "rb") as reader:
        params = reader.getparams()
        frames = reader.readframes(reader.getnframes())
    with wave.open(str(path), "wb") as writer:
        writer.setparams(params)
        writer.writeframes(frames)


def synth(pid: str, native: str) -> str:
    lang = pid.split("_", 1)[0]
    voice = VOICES.get(lang, "Samantha")
    spoken = native.replace("\\'", "'")
    wav = OUT / f"{pid}.wav"
    if wav.exists() and wav.stat().st_size > 2000:
        return pid
    aiff = Path(f"/tmp/pp_{pid}.aiff")
    subprocess.run(["say", "-v", voice, "-o", str(aiff), spoken], check=True)
    subprocess.run(["afconvert", "-f", "WAVE", "-d", "LEI16@16000", str(aiff), str(wav)], check=True)
    aiff.unlink(missing_ok=True)
    _strip_wav(wav)
    return pid


def main() -> int:
    texts = [
        (ROOT / "lib/data/phrase_catalog.dart").read_text(encoding="utf-8"),
        (ROOT / "lib/data/phrases_more.dart").read_text(encoding="utf-8"),
    ]
    phrases: list[tuple[str, str]] = []
    seen: set[str] = set()
    for text in texts:
        for pid, native in PHRASE_RE.findall(text):
            if pid in seen:
                continue
            seen.add(pid)
            phrases.append((pid, native))
    if not phrases:
        print("No phrases found", file=sys.stderr)
        return 1
    OUT.mkdir(parents=True, exist_ok=True)
    with ThreadPoolExecutor(max_workers=4) as pool:
        futs = [pool.submit(synth, pid, native) for pid, native in phrases]
        for i, fut in enumerate(as_completed(futs), 1):
            print(f"{i}/{len(phrases)} {fut.result()}")
    print(f"Wrote {len(phrases)} files to {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
