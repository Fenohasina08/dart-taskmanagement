import 'package:dart_taskmanagement/models/urgent_task.dart';
import 'package:dart_taskmanagement/repositories/task_repository.dart';
import 'package:test/test.dart';

void main() {
  group('TaskRepository', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    test('create ajoute une tâche et readAll la retourne', () {
      final task = UrgentTask(id: '1', title: 'Tâche 1');
      repository.create(task);

      expect(repository.readAll(), hasLength(1));
      expect(repository.readAll().first.id, '1');
    });

    test('readById retourne null si la tâche n\'existe pas', () {
      expect(repository.readById('inconnu'), isNull);
    });

    test('updateTask remplace correctement la tâche', () {
      final task = UrgentTask(id: '1', title: 'Tâche 1');
      repository.create(task);

      final updated = UrgentTask(id: '1', title: 'Tâche modifiée');
      repository.updateTask('1', updated);

      expect(repository.readById('1')!.title, 'Tâche modifiée');
    });

    test('deleteTask supprime la tâche', () {
      final task = UrgentTask(id: '1', title: 'Tâche 1');
      repository.create(task);
      repository.deleteTask('1');

      expect(repository.readById('1'), isNull);
    });
  });
}