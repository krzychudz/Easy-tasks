import 'dart:ui';

import 'package:flutter/material.dart';
import '../widgets/button/circular_raised_button.dart';

Future<bool> showConfirmationDialog({BuildContext buildContext, String title, possitiveButtonCallback, negativeButtonCallback}) async {
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
                    title,
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
                      Expanded(
                        child: CircularRaisedButton(
                          label: 'No',
                          backgroundColor: Color.fromARGB(255, 0, 255, 194),
                          onPressed: negativeButtonCallback,
                        ),
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: CircularRaisedButton(
                          label: 'Yes',
                          backgroundColor: Colors.red,
                          onPressed: possitiveButtonCallback,
                        ),
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
