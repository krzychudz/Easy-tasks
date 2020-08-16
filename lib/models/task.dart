class TaskModel {
  final int id;
  final String title;
  final String duration;
  final bool isDone;

  TaskModel({
    this.id,
    this.title,
    this.duration,
    this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'isDone': isDone == false ? 0 : 1,
    };
  }

  static TaskModel toObject(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'],
      title: data['title'],
      duration: data['duration'],
      isDone: data['isDone'] == 0 ? false : true
    );
  }
}
