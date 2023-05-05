import 'package:flutter/material.dart';
import 'package:gudang_kripto/provider/todo_provider.dart';

class TodoBox extends StatelessWidget {
  final int i;
  final TextEditingController editController;
  final TodoProvider todoProvider;

  TodoBox({
    super.key,
    required this.todoProvider,
    required this.i,
    required this.editController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              todoProvider.todoList[i],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Enter Value'),
                      content: Container(
                        height: 120.0,
                        child: Column(
                          children: [
                            TextField(
                              controller: editController,
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                if (editController.text == "") return;
                                todoProvider.editTodoList(
                                    i, editController.text);
                                editController.clear();
                                Navigator.pop(context);
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Text('Edit'),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  todoProvider.removeTodoList(i);
                },
                child: Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
