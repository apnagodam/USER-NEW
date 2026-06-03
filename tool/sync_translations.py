#!/usr/bin/env python3
import re
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LEGACY = ROOT / 'lib' / 'localization' / 'en_us' / 'en_us_translations.dart'
ARB_DIR = ROOT / 'lib' / 'l10n'


def parse_legacy(dart_path: Path):
    text = dart_path.read_text(encoding='utf-8')
    # Find the map literal between enUs = { and the closing };
    m = re.search(r"enUs\s*=\s*\{(.*)\}\s*;", text, re.S)
    if not m:
        raise SystemExit('Could not find enUs map in legacy file')
    body = m.group(1)
    entries = {}
    # Simple stateful parser to handle multi-line single-quoted values
    lines = body.splitlines()
    key = None
    val_parts = []
    for line in lines:
        line = line.rstrip()
        if key is None:
            m = re.match(r"\s*'(?P<k>[^']+)':\s*'(.*)$", line)
            if m:
                key = m.group('k')
                rest = line.split("':",1)[1].lstrip()
                # remove leading opening quote
                if rest.startswith("'"):
                    rest = rest[1:]
                # if line ends with', then single-line
                if rest.endswith("',") or rest.endswith("' ,"):
                    val = rest[:-2].strip()
                    entries[key] = val.replace("\\'","'")
                    key = None
                else:
                    # remove trailing quote if present later
                    val_parts = [rest]
            # else ignore
        else:
            # accumulate until we hit a line that ends a single-quoted value with a comma
            if line.endswith("',") or line.endswith("' ,"):
                part = line[:-2]
                val_parts.append(part)
                val = '\n'.join(val_parts).strip()
                entries[key] = val.replace("\\'","'")
                key = None
                val_parts = []
            else:
                val_parts.append(line)
    return entries


def load_arb(path: Path):
    data = json.loads(path.read_text(encoding='utf-8'))
    return data


def save_arb(path: Path, data: dict):
    # Keep a stable ordering: existing keys first, then new sorted keys
    with path.open('w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2, sort_keys=False)
        f.write('\n')


def main():
    legacy = parse_legacy(LEGACY)
    print(f'Parsed {len(legacy)} legacy keys from {LEGACY}')

    arb_files = list(ARB_DIR.glob('*.arb'))
    if not arb_files:
        raise SystemExit('No ARB files found in lib/l10n')

    for arb in arb_files:
        print(f'Processing {arb.name}')
        try:
            arb_data = load_arb(arb)
        except Exception as e:
            print('  failed to load arb:', e)
            continue
        existing = set(k for k in arb_data.keys() if not k.startswith('@@') and not k.startswith('@'))
        added = 0
        for k, v in legacy.items():
            if k not in existing:
                # add with English text for now
                arb_data[k] = v
                added += 1
        if added:
            save_arb(arb, arb_data)
            print(f'  added {added} keys to {arb.name}')
        else:
            print(f'  no keys added to {arb.name}')


if __name__ == '__main__':
    main()
