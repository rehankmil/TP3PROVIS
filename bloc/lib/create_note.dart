import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_cubit.dart';

class CreateNote extends StatefulWidget {
  CreateNote({Key? key}) : super(key: key);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TP Web Service dan State Management",
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Isi',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<NoteCubit>().createNote(
                  titleController.text,
                  contentController.text,
                );
                Navigator.pop(context, true);
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
