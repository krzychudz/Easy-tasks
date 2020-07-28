import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final colorsList = [
    Colors.amber,
    Colors.green,
    Colors.indigo,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.orange,
    Colors.lime
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pick a color"),
      content: Container(
        width: 400,
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pop(colorsList[index]);
            },
            child: CircleAvatar(
              backgroundColor: colorsList[index],
            ),
          ),
          itemCount: colorsList.length,
        ),
      ),
    );
  }
}
