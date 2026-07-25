import 'package:dart_taskmanagement/repositories/repository.dart';
import '../models/task.dart';

class TaskRepository implements Repository<Task> {
  final List<Task> _items = [];

  @override
  Task create(Task item) {
    _items.add(item);
    return item;
  }

  @override
  List<Task> readAll() {
    return List.unmodifiable(_items);
  }

  @override
  Task? readById(String id) {
    for (final item in _items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  @override
  void updateTask(String id, Task item) {
    final index = _items.indexWhere((element) => element.id == id);
    if (index != -1) {
      _items[index] = item;
    }
  }

  @override
  void deleteTask(String id) {
    _items.removeWhere((item) => item.id == id);
  }
}