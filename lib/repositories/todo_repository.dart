import 'package:cloud_firestore/cloud_firestore.dart';

String collectionName = "todos";

Future<void> pushTodoTaskToFirestore(Map<String, dynamic> todoTask) async {
  return await Firestore.instance
      .collection(collectionName)
      .document(todoTask["id"])
      .setData(todoTask);
}

Future<void> removeTodoTask(String taskId) async {
  return await Firestore.instance
      .collection(collectionName)
      .document(taskId)
      .delete();
}

Future<void> editTodoTask(Map<String, String> taskDataToEdit) async {
  var taskId = taskDataToEdit["id"];
  return await Firestore.instance
      .collection(collectionName)
      .document(taskId)
      .updateData(taskDataToEdit);
}