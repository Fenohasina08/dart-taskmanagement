# Dart Task Management CLI

A command-line task management application built in pure Dart (no Flutter), demonstrating object-oriented programming concepts, JSON persistence, and unit testing.

## Features

- Add a task with a title, a priority (`low`, `medium`, `high`), and an optional due date
- List all tasks
- Sort tasks by priority or by due date
- Mark a task as completed
- Delete a task
- Automatic persistence to a local JSON file (`data/tasks.json`), reloaded on the next launch

## Requirements

- Dart SDK `^3.12.2` or higher

## Getting started

Clone the repository and install dependencies:

```bash
git clone https://github.com/Fenohasina08/dart-taskmanagement.git
cd dart-taskmanagement
dart pub get
```

## Running the app

```bash
dart run
```

You will be presented with an interactive menu:

```
--- TASK MENU ---
1. Add task
2. List tasks
3. Sort tasks
4. Complete task
5. Delete task
6. Exit
```

- **Add task**: enter an ID, a title, choose a priority (1-Low, 2-Medium, 3-High), and optionally a due date (`YYYY-MM-DD`, or leave empty)
- **List tasks**: prints all currently stored tasks
- **Sort tasks**: choose to sort by priority (High → Medium → Low) or by due date (earliest first)
- **Complete task**: marks a task as done by its ID
- **Delete task**: removes a task by its ID
- **Exit**: saves all tasks to disk and exits

Tasks are automatically saved to `data/tasks.json` after every change, and reloaded automatically the next time the app starts.

## Running the tests

```bash
dart test
```

This runs the full test suite (unit tests covering models, JSON conversion, the repository, the service layer, and custom exceptions).

To run a single test file:

```bash
dart test test/service_test.dart
```

To run a single test by name:

```bash
dart test --name "sortByPriority"
```

## Project architecture

```
User
  ↓
CLI (bin/dart_taskmanagement.dart)
  ↓
TaskService (lib/services)
  ↓
TaskRepository (lib/repositories)
  ↓
FileManager → data/tasks.json (lib/utils)
```

### Project structure

```
bin/
  dart_taskmanagement.dart     Entry point, CLI menu
lib/
  enums/
    priority.dart               Priority enum (low, medium, high)
  exceptions/
    task_not_found_exception.dart
    invalid_priority_exception.dart
    storage_exception.dart
  interfaces/
    json_serializable.dart      Interface enforcing toJson()
  models/
    task.dart                   Abstract base class
    urgent_task.dart            Concrete Task implementation
  repositories/
    repository.dart              Generic Repository<T> interface
    task_repository.dart         In-memory CRUD storage for tasks
  services/
    task_service.dart            Business logic layer
  utils/
    file_manager.dart            JSON file read/write, error handling
data/
  tasks.json                    Persisted task data
test/
  task_test.dart
  json_test.dart
  repository_test.dart
  service_test.dart
  exception_test.dart
```

## Object-oriented concepts used

- **Abstract class & inheritance**: `Task` is an abstract class; `UrgentTask` extends it
- **Interfaces**: `JsonSerializable` (JSON conversion contract) and `Repository<T>` (generic CRUD contract)
- **Generics**: `Repository<T>` is implemented by `TaskRepository` as `Repository<Task>`
- **Custom exceptions**: `TaskNotFoundException`, `InvalidPriorityException`, and `StorageException`, all handled with `try`/`catch` throughout the app to prevent crashes