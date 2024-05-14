import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'note.dart';

// Define the state
abstract class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

class NoteError extends NoteState {}

// Define the Cubit
class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  Future<void> fetchNotes() async {
    emit(NoteLoading());
    try {
      var url = Uri.parse('http://127.0.0.1:8000/note/');
      var response = await http.get(url);
      var notesJson = jsonDecode(response.body) as List;
      List<Note> notes = notesJson.map((note) => Note.fromJson(note)).toList();
      emit(NoteLoaded(notes));
    } catch (_) {
      emit(NoteError());
    }
  }

  Future<void> createNote(String title, String content) async {
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
      fetchNotes();
    } else {
      emit(NoteError());
    }
  }

  Future<void> deleteNote(int id) async {
    var url = Uri.parse('http://127.0.0.1:8000/note/$id');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      fetchNotes();
    } else {
      emit(NoteError());
    }
  }
}
