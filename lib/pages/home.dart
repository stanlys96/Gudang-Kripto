import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gudang_kripto/provider/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
        builder: (secondContext, todoProvider, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Todo List"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Enter your name:',
                ),
                TextField(
                  controller: _nameController,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await _prefs;
                      if (_nameController.text == "") return;
                      await prefs.setString(
                        "user",
                        _nameController.text,
                      );
                      todoProvider.clearTodoList();
                      Navigator.of(context).pushNamed('/todo');
                    },
                    child: Text('Submit')),
              ],
            ),
          ),
        ),
      );
    });
  }
}
