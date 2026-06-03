import 'dart:convert';
import 'dart:io';

// Import existing translation maps
import 'package:apnagodam/localization/en_us/en_us_translations.dart' as en;
import 'package:apnagodam/localization/en_us/en_us_missing_translations.dart'
    as enMissing;
import 'package:apnagodam/localization/en_us/hi_in_translations.dart' as hi;
import 'package:apnagodam/localization/en_us/ka_in_translations.dart' as kn;

void main() {
  final outDir = Directory('lib/l10n');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  // Merge the main English translations with the missing placeholders so new getters are generated
  final combinedEn = Map<String, String>.from(en.enUs)
    ..addAll(enMissing.enUsMissing);
  writeArb(outDir, 'intl_en.arb', 'en', combinedEn);
  writeArb(outDir, 'intl_hi.arb', 'hi', hi.hiIN);
  writeArb(outDir, 'intl_kn.arb', 'kn', kn.knIn);

  print('Generated ARB files in ${outDir.path}');
}

void writeArb(
    Directory outDir, String fileName, String locale, Map<String, String> map) {
  final file = File('${outDir.path}/$fileName');
  final contentMap = <String, dynamic>{'@@locale': locale};
  contentMap.addAll(map);
  final encoder = const JsonEncoder.withIndent('  ');
  file.writeAsStringSync(encoder.convert(contentMap));
}
