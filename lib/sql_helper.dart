import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String todoTable = 'todo';
final String noteTable = 'note';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $todoTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        completed INTEGER
      )
      ''',
    );

    await db.execute(
      '''
      CREATE TABLE $noteTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT
      )
      ''',
    );
  }

  static Future<List<Todo>> getTodoList() async {
    final Database db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(todoTable);
    return List.generate(maps.length, (index) {
      return Todo(
        id: maps[index]['id'],
        title: maps[index]['title'],
        completed: maps[index]['completed'] == 1 ? true : false,
      );
    });
  }

  static Future<List<Note>> getNoteList() async {
    final Database db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(noteTable);
    return List.generate(maps.length, (index) {
      return Note(
        id: maps[index]['id'],
        content: maps[index]['content'],
        title: maps[index]['title'],
      );
    });
  }

  static Future<void> insertTodoItem(Todo todo) async {
    final Database db = await initDatabase();
    await db.insert(
      todoTable,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertNoteItem(Note note) async {
    final Database db = await initDatabase();
    await db.insert(
      noteTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteTodoItem(int id) async {
    final Database db = await initDatabase();
    await db.delete(
      todoTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteNoteItem(int id) async {
    final Database db = await initDatabase();
    await db.delete(
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Todo {
  final int? id;
  final String title;
  final bool completed;

  Todo({
    this.id,
    required this.title,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
    };
  }
}

class Note {
  final int id;
  final String title;
  final String content;
  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}
