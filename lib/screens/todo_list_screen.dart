import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_notes/widgets/side_drawer.dart';

import '../widgets/task_progress_bar/task_progress_bar.dart';
import '../widgets/todo_item_mange_modal.dart';
import '../helpers/todo_helper.dart' as TodoHelper;

class TodoListScreen extends StatelessWidget {
  final taskListSnapshot =
      Firestore.instance.collection('todos').orderBy("isDone").snapshots();

  void _showBottomModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => MangeTodoItemModal(),
    );
  }

  Widget _buildTaskList(AsyncSnapshot<dynamic> todoItemsSnapshot) {
    if (todoItemsSnapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    var todoDocuments = todoItemsSnapshot.data.documents;
    if (todoDocuments.length == 0) {
      return Center(
        child: Text("You have no todo task. To add one click on the + button."),
      );
    }

    List<Widget> list = TodoHelper.preapreFinalList(todoDocuments);

    return ListView.builder(
      itemBuilder: (ctx, index) => list[index],
      itemCount: list.length,
    );
  }

  int recalculatePercentageOfDone(dynamic todoItemsShnapshot) {
    if (!todoItemsShnapshot.hasData) {
      return 0;
    }
    final tasksList =
        (todoItemsShnapshot.data.documents as List<DocumentSnapshot>);
    final numberOfTasks = tasksList.length;
    final numberOfDone =
        tasksList.where((element) => element.data['isDone']).length;

    return numberOfTasks == 0 ? 0 : numberOfDone * 100 ~/ numberOfTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Daily Tasks"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => _showBottomModalSheet(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StreamBuilder(
                stream: taskListSnapshot,
                builder: (ctx, todoItemsSnapshot) {
                  return _buildTaskList(todoItemsSnapshot);
                },
              ),
            ),
          ),
          StreamBuilder<Object>(
              stream: taskListSnapshot,
              builder: (context, todoItemsShnapshot) {
                return TaskProgressBar(
                  recalculatePercentageOfDone(todoItemsShnapshot),
                );
              }),
        ],
      ),
    );
  }
}
