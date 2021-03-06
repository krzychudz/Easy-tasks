import '../../models/task.dart';

abstract class TaskRepositoryInterface {
  String sqlTableSchema;

  Future<List<TaskModel>> getAllTasks(String tableName);
  Future<int> insertTask(TaskModel task);
  Future<int> removeTask(String id);
  Future<int> updateTask(String id, Map<String, dynamic> data);
  Future<int> removeAllTasks();
}