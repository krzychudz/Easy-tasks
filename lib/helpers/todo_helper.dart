import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';

List<Widget> preapreFinalList(dynamic todos, BuildContext context) {
  List<Widget> finalList = [];
  bool isDoneHeaderAdded = false;
  bool isTodoHeaderAdded = false;

  for (int i = 0; i < todos.length; i++) {
    var backendColorsList = todos[i]["backgroundColor"];
    var backgroundColorARGB = Color.fromARGB(
      backendColorsList[0],
      backendColorsList[1],
      backendColorsList[2],
      backendColorsList[3],
    );

    if (todos[i]["isDone"] && !isDoneHeaderAdded) {
      finalList.add(
        buildListHeader("Done", context),
      );
      isDoneHeaderAdded = true;
    } else if (!todos[i]["isDone"] && !isTodoHeaderAdded) {
      finalList.add(
        buildListHeader("Todo", context),
      );
      isTodoHeaderAdded = true;
    }

    finalList.add(
      TodoItem(
        todoId: todos[i]["id"],
        todoTitle: todos[i]["name"],
        backgroundColor: backgroundColorARGB,
        isDone: todos[i]["isDone"],
        workingTime: todos[i]['workingTime'],
      ),
    );
  }
  return finalList;
}

Widget buildListHeader(String label, BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      vertical: 16,
    ),
    margin: const EdgeInsets.only(
      top: 8,
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
