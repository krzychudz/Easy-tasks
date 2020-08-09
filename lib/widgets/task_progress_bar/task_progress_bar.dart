import 'package:flutter/material.dart';

class TaskProgressBar extends StatelessWidget {
  final int percentageOfDone;

  TaskProgressBar(this.percentageOfDone);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(30, 196, 196, 196),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ProgressIndicator(percentageOfDone),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              percentageOfDone.toString() + "%",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
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
        final containerWidth = constraints.maxWidth * percentageOfDone / 100;
        print(containerWidth);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Theme.of(context).accentColor,
          ),
          width: containerWidth,
          child: Text(
            "Daily progress",
            maxLines: 1,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
