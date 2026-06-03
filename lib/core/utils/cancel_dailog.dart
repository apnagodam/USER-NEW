import 'package:flutter/material.dart';

typedef DialogCallback = void Function(bool userClickedOK);

void showDecisionDialog(BuildContext context, String title, String message,
    DialogCallback callback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              callback(true); // User clicked 'OK'
            },
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () {
              callback(false); // User clicked 'Cancel'
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
