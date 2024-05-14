import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Note.dart';

class NoteModel extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  fetchNotes() async {
    var url = Uri.parse('http://127.0.0.1:8000/note/');
    var response = await http.get(url);
    var notesJson = jsonDecode(response.body) as List;
    _notes = notesJson.map((note) => Note(id: note['id'], title: note['title'], content: note['content'])).toList();
    notifyListeners();
  }

  Future<Note?> createNote(String title, String content) async {
    var url = Uri.parse('http://127.0.0.1:8000/note/create');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      Note newNote = Note(
        id: jsonDecode(response.body)['id'],
        title: title,
        content: content,
      );
      return newNote;
    } else {
      return null;
    }
  }

  deleteNote(Note note) async {
    var url = Uri.parse('http://127.0.0.1:8000/note/${note.id}');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      _notes.remove(note);
      notifyListeners();
    }
  }

}
