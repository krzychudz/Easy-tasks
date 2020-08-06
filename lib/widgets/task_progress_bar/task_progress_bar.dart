import 'package:flutter/material.dart';

class TaskProgressBar extends StatelessWidget {
  final int percentageOfDone;

  TaskProgressBar(this.percentageOfDone);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ProgressIndicator(percentageOfDone),
          ),
          Text(percentageOfDone.toString() + "%"),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final int percentageOfDone;

  ProgressIndicator(this.percentageOfDone);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * percentageOfDone / 100,
          child: Text(""),
          color: Colors.red,
        );
      },
    );
  }
}
