import 'package:flutter/material.dart';

class CircularRaisedButton extends StatelessWidget {
  const CircularRaisedButton(
      {Key key, this.backgroundColor, this.label, this.onPressed})
      : super(key: key);

  final backgroundColor;
  final label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
      ),
      color: backgroundColor,
      child: Text(label),
      onPressed: onPressed,
    );
  }
}