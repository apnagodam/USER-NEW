#!/usr/bin/env python3
import json
import re
from pathlib import Path

ARB_DIR = Path(__file__).resolve().parents[1] / 'lib' / 'l10n'


def sanitize_key(k: str) -> str:
    # Replace invalid chars with underscore
    s = re.sub(r'[^A-Za-z0-9_]', '_', k)
    # If the key is camelCase, insert underscores before capital letters so we split correctly
    s = re.sub(r'(?<!^)([A-Z])', r'_\1', s)
    # Split on underscores and create lowerCamelCase
    parts = [p for p in s.split('_') if p]
    if not parts:
        return 'kKey'
    first = parts[0].lower()
    rest = ''.join(p.capitalize() for p in parts[1:])
    s = first + rest
    # Ensure it starts with a letter
    if not re.match(r'^[A-Za-z]', s):
        s = 'k' + s
    return s


def main():
    for arb in ARB_DIR.glob('*.arb'):
        print('Sanitizing', arb.name)
        data = json.loads(arb.read_text(encoding='utf-8'))
        new = {}
        mapping = {}
        collisions = {}
        for k, v in data.items():
            if k.startswith('@@') or k.startswith('@'):
                new[k] = v
                continue
            nk = sanitize_key(k)
            # avoid collisions
            if nk in new and new[nk] != v:
                i = collisions.get(nk, 1)
                while f"{nk}_{i}" in new:
                    i += 1
                collisions[nk] = i
                nk = f"{nk}_{i}"
            new[nk] = v
            if nk != k:
                mapping[k] = nk
        if mapping:
            print('  renamed', len(mapping), 'keys')
            arb.write_text(json.dumps(new, ensure_ascii=False, indent=2, sort_keys=False) + '\n', encoding='utf-8')
        else:
            print('  no changes')


if __name__ == '__main__':
    main()
