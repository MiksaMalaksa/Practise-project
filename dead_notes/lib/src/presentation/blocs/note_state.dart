// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class Empty extends NoteState {
  const Empty();
}

class Loaded extends NoteState {
  final List<Note> notes;

  const Loaded({
    required this.notes,
  });

  @override
  List<Object> get props => [notes];
}

class Error extends NoteState {
  final String error;

  const Error({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
