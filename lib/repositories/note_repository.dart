import 'package:cloud_firestore/cloud_firestore.dart';

String collectionName = "notes";

Future<void> pushNoteToFirestore(Map<String, String> todoTask) async {
  return await Firestore.instance
      .collection(collectionName)
      .document(todoTask["id"])
      .setData(todoTask);
}

Future<void> removeNote(String taskId) async {
  return await Firestore.instance
      .collection(collectionName)
      .document(taskId)
      .delete();
}

Future<void> editNote(Map<String, String> taskDataToEdit) async {
  var taskId = taskDataToEdit["id"];
  return await Firestore.instance
      .collection(collectionName)
      .document(taskId)
      .updateData(taskDataToEdit);
}
