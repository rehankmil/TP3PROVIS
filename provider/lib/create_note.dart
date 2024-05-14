import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_model.dart';

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
                var noteModel = Provider.of<NoteModel>(context, listen: false);
                var newNote = await noteModel.createNote(titleController.text, contentController.text);
                if (newNote != null) {
                  noteModel.addNote(newNote);
                  Navigator.pop(context, true); 
                }
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
