import 'package:apnagodam/core/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'color_constant.dart';

class comanDiolog extends StatefulWidget {
  final dailog;

  const comanDiolog({super.key, required this.dailog});

  @override
  State<comanDiolog> createState() => _comanDiologState();
}

class _comanDiologState extends State<comanDiolog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: Text(AppLocalizations.of(context)!.msgAlert),
        content: Text(info),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                AppLocalizations.of(context)!.msgOk,
                style: TextStyle(color: ColorConstant.maingreen),
              ))
        ],
      ),
    );
  }
}
