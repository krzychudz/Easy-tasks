import 'package:easy_notes/models/task.dart';
import 'package:easy_notes/repositories/todo/task_repository.dart';
import 'package:easy_notes/repositories/todo/task_repository_interface.dart';
import 'package:flutter/material.dart';

class TasksProvider with ChangeNotifier {
   List<TaskModel> tasks = [];
   TaskRepositoryInterface taskRepository;

   TasksProvider() {
    taskRepository = TaskDatabaseRepository();
    initTasks();
   }

   Future<void> initTasks() async {
     var tasksFromDatabase = await taskRepository.getAllTasks('tasks');
     tasks = tasksFromDatabase;
     notifyListeners();
   }

   Future<void> addNewTask(TaskModel taskModel) async {
     var insertResult = await taskRepository.insertTask(taskModel);
     if (insertResult >= 0) {
       tasks.add(taskModel);
       notifyListeners();
     }
   }

   Future<int> removeTask(String id) async {
     return await taskRepository.removeTask(id);
   }
}