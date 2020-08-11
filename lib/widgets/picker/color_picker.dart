import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final colorsList = [
    Color.fromARGB(240, 87, 237, 129),
    Color.fromARGB(240, 71, 208, 238),
    Color.fromARGB(240, 87, 237, 210),
    Color.fromARGB(240, 162, 87, 237),
    Color.fromARGB(240, 255, 105, 195),
    Color.fromARGB(240, 255, 105, 105),
    Color.fromARGB(240, 87, 122, 87),
    Color.fromARGB(240, 110, 89, 44),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          color: Color.fromARGB(240, 255, 255, 255),
        ),
        width: 500,
        height: 250,
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          children: [
            const Text(
              "Pick a color",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
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
          ],
        ),
      ),
    );
  }
}
