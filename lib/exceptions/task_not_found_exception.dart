class TaskNotFoundException implements Exception {

   
  @override
  String toString() {
    return 'Task not found';
  }
}