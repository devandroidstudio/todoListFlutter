import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todolistappp/app/data/models/task.dart';
import 'package:todolistappp/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodo = <dynamic>[].obs;
  final doneTodo = <dynamic>[].obs;
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
    editController.dispose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodo.clear();
    doneTodo.clear();
    for (var i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodo.add(todo);
      } else {
        doingTodo.add(todo);
      }
    }
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodo, ...doneTodo]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodo.any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodoCurrent = {'title': title, 'done': true};
    if (doneTodo.any(
        (element) => mapEquals<String, dynamic>(doneTodoCurrent, element))) {
      return false;
    }
    doingTodo.add(todo);
    return true;
  }

  void doneTodoFunction(String title) {
    var doingTodoCurrent = {'title': title, 'done': false};
    int index = doingTodo.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodoCurrent, element));
    doingTodo.removeAt(index);
    var doneTodoCurrent = {'title': title, 'done': true};
    doneTodo.add(doneTodoCurrent);
    doingTodo.refresh();
    doneTodo.refresh();
  }
}
