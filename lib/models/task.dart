import '../enums/priority.dart';

abstract class Task {
  final String id;
  String title;
  final Priority priority;
  DateTime? dueDate ;
  bool isCompleted;  

   Task({
    required this.id,
    required this.title,
    required this.priority,
    this.dueDate,
    this.isCompleted = false, 
  });

  String getDetails();
}