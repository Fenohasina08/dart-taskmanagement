import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_taskmanagement/enums/priority.dart';
import 'package:dart_taskmanagement/exceptions/storage_exception.dart';
import 'package:dart_taskmanagement/exceptions/task_not_found_exception.dart';
import 'package:dart_taskmanagement/models/urgent_task.dart';
import 'package:dart_taskmanagement/services/task_service.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart dart_taskmanagement.dart <flags> [arguments]');
  print(argParser.usage);
}

Priority askPriority() {
  print('1. Low');
  print('2. Medium');
  print('3. High');
  stdout.write('Choose priority: ');
  final choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      return Priority.low;
    case '2':
      return Priority.medium;
    case '3':
      return Priority.high;
    default:
      return Priority.high;
  }
}

DateTime? askDueDate() {
  stdout.write('Enter due date (YYYY-MM-DD) or leave empty: ');
  final input = stdin.readLineSync();
  if (input == null || input.trim().isEmpty) {
    return null;
  }
  try {
    return DateTime.parse(input.trim());
  } on FormatException {
    print('Invalid date format, due date ignored.');
    return null;
  }
}

void printTaskList(List<String> lines) {
  if (lines.isEmpty) {
    print('No tasks found.');
    return;
  }
  for (var line in lines) {
    print(line);
  }
}

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();

  try {
    final ArgResults results = argParser.parse(arguments);

    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('dart_taskmanagement version: $version');
      return;
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
    return;
  }

  final service = TaskService();

  try {
    await service.loadTasks();
  } on StorageException catch (e) {
    print(e.toString());
  }

  bool isRunning = true;

  while (isRunning) {
    print('\n--- TASK MENU ---');
    print('1. Add task');
    print('2. List tasks');
    print('3. Sort tasks');
    print('4. Complete task');
    print('5. Delete task');
    print('6. Exit');
    stdout.write('Your choice: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter task ID: ');
        String? id = stdin.readLineSync();
        stdout.write('Enter task title: ');
        String? title = stdin.readLineSync();

        if (id != null && id.isNotEmpty && title != null && title.isNotEmpty) {
          final priority = askPriority();
          final dueDate = askDueDate();
          final newTask = UrgentTask(
            id: id,
            title: title,
            priority: priority,
            dueDate: dueDate,
          );

          try {
            service.addTask(newTask);
            await service.saveTasks();
            print('Task added successfully!');
          } on StorageException catch (e) {
            print(e.toString());
          }
        } else {
          print('Invalid input.');
        }
        break;

      case '2':
        printTaskList(service.listTaskDetails());
        break;

      case '3':
        print('1. Sort by priority');
        print('2. Sort by due date');
        stdout.write('Choose sorting option: ');
        String? sortChoice = stdin.readLineSync();

        if (sortChoice == '1') {
          final sorted = service.sortByPriority();
          printTaskList(sorted.map((task) => task.getDetails()).toList());
        } else if (sortChoice == '2') {
          final sorted = service.sortByDueDate();
          printTaskList(sorted.map((task) => task.getDetails()).toList());
        }
        break;

      case '4':
        printTaskList(service.listTaskDetails());
        stdout.write('Enter task ID to mark as completed: ');
        String? id = stdin.readLineSync();

        if (id != null && id.isNotEmpty) {
          try {
            service.markAsCompleted(id);
            await service.saveTasks();
            print('Task marked as completed!');
          } on TaskNotFoundException {
            print('Error: Task not found.');
          } on StorageException catch (e) {
            print(e.toString());
          }
        }
        break;

      case '5':
        printTaskList(service.listTaskDetails());
        stdout.write('Enter task ID to delete: ');
        String? id = stdin.readLineSync();

        if (id != null && id.isNotEmpty) {
          try {
            service.deleteTaskById(id);
            await service.saveTasks();
            print('Task deleted successfully!');
          } on TaskNotFoundException {
            print('Error: Task not found.');
          } on StorageException catch (e) {
            print(e.toString());
          }
        }
        break;

      case '6':
        isRunning = false;
        print('Exiting the program.');
        try {
          await service.saveTasks();
        } on StorageException catch (e) {
          print(e.toString());
        }
        break;

      default:
        print('Invalid choice. Please try again.');
    }
  }
}