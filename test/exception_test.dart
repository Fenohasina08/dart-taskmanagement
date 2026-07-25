import 'package:dart_taskmanagement/exceptions/invalid_priority_exception.dart';
import 'package:dart_taskmanagement/exceptions/storage_exception.dart';
import 'package:dart_taskmanagement/exceptions/task_not_found_exception.dart';
import 'package:test/test.dart';

void main() {
  group('Exceptions personnalisées', () {
    test('TaskNotFoundException a un message clair', () {
      expect(TaskNotFoundException().toString(), 'Task not found');
    });

    test('InvalidPriorityException a un message clair', () {
      expect(InvalidPriorityException().toString(), 'Invalid priority');
    });

    test('StorageException contient le message fourni', () {
      final exception = StorageException('fichier introuvable');
      expect(exception.toString(), contains('fichier introuvable'));
    });

    test('TaskNotFoundException est bien levée', () {
      expect(() => throw TaskNotFoundException(), throwsA(isA<TaskNotFoundException>()));
    });
  });
}