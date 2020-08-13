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

Future<void> updateTodoTask(Map<String, dynamic> taskDataToEdit) async {
  var taskId = taskDataToEdit["id"];
  return await Firestore.instance
      .collection(collectionName)
      .document(taskId)
      .updateData(taskDataToEdit);
}

Future<void> clearAllTasks() async {
  return await Firestore.instance.collection(collectionName).getDocuments().then((value) => 
    value.documents.forEach((element) {
      print(element.documentID);
      Firestore.instance.collection(collectionName).document(element.documentID).delete();
    })
  );
}
