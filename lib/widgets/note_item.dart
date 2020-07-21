import 'package:easy_notes/widgets/notes_item_manage_modal.dart';
import 'package:flutter/material.dart';

import '../widgets/delete_confirmation_dialog.dart' as DialogHelper;

import '../repositories/note_repository.dart' as NoteRepository;

class NoteItem extends StatelessWidget {
  final String noteTitle;
  final String noteId;
  final String noteDescription;

  NoteItem({this.noteTitle, this.noteId, this.noteDescription});

  void showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) => ManageNoteItemModal(
        noteId: noteId,
        noteTite: noteTitle,
        noteDescription: noteDescription,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(right: 16.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (dismissDirection) async {
        return await DialogHelper.showDeleteConfirmationDialog(context);
      },
      onDismissed: (direction) => NoteRepository.removeNote(noteId),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(noteTitle),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => showEditBottomSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
