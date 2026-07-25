import 'package:dart_taskmanagement/exceptions/invalid_priority_exception.dart';
import 'package:dart_taskmanagement/enums/priority.dart';
import 'package:dart_taskmanagement/models/urgent_task.dart';
import 'package:test/test.dart';

void main() {
  group('Conversion JSON', () {
    test('Task vers JSON puis JSON vers Task donne les mêmes données', () {
      final task = UrgentTask(
        id: '10',
        title: 'Réviser Dart',
        priority: Priority.low,
        dueDate: DateTime(2026, 5, 20),
        isCompleted: true,
      );

      final json = task.toJson();
      final restored = UrgentTask.fromJson(json);

      expect(restored.id, task.id);
      expect(restored.title, task.title);
      expect(restored.priority, task.priority);
      expect(restored.dueDate, task.dueDate);
      expect(restored.isCompleted, task.isCompleted);
    });

    test('fromJson gère une dueDate nulle', () {
      final json = {
        'id': '11',
        'title': 'Sans échéance',
        'priority': 'medium',
        'dueDate': null,
        'isCompleted': false,
      };

      final task = UrgentTask.fromJson(json);
      expect(task.dueDate, isNull);
    });

    test('fromJson lève InvalidPriorityException pour une priorité invalide', () {
      final json = {
        'id': '12',
        'title': 'Priorité invalide',
        'priority': 'urgent',
        'dueDate': null,
        'isCompleted': false,
      };

      expect(
        () => UrgentTask.fromJson(json),
        throwsA(isA<InvalidPriorityException>()),
      );
    });
  });
}