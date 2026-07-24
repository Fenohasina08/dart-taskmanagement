import 'dart:convert';
import 'dart:io';
import '../models/task.dart';

class FileManager {
   static Future<List<Task>> loadTasks(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      return [];
    }

    final String content = await file.readAsString();
    if (content.trim().isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(content);
    return jsonList
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

   static Future<void> saveTasks(String filePath, List<Task> tasks) async {
    final file = File(filePath);

     final List<Map<String, dynamic>> jsonList =
        tasks.map((task) => task.toJson()).toList();

     final String jsonString = jsonEncode(jsonList);

     await file.writeAsString(jsonString);
  }
}