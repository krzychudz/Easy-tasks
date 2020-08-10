import 'dart:ui';

import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(BuildContext buildContext) async {
  return await showDialog(
      context: buildContext,
      builder: (BuildContext ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: Dialog(
            backgroundColor: Color.fromARGB(240, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Do you want to remove this item?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(buildContext).pop(false),
                      ),
                      RaisedButton(
                        child: Text('Yes'),
                        onPressed: () => Navigator.of(buildContext).pop(true),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
