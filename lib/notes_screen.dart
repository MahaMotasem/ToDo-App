import 'package:flutter/material.dart';
import 'package:todo/notes_list.dart';
import 'package:todo/sql_helper.dart';


class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Note>>(
              future: DatabaseHelper.getNoteList(),
              builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Note> noteList = snapshot.data!;
                return NotesList(noteList: noteList);
              },
            ),
          ),
        ],
      ),
    );
  }
}