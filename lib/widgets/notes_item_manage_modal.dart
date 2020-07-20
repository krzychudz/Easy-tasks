import 'package:flutter/material.dart';

import '../repositories/note_repository.dart' as NotesRepository;

class ManageNoteItemModal extends StatefulWidget {
  final String noteTite;
  final String noteId;
  final String noteDescription;

  ManageNoteItemModal({
    this.noteTite = "",
    this.noteId = "",
    this.noteDescription = "",
  });

  @override
  _ManageNoteItemModalState createState() => _ManageNoteItemModalState();
}

class _ManageNoteItemModalState extends State<ManageNoteItemModal> {
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  bool _isEditMode = false;

  Future<void> _addNoteItem() async {
    await NotesRepository.pushNoteToFirestore({
      "id": DateTime.now().toString(),
      "name": _titleTextController.text,
      "description": _descriptionTextController.text,
    });

    Navigator.pop(context);
  }

  Future<void> _editNoteItem() async {
    await NotesRepository.editNote({
      "id": widget.noteId,
      "name": _titleTextController.text,
      "description": _descriptionTextController.text
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _isEditMode ? "Edit your note" : "Add a new note",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter a title',
            ),
            controller: _titleTextController,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter a description',
            ),
            controller: _descriptionTextController,
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryTextTheme.headline1.color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Text(_isEditMode ? "Edit" : "Save"),
            onPressed: _isEditMode ? _editNoteItem : _addNoteItem,
          )
        ],
      ),
    );
  }
}
