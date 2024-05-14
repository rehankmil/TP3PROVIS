import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_list.dart';
import 'note_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => NoteCubit()..fetchNotes(),
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
