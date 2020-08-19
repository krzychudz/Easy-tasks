import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_notes/database/sqllite_databes.dart';
import '../../repositories/todo/task_repository_interface.dart';
import '../../database/database_interface.dart';
import '../../models/task.dart';

String collectionName = "todos";

class TaskDatabaseRepository implements TaskRepositoryInterface {
  @override
  String sqlTableSchema =
      '(id STRING PRIMARY KEY, title TEXT, duration TEXT, isDone INTEGER, alpha INTEGER, red INTEGER, green INTEGER, blue INTEGER)';

  DatabaseInterface _database = SQLliteDatabase(); // TODO inject this!!

  TaskDatabaseRepository() {
    initDatabaseTable();
  }

  void initDatabaseTable() async {
    await _database.createTableIfNotExists('tasks', sqlTableSchema);
  }

  @override
  Future<List<TaskModel>> getAllTasks(String tableName) async {
    var tasksData = await _database.getAllTableData(tableName);
    print(tasksData);
    return Future<List<TaskModel>>.value(
      tasksData.map((taskData) => TaskModel.toObject(taskData)).toList(),
    );
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    return await _database.insertData('tasks', task.toMap());
  }

  @override
  Future<int> removeTask(String id) async {
    return await _database.removeDataById('tasks', id);
  }

  @override
  Future<int> updateTask(String id, Map<String, dynamic> data) async {
    return await _database.updateData('tasks', id, data);
  }

  @override
  Future<int> removeAllTasks() async {
    return await _database.dropTable('tasks');
  }
}

// Future<void> clearAllTasks() async {
//   return await Firestore.instance
//       .collection(collectionName)
//       .getDocuments()
//       .then((value) => value.documents.forEach((element) {
//             print(element.documentID);
//             Firestore.instance
//                 .collection(collectionName)
//                 .document(element.documentID)
//                 .delete();
//           }));
// }
