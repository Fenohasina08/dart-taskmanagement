import '../exceptions/task_not_found_exception.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../utils/file_manager.dart';

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

  List<Task> displayAllTasks() {
    final tasks = _repository.readAll();
    if (tasks.isEmpty) {
      print('No tasks found.');
      return tasks;
    }
    for (var task in tasks) {
      print(task.getDetails());
    }
    return tasks;
  }

  List<Task> sortByPriority() {
    final tasks = List<Task>.from(_repository.readAll());
    tasks.sort((a, b) => b.priority.index - a.priority.index);
    return tasks;
  }

  List<Task> sortByDueDate() {
    final tasks = List<Task>.from(_repository.readAll());
    tasks.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) return 0;
      if (a.dueDate == null) return 1;
      if (b.dueDate == null) return -1;
      return a.dueDate!.compareTo(b.dueDate!);
    });
    return tasks;
  }

  void markAsCompleted(String id) {
    final task = _repository.readById(id);
    if (task == null) {
      throw TaskNotFoundException();
    }
    task.isCompleted = true;
    _repository.updateTask(id, task);
  }

  void deleteTaskById(String id) {
    if (_repository.readById(id) == null) {
      throw TaskNotFoundException();
    }
    _repository.deleteTask(id);
  }
}