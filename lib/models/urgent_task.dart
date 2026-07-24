import '../enums/priority.dart';
import 'task.dart';

class UrgentTask extends Task {
  UrgentTask({
    required super.id,
    required super.title,
    super.priority = Priority.high, 
    super.dueDate,
    super.isCompleted,
  });

  @override
  String getDetails() {
    final date = dueDate?.toIso8601String() ?? 'Nothing';
    final status = isCompleted ? 'do' : 'To do ';
    return ' URGENT [#$id] $title | Priorité: ${priority.name} | Échéance: $date | Statut: $status';
  }
}