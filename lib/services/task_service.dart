import 'package:dart_taskmanagement/models/urgent_task.dart';

class TaskService {
  final TaskRepository _repository = TaskRepository();

  static const String _filePath = 'data/tasks.json';

  Future<void> loadTasks() async {
    final tasks = await FileManager.loadTasks(_filePath);
    for (var task in tasks) {
      _repository.create(task);
    }
  }

  Future<void> saveTasks() async {
    final tasks = _repository.readAll();
    await FileManager.saveTasks(_filePath, tasks);
  }

  void addTask(Task task) {
    _repository.create(task);
  }

  List<Task> getAllTasks() {
    return _repository.readAll();
  }

  void deleteTask(String id) {
    _repository.deleteTask(id);
  }

  void completeTask(String id) {
    final task = _repository.readById(id);
    if (task != null) {
      task.isDone = true;
      _repository.updateTask(id, task);
    }
  }

  List<Task> getSortedTasksByPriority() {
    final tasks = _repository.readAll();
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    return tasks;
  }

  void addUrgentTask(String id, String title) {
    final urgentTask = UrgentTask(id: id, title: title);
    _repository.create(urgentTask);
  }

  List<Task> displayAllTasks() {
    final tasks = _repository.readAll();
    for (var task in tasks) {
      print(task.getDetails());
    }
    return tasks;
  }
}
