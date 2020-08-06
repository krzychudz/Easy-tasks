import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';

List<Widget> preapreFinalList(dynamic todos) {
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
        finalList.add(buildListHeader("Done"));
        isDoneHeaderAdded = true;
      } else if (!todos[i]["isDone"] && !isTodoHeaderAdded) {
        finalList.add(buildListHeader("Todo"));
        isTodoHeaderAdded = true;
      }

      finalList.add(
        TodoItem(
          todoId: todos[i]["id"],
          todoTitle: todos[i]["name"],
          backgroundColor: backgroundColorARGB,
          isDone: todos[i]["isDone"],
        ),
      );
    }
    return finalList;
  }

    Widget buildListHeader(String label) {
    return Container(
      width: double.infinity,
      color: Colors.black26,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }