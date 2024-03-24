import 'package:flutter/material.dart';
import 'package:todo/sql_helper.dart';
import 'package:todo/todo_list.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Todo>>(
              future: DatabaseHelper.getTodoList(),
              builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Todo> todoList = snapshot.data!;
                return TodoList(todoList: todoList);
              },
            ),
          ),
        ],
      ),
    );
  }
}