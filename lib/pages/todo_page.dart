import 'package:flutter/material.dart';
import 'package:gudang_kripto/components/todo_box.dart';
import 'package:gudang_kripto/provider/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoPage extends StatefulWidget {
  static const String routeName = '/todo';
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TodoProvider>(context, listen: false).getUser();
  }

  TextEditingController _todoController = TextEditingController();
  TextEditingController _editController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
        builder: (secondContext, todoProvider, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Todo List"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello ${todoProvider.user}',
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        final SharedPreferences prefs = await _prefs;
                        prefs.remove('user');
                        Navigator.of(context).pushNamed('/home');
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Add Todo List:'),
                TextField(
                  controller: _todoController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_todoController.text == "") return;
                    todoProvider.addTodoList(_todoController.text);
                    _todoController.clear();
                  },
                  child: Text('Add'),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    for (int i = 0; i < todoProvider.todoList.length; i++) ...[
                      TodoBox(
                          todoProvider: todoProvider,
                          i: i,
                          editController: _editController),
                      SizedBox(height: 10),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
