import 'package:flutter/material.dart';
import 'package:todo/sql_helper.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todoList;

  const TodoList({required this.todoList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        Todo todo = todoList[index];
        return ListTile(
          title: Text(todo.title),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // DatabaseHelper.deleteTodoItem(todo.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Todo deleted')),
              );
            },
          ),
        );
      },
    );
  }
}
