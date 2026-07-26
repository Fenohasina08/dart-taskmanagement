import '../enums/priority.dart';
import '../exceptions/invalid_priority_exception.dart';
import 'task.dart';

class UrgentTask extends Task  {
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
    final status = isCompleted ? 'Done' : 'To do';
    final label = priority == Priority.high ? 'URGENT' : 'TASK';
    return '$label [#$id] $title | Priorité: ${priority.name} | Échéance: $date | Statut: $status';
  } 

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priority': priority.name,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory UrgentTask.fromJson(Map<String, dynamic> json) {
    final priorityName = json['priority'] as String;
    Priority priority;
    try {
      priority = Priority.values.byName(priorityName);
    } catch (_) {
      throw InvalidPriorityException();
    }

    return UrgentTask(
      id: json['id'] as String,
      title: json['title'] as String,
      priority: priority,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}