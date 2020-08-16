import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';
import '../models/task.dart';

List<Widget> preapreFinalList(List<TaskModel> tasks, BuildContext context) {
  List<Widget> finalList = [];
  bool isDoneHeaderAdded = false;
  bool isTodoHeaderAdded = false;

  for (int i = 0; i < tasks.length; i++) {
    // var backendColorsList = tasks[i]["backgroundColor"];
    // var backgroundColorARGB = Color.fromARGB(
    //   backendColorsList[0],
    //   backendColorsList[1],
    //   backendColorsList[2],
    //   backendColorsList[3],
    // );

    if (tasks[i].isDone && !isDoneHeaderAdded) {
      finalList.add(
        buildListHeader("Done", context),
      );
      isDoneHeaderAdded = true;
    } else if (!tasks[i].isDone && !isTodoHeaderAdded) {
      finalList.add(
        buildListHeader("Todo", context),
      );
      isTodoHeaderAdded = true;
    }

    finalList.add(
      TodoItem(
        todoId: tasks[i].id.toString(),
        todoTitle: tasks[i].title,
        backgroundColor: Colors.teal,
        isDone: tasks[i].isDone,
        workingTime: tasks[i].duration,
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
