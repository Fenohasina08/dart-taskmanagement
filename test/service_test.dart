import 'package:dart_taskmanagement/enums/priority.dart';
import 'package:dart_taskmanagement/exceptions/task_not_found_exception.dart';
import 'package:dart_taskmanagement/models/urgent_task.dart';
import 'package:dart_taskmanagement/services/task_service.dart';
import 'package:test/test.dart';

void main() {
  group('TaskService', () {
    late TaskService service;

    setUp(() {
      service = TaskService();
    });

    test('addTask ajoute une tâche à la liste', () {
      final task = UrgentTask(id: '1', title: 'Nouvelle tâche');
      service.addTask(task);

      final tasks = service.getAllTasks();
      expect(tasks, hasLength(1));
      expect(tasks.first.id, '1');
    });

    test('deleteTaskById supprime une tâche existante', () {
      final task = UrgentTask(id: '1', title: 'À supprimer');
      service.addTask(task);

      service.deleteTaskById('1');

      expect(service.getAllTasks(), isEmpty);
    });

    test('deleteTaskById lève TaskNotFoundException si l\'id n\'existe pas', () {
      expect(
        () => service.deleteTaskById('inconnu'),
        throwsA(isA<TaskNotFoundException>()),
      );
    });

    test('markAsCompleted passe isCompleted à true', () {
      final task = UrgentTask(id: '1', title: 'À terminer');
      service.addTask(task);

      service.markAsCompleted('1');

      expect(service.getAllTasks().first.isCompleted, true);
    });

    test('markAsCompleted lève TaskNotFoundException si l\'id n\'existe pas', () {
      expect(
        () => service.markAsCompleted('inconnu'),
        throwsA(isA<TaskNotFoundException>()),
      );
    });

    test('sortByPriority trie de high à low', () {
      service.addTask(UrgentTask(id: '1', title: 'Basse', priority: Priority.low));
      service.addTask(UrgentTask(id: '2', title: 'Haute', priority: Priority.high));
      service.addTask(UrgentTask(id: '3', title: 'Moyenne', priority: Priority.medium));

      final sorted = service.sortByPriority();

      expect(sorted[0].priority, Priority.high);
      expect(sorted[1].priority, Priority.medium);
      expect(sorted[2].priority, Priority.low);
    });

    test('listTaskDetails retourne les descriptions formatées', () {
      service.addTask(UrgentTask(id: '1', title: 'Tâche A'));
      service.addTask(UrgentTask(id: '2', title: 'Tâche B'));

      final details = service.listTaskDetails();

      expect(details, hasLength(2));
      expect(details.first, contains('Tâche A'));
    });

    test('sortByDueDate trie par ordre chronologique', () {
      service.addTask(UrgentTask(id: '1', title: 'Plus tard', dueDate: DateTime(2026, 12, 1)));
      service.addTask(UrgentTask(id: '2', title: 'Bientôt', dueDate: DateTime(2026, 1, 1)));

      final sorted = service.sortByDueDate();

      expect(sorted[0].id, '2');
      expect(sorted[1].id, '1');
    });
  });
}