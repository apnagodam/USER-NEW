#!/usr/bin/env python3
import re
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[0]))
from sanitize_arb import sanitize_key

ROOT = Path(__file__).resolve().parents[1]
LEGACY = ROOT / 'lib' / 'localization' / 'en_us' / 'en_us_translations.dart'
SRC = ROOT / 'lib'


def parse_legacy(dart_path: Path):
    text = dart_path.read_text(encoding='utf-8')
    m = re.search(r"enUs\s*=\s*\{(.*)\}\s*;", text, re.S)
    if not m:
        return {}
    body = m.group(1)
    keys = []
    for line in body.splitlines():
        lm = re.match(r"\s*'(?P<k>[^']+)':", line)
        if lm:
            keys.append(lm.group('k'))
    return keys


def build_mapping(keys):
    mapping = {}
    for k in keys:
        nk = sanitize_key(k)
        mapping[k] = nk
    return mapping


def replace_in_file(path: Path, mapping: dict):
    s = path.read_text(encoding='utf-8')
    orig = s
    changed = False
    for old, new in mapping.items():
        # look for patterns where old is used as getter on AppLocalizations
        # variants: AppLocalizations.of(context)!.Old, AppLocalizations.of(context).Old
        pattern = re.compile(rf"(AppLocalizations\.of\(context\)!?\.?){re.escape(old)}\b")
        s, n = pattern.subn(rf"\1{new}", s)
        if n:
            changed = True
    if changed:
        bak = str(path) + '.bak'
        path.rename(bak)
        path.write_text(s, encoding='utf-8')
        print(f'Patched {path} (backup at {bak})')


def main():
    keys = parse_legacy(LEGACY)
    mapping = build_mapping(keys)
    dart_files = list(SRC.rglob('*.dart'))
    for f in dart_files:
        replace_in_file(f, mapping)


if __name__ == '__main__':
    main()
