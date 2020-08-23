import 'dart:ui';

class TaskModel {
  final String id;
  final String title;
  final String duration;
  final bool isDone;
  final Color backgroundColor;

  TaskModel(
      {this.id, this.title, this.duration, this.isDone, this.backgroundColor});

  int compareTo(TaskModel obj) {
    if (this.isDone == true && obj.isDone == false) {
      return 1;
    } else if (this.isDone == false && obj.isDone == true) {
      return -1;
    } else {
      return 0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'isDone': isDone == false ? 0 : 1,
      'alpha': backgroundColor.alpha,
      'red': backgroundColor.red,
      'green': backgroundColor.green,
      'blue': backgroundColor.blue,
    };
  }

  static TaskModel toObject(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'],
      title: data['title'],
      duration: data['duration'],
      isDone: data['isDone'] == 0 ? false : true,
      backgroundColor: Color.fromARGB(
        data['alpha'],
        data['red'],
        data['green'],
        data['blue'],
      ),
    );
  }
}
