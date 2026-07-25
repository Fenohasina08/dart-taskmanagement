import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_taskmanagement/exceptions/task_not_found_exception.dart';
import 'package:dart_taskmanagement/models/task.dart';
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

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();

  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('dart_taskmanagement version: $version');
      return;
    }
    if (results.flag('verbose')) {
      verbose = true;
    }

    print('Positional arguments: ${results.rest}');
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }

  final service = TaskService();
  await service.loadTasks();

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
          final newTask = Task(id: id, title: title);
          service.addTask(newTask);
          await service.saveTasks();
          print('Task added successfully!');
        } else {
          print('Invalid input.');
        }
        break;

      case '2':
        service.displayAllTasks();
        break;

      case '3':
        print('1. Sort by priority');
        print('2. Sort by due date');
        stdout.write('Choose sorting option: ');
        String? sortChoice = stdin.readLineSync();

        if (sortChoice == '1') {
          final sorted = service.sortByPriority();
          for (var task in sorted) {
            print(task.getDetails());
          }
        } else if (sortChoice == '2') {
          final sorted = service.sortByDueDate();
          for (var task in sorted) {
            print(task.getDetails());
          }
        }
        break;

      case '4':
        service.displayAllTasks();
        stdout.write('Enter task ID to mark as completed: ');
        String? id = stdin.readLineSync();

        if (id != null && id.isNotEmpty) {
          try {
            service.markAsCompleted(id);
            await service.saveTasks();
            print('Task marked as completed!');
          } on TaskNotFoundException {
            print('Error: Task not found.');
          }
        }
        break;

      case '5':
        service.displayAllTasks();
        stdout.write('Enter task ID to delete: ');
        String? id = stdin.readLineSync();

        if (id != null && id.isNotEmpty) {
          try {
            service.deleteTaskById(id);
            await service.saveTasks();
            print('Task deleted successfully!');
          } on TaskNotFoundException {
            print('Error: Task not found.');
          }
        }
        break;

      case '6':
        isRunning = false;
        print('Exiting the program.');
        await service.saveTasks();
        break;

      default:
        print('Invalid choice. Please try again.');
    }
  }
}