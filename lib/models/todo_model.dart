import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoItem {
  final int id;
  final String date;
  //final String time;
  final String title;
  final String description;
  final Color userColor;
  bool isDone;

  TodoItem({
    required this.id,
    required this.description,
    required this.date,
    //required this.time,
    required this.title,
    required this.userColor,
    this.isDone = false,
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
      date: DateFormat("MMM-dd   hh:mm   a").format(DateTime.now()).toString(),
      title: "Food",
      userColor: Colors.red,
      //time: "09:30",
      //isDone: false,
    ),
    TodoItem(
      id: 2,
      description: "I want to sleep",
      date: DateFormat("MMM-dd   hh:mm   a").format(DateTime.now()).toString(),
      title: "Sleep",
      userColor: Colors.green,
      //time: "10:10",
      //isDone: false,
    ),
    TodoItem(
      id: 3,
      description: "I want to read",
      date: DateFormat("MMM-dd   hh:mm   a").format(DateTime.now()).toString(),
      title: "Read",
      userColor: Colors.blue,
      //time: "10:45",
      //isDone: false,
    ),
  ];

  Color color = Colors.red;

  void addTodoItem({required TodoItem item}) {
    int index = todoItemList.indexWhere((item1) => item1.id == item.id);
    bool isItemInList =
        todoItemList.indexWhere((item1) => item1.id == item.id) >= 0;
    if (isItemInList) {
      todoItemList[index] = item;
    } else {
      todoItemList.add(item);
    }
    notifyListeners();
    // every time when we call this method, notifylisteners will listen the changes
  }

  void removeTodoItem(TodoItem item) {
    todoItemList.remove(item);
    notifyListeners();
  }

  void setDone(TodoItem value) {
    value.isDone = true;
    notifyListeners();
  }

  // void editTodoItem(TodoItem updatedItem) {
  //   int index = todoItemList.indexWhere((item) => item.id == updatedItem.id);
  //   if (index >= 0) {
  //     todoItemList[index] = updatedItem;
  //     notifyListeners();
  //   }
  // }
}
