import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert(
  BuildContext context,
  String title,
  String subtitle,
) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              elevation: 5,
              textColor: Colors.blue,
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
