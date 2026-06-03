#!/usr/bin/env python3
import re
import os
from pathlib import Path

root = Path('lib')
en_file = Path('lib/localization/en_us/en_us_translations.dart')

# Read en_us translations
text = en_file.read_text(encoding='utf-8')
# crude parser for entries like  'key': 'Value',
entry_re = re.compile(r"\'([^']+)\'\s*:\s*\'([^']*)\'\s*,")
entries = entry_re.findall(text)
key_to_value = {k: v for k, v in entries}
value_to_key = {v: k for k, v in entries}

# helper to convert key to camelCase getter
def to_camel_case(key):
    parts = re.split('[^0-9a-zA-Z]+', key)
    if not parts:
        return key
    first = parts[0]
    rest = ''.join(p.capitalize() for p in parts[1:])
    return first + rest

# Files to scan
dart_files = [p for p in root.rglob('*.dart')]
replacements = []
for f in dart_files:
    s = f.read_text(encoding='utf-8')
    orig = s
    # replace single-quoted literals
    def repl_sq(m):
        token = m.group(1)
        # prefer token as key
        if token in key_to_value:
            getter = to_camel_case(token)
            return f"AppLocalizations.of(context)!.{getter}"
        if token in value_to_key:
            getter = to_camel_case(value_to_key[token])
            return f"AppLocalizations.of(context)!.{getter}"
        return m.group(0)
    s = re.sub(r"'([^']+)'\.tr", repl_sq, s)
    # replace double-quoted literals
    def repl_dq(m):
        token = m.group(1)
        if token in key_to_value:
            getter = to_camel_case(token)
            return f"AppLocalizations.of(context)!.{getter}"
        if token in value_to_key:
            getter = to_camel_case(value_to_key[token])
            return f"AppLocalizations.of(context)!.{getter}"
        return m.group(0)
    s = re.sub(r'"([^\"]+)"\.tr', repl_dq, s)

    if s != orig:
        bak = f.with_suffix(f"{f.suffix}.bak")
        bak.write_text(orig, encoding='utf-8')
        f.write_text(s, encoding='utf-8')
        replacements.append(str(f))

print('Modified files:')
for r in replacements:
    print(r)
print('Done')
