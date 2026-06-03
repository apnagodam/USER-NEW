import re,glob,sys
# collect declared
decl=set()
for p in ['lib/l10n/app_localizations.dart','lib/localization/app_localizations_extras.dart']:
    try:
        s=open(p,errors='ignore').read()
    except FileNotFoundError:
        continue
    for m in re.findall(r"String get ([A-Za-z0-9_]+)",s):
        decl.add(m)
# collect used
used=set()
for f in glob.glob('**/*.dart',recursive=True):
    try:
        for line in open(f,errors='ignore'):
            m=re.search(r'AppLocalizations\.of\(context\)!\.([A-Za-z0-9_]+)',line)
            if m:
                used.add(m.group(1))
    except Exception:
        pass
missing=sorted(used-decl)
print('\n'.join(missing))
print('---')
print('Declared count:',len(decl))
print('Used count:',len(used))
