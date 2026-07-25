import 'package:dart_taskmanagement/enums/priority.dart';
import 'package:dart_taskmanagement/models/urgent_task.dart';
import 'package:test/test.dart';

void main() {
  group('UrgentTask', () {
    test('crée une tâche avec les bonnes propriétés', () {
      final task = UrgentTask(
        id: '1',
        title: 'Faire les courses',
        priority: Priority.medium,
        dueDate: DateTime(2026, 1, 1),
      );

      expect(task.id, '1');
      expect(task.title, 'Faire les courses');
      expect(task.priority, Priority.medium);
      expect(task.dueDate, DateTime(2026, 1, 1));
      expect(task.isCompleted, false);
    });

    test('priorité par défaut est high', () {
      final task = UrgentTask(id: '2', title: 'Urgent');
      expect(task.priority, Priority.high);
    });

    test('getDetails contient les informations principales', () {
      final task = UrgentTask(id: '3', title: 'Ranger le bureau');
      final details = task.getDetails();

      expect(details, contains('3'));
      expect(details, contains('Ranger le bureau'));
    });
  });
}