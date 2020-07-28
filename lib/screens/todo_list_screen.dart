import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('todos').snapshots(),
        builder: (ctx, todoItemsSnapshot) {
          if (todoItemsSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var todoDocuments = todoItemsSnapshot.data.documents;
          if (todoDocuments.length == 0) {
            return Center(
              child: Text(
                  "You have no todo task. To add one click on the + button."),
            );
          }
          return ListView.builder(
            itemCount: todoDocuments.length,
            itemBuilder: (ctx, index) {
              var backendColorsList = todoDocuments[index]["backgroundColor"];
              var backgroundColorARGB = Color.fromARGB(
                backendColorsList[0],
                backendColorsList[1],
                backendColorsList[2],
                backendColorsList[3],
              );
              return TodoItem(
                todoId: todoDocuments[index]["id"],
                todoTitle: todoDocuments[index]["name"],
                backgroundColor: backgroundColorARGB,
              );
            },
          );
        },
      ),
    );
  }
}
