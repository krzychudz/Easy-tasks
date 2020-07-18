import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> pushTodoTaskToFirestore(Map<String, String> todoTask) async {
  return await Firestore.instance
      .collection('todos')
      .document(todoTask["id"])
      .setData(todoTask);
}

Future<void> removeTodoTask(String taskId) async {
  return await Firestore.instance.collection('todos').document(taskId).delete();
}
