import 'dart:convert';
import 'dart:io';

import '../exceptions/storage_exception.dart';
import '../models/task.dart';
import '../models/urgent_task.dart';

class FileManager {
  static Future<List<Task>> loadTasks(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      return [];
    }

    String content;
    try {
      content = await file.readAsString();
    } on IOException catch (e) {
      throw StorageException('Impossible de lire le fichier: $e');
    }

    if (content.trim().isEmpty) {
      return [];
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(content);
    } on FormatException catch (e) {
      throw StorageException('Fichier JSON invalide: $e');
    }

    if (decoded is! List) {
      return [];
    }

    return decoded
        .map((item) => UrgentTask.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveTasks(String filePath, List<Task> tasks) async {
    final file = File(filePath);

    final List<Map<String, dynamic>> jsonList =
        tasks.map((task) => task.toJson()).toList();

    final String jsonString = jsonEncode(jsonList);

    try {
      await file.create(recursive: true);
      await file.writeAsString(jsonString);
    } on IOException catch (e) {
      throw StorageException('Impossible d\'écrire le fichier: $e');
    }
  }
}