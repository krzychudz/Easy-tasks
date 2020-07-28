import 'package:easy_notes/widgets/note_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('notes').snapshots(),
        builder: (ctx, noteItemsSnapshot) {
          if (noteItemsSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var noteDocuments = noteItemsSnapshot.data.documents;
          if (noteDocuments.length == 0) {
            return Center(
              child:
                  Text("You have no notes. To add one click on the + button."),
            );
          }
          return ListView.builder(
            itemCount: noteDocuments.length,
            itemBuilder: (ctx, index) {
              return NoteItem(
                noteId: noteDocuments[index]["id"],
                noteTitle: noteDocuments[index]["name"],
                noteDescription: noteDocuments[index]['description'],
              );
            },
          );
        },
      ),
    );
  }
}