import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';
import '../models/task.dart';

List<Widget> preapreFinalList(List<TaskModel> tasks, BuildContext context) {
  List<Widget> finalList = [];
  bool isDoneHeaderAdded = false;
  bool isTodoHeaderAdded = false;

  tasks.sort((a, b) => a.compareTo(b));

  for (int i = 0; i < tasks.length; i++) {
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
        backgroundColor: tasks[i].backgroundColor,
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
