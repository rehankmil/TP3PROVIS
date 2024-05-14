import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_note.dart';
import 'note_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteModel()..fetchNotes(),
      child: NoteApp(),
    ),
  );
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List notes = [];

  @override
  void initState() {
    super.initState();
    // Tidak perlu memanggil fetchNotes di sini
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Memanggil fetchNotes ketika dependensi berubah
    Provider.of<NoteModel>(context, listen: false).fetchNotes();
  }


  @override
Widget build(BuildContext context) {
  //Dapatkan instance NoteModel
  var noteModel = Provider.of<NoteModel>(context);
  return Scaffold(
    appBar: AppBar(
        title: Text("TP Web Service dan State Management",
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
    body: ListView.builder(
      itemCount: noteModel.notes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Note ${index + 1}'),
                Text(noteModel.notes[index].title),
              ],
            ),
            subtitle: Text(noteModel.notes[index].content),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                noteModel.deleteNote(noteModel.notes[index]);
              },
            ),
          ),
        );
      },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNote()),
          );
          if (result == true) {
              Provider.of<NoteModel>(context, listen: false).fetchNotes();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
