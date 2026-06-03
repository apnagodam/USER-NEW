import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

typedef DialogCallback = void Function(bool userClickedOK);

void CommanDialog(
  BuildContext context,
  String title,
  String message,
  DialogCallback callback,
) {
  ElevarmConfirmAlertDialog(
    title: title,
    subtitle: message,
    onPositiveButton: () {
      callback(true);
    },
    onNegativeButton: () {
      callback(false);
    },
    positiveText: AppLocalizations.of(context)!.msgOk,
    negativeText: AppLocalizations.of(context)!.msgCencel,
    variant: ElevarmDialogVariant.danger,
  ).show(context);
  // showCupertinoDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: Text(title),
  //       content: Text(message),
  //       actions: [
  //         CupertinoDialogAction(
  //           onPressed: () {
  //             callback(true); // User clicked 'OK'
  //           },
  //           child: Text(AppLocalizations.of(context)!.msgOk),
  //         ),
  //         CupertinoDialogAction(
  //           onPressed: () {
  //             // User clicked 'Cancel'
  //           },
  //           child: Text(AppLocalizations.of(context)!.msgCencel),
  //         ),
  //       ],
  //     );
  //   },
  // );
}
