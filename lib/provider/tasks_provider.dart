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

   void initTasks() async {
     var tasksFromDatabase = await taskRepository.getAllTasks('tasks');
     tasks = tasksFromDatabase;
     notifyListeners();
   }
}