import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('todos').snapshots(),
        builder: (ctx, todoItemsSnapshot) {
          var todoDocuments = todoItemsSnapshot.data.documents;
          return ListView.builder(
            itemCount: todoDocuments.length,
            itemBuilder: (ctx, index) {
              return Text(todoDocuments[index]["name"]);
            },
          );
        },
      ),
    );
  }
}
