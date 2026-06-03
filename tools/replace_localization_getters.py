#!/usr/bin/env python3
import re
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARB = ROOT / 'lib' / 'l10n' / 'app_en.arb'

# load arb keys
with open(ARB, 'r', encoding='utf-8') as f:
    arb_text = f.read()
keys = set(re.findall(r'"([A-Za-z0-9_]+)"\s*:', arb_text))

pattern = re.compile(r"AppLocalizations\.of\(context\)!\.([A-Z][A-Za-z0-9_]*)")

log = []
replacements = []

for dart_file in ROOT.rglob('lib/**/*.dart'):
    text = dart_file.read_text(encoding='utf-8')
    matches = pattern.findall(text)
    if not matches:
        continue
    new_text = text
    file_changes = []
    for name in sorted(set(matches)):
        candidates = []
        # candidate 1: lower first char
        if len(name) > 1:
            cand1 = name[0].lower() + name[1:]
        else:
            cand1 = name.lower()
        # candidate 2: all lower
        cand2 = name.lower()
        # candidate variants with _1
        cand3 = cand1 + '_1'
        cand4 = cand2 + '_1'
        for c in (cand1, cand2, cand3, cand4):
            if c in keys:
                candidates.append(c)
        # If exactly one candidate found, replace occurrences
        if len(candidates) == 1:
            newname = candidates[0]
            old = f"AppLocalizations.of(context)!.{name}"
            new = f"AppLocalizations.of(context)!.{newname}"
            if old in new_text:
                new_text = new_text.replace(old, new)
                file_changes.append((old, new))
        else:
            if len(candidates) == 0:
                log.append((str(dart_file), name, 'no_candidate'))
            else:
                log.append((str(dart_file), name, 'ambiguous', candidates))
    if file_changes and new_text != text:
        dart_file.write_text(new_text, encoding='utf-8')
        replacements.extend([(str(dart_file), a, b) for (a, b) in file_changes])

# write summary
out = ROOT / 'tools' / 'localization_replace_report.txt'
with open(out, 'w', encoding='utf-8') as f:
    f.write('Applied replacements:\n')
    for r in replacements:
        f.write(f"{r[0]}: {r[1]} -> {r[2]}\n")
    f.write('\nAmbiguous or missing candidates:\n')
    for l in log:
        f.write(str(l) + '\n')

print('Done. Replacements:', len(replacements), 'Ambiguous/missing:', len(log))
print('Report written to', out)
