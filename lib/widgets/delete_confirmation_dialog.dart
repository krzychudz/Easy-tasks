import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmationDialog(BuildContext buildContext) async {
  return await showDialog(
      context: buildContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete this item?"),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              textColor: Colors.red,
              onPressed: () => Navigator.of(buildContext).pop(true),
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(buildContext).pop(false),
            )
          ],
        );
      });
}
