import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_notes/database/sqllite_databes.dart';
import '../../repositories/todo/task_repository_interface.dart';
import '../../database/database_interface.dart';
import '../../models/task.dart';

String collectionName = "todos";

class TaskDatabaseRepository implements TaskRepositoryInterface {

  @override
  String sqlTableSchema = '(id INTEGER PRIMARY KEY, title TEXT, duration TEXT, isDone INTEGER)';

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
    return tasksData.map((taskData) => TaskModel.toObject(taskData));
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    return await _database.insertData('tasks', task.toMap());
  }
}


Future<void> pushTodoTaskToFirestore(Map<String, dynamic> todoTask) async {    
  TaskRepositoryInterface taskRepositoryInterface = TaskDatabaseRepository();
  taskRepositoryInterface.insertTask(TaskModel.toObject({
    'id': 200,
    'title': 'New task',
    'duration': '60',
    'isDone': false,
  })).then((value) => 
    print("INSERT SUCCESS: " + value.toString())
  );
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
