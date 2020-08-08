import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_notes/widgets/side_drawer.dart';
import '../widgets/task_progress_bar/task_progress_bar.dart';

import '../widgets/todo_item_mange_modal.dart';

import '../helpers/todo_helper.dart' as TodoHelper;

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int percentageOfDone = 0;

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

  Future<void> recalculatePercentageOfDone(List<DocumentSnapshot> tasksList) async {

    final numberOfTasks = tasksList.length;
    final numberOfDone = tasksList.where((element) => element.data['isDone']).length;

    setState(() {
      percentageOfDone = numberOfDone * 100 ~/ numberOfTasks;
    });
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('todos').snapshots().listen((event) {
      recalculatePercentageOfDone(event.documents);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('todos')
                    .orderBy("isDone")
                    .snapshots(),
                builder: (ctx, todoItemsSnapshot) {
                  //recalculatePercentageOfDone();
                  return _buildTaskList(todoItemsSnapshot);
                },
              ),
            ),
          ),
          TaskProgressBar(percentageOfDone),
        ],
      ),
    );
  }
}
