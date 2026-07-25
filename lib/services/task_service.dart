import '../exceptions/task_not_found_exception.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../utils/file_manager.dart';

class TaskService {
  final TaskRepository _repository;
  final String _filePath;

  TaskService({
    TaskRepository? repository,
    String filePath = 'data/tasks.json',
  }) : _repository = repository ?? TaskRepository(),
       _filePath = filePath;

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

  List<String> listTaskDetails() {
    return _repository.readAll().map((task) => task.getDetails()).toList();
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