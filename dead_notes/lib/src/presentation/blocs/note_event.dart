// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String text;
  final Color color;

  const AddNoteEvent({
    required this.title,
    required this.text,
    required this.color,
  });

  @override
  List<Object> get props => [title, text, color];
}

class DeleteNoteEvent extends NoteEvent {
  final String id;

  const DeleteNoteEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class EditNoteEvent extends NoteEvent {
  final String id;
  final String title;
  final String text;
  final Color color;
  final bool isFavorite;
  final DateTime creationTime;

  const EditNoteEvent({
    required this.id,
    required this.title,
    required this.text,
    required this.color,
    required this.isFavorite,
    required this.creationTime,
  });

  @override
  List<Object> get props => [id, title, text, color];
}

class GetNotesEvent extends NoteEvent {
  const GetNotesEvent();
}
