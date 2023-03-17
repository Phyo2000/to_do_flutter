import 'package:flutter/material.dart';

class TodoItem {
  final int id;
  final IconData icon;
  final String title;
  final String description;

  TodoItem({
    required this.id,
    required this.description,
    required this.icon,
    required this.title,
  });

  @override
  String toString() {
    return title;
  }
}

class ListTodoItem with ChangeNotifier {
  List<TodoItem> todoItemList = [
    TodoItem(
      id: 1,
      description: "I want to eat",
      icon: Icons.lightbulb_outline,
      title: "Food",
    ),
    TodoItem(
      id: 2,
      description: "I want to sleep",
      icon: Icons.bed,
      title: "Sleep",
    ),
    TodoItem(
      id: 3,
      description: "I want to read",
      icon: Icons.menu_book,
      title: "Read",
    ),
  ];

  void addTodoItem({required TodoItem item}) {
    todoItemList.add(item);

    // every time when we call this method, notifylisteners will listen the changes
    notifyListeners();
  }

  void removeTodoItem({required int id}) {
    todoItemList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
