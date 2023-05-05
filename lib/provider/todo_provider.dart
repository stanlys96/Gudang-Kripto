import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<String> todoList = [];

  String user = "";

  Future<void> getUser() async {
    final SharedPreferences prefs = await _prefs;
    user = prefs.getString("user") ?? "";
    notifyListeners();
  }

  void clearTodoList() {
    todoList.clear();
    notifyListeners();
  }

  void addTodoList(String value) {
    todoList.add(value);
    notifyListeners();
  }

  void removeTodoList(int index) {
    todoList.removeAt(index);
    notifyListeners();
  }

  void editTodoList(int index, String value) {
    todoList[index] = value;
    notifyListeners();
  }
}
