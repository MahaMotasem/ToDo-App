import 'package:flutter/material.dart';
import 'package:todo/sql_helper.dart';


class NotesList extends StatelessWidget {
  final List<Note> noteList;

  const NotesList({required this.noteList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (context, index) {
        Note note = noteList[index];
        return ListTile(
          title: Text(note.content),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DatabaseHelper.deleteNoteItem(note.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note deleted'),),
              );
            },
          ),
        );
      },
    );
  }
}