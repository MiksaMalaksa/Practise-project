// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dead_notes/src/core/usecases/no_params.dart';
import 'package:uuid/uuid.dart';

import 'package:dead_notes/src/core/util/input_validator.dart';
import 'package:dead_notes/src/domain/entities/note.dart';
import 'package:dead_notes/src/domain/usecases/delete_note.dart';
import 'package:dead_notes/src/domain/usecases/edit_note.dart';
import 'package:dead_notes/src/domain/usecases/get_notes.dart';

import '../../domain/usecases/add_note.dart';

part 'note_event.dart';
part 'note_state.dart';

const String inputError = 'Title must be not empty';
const String addError = 'Failed to add';
const String deleteError = 'Failed to delete';
const String getError = 'Failed to get';
const String editError = 'Failed to edit';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final AddNote addNote;
  final DeleteNote deleteNote;
  final EditNote editNote;
  final GetNotes getNotes;
  final InputValidator inputValidator;
  final Uuid uuid;

  NoteBloc({
    required this.addNote,
    required this.deleteNote,
    required this.editNote,
    required this.getNotes,
    required this.inputValidator,
    required this.uuid,
  }) : super(const Empty()) {
    on<AddNoteEvent>(_onAddNoteEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<EditNoteEvent>(_onEditNoteEvent);
    on<GetNotesEvent>(_onGetNotesEvent);

    add(const GetNotesEvent());
  }

  Future<void> _onAddNoteEvent(
      AddNoteEvent event, Emitter<NoteState> emit) async {
    final newNote = Note(
      id: uuid.v1(),
      title: event.title,
      text: event.text,
      creationTime: DateTime.now(),
      isFavorite: false,
      color: event.color,
    );

    final inputEither = inputValidator.validateNote(newNote);

    await inputEither.fold(
      (_) async => emit(const Error(error: inputError)),
      (note) async {
        final result = await addNote(AddNoteParams(note));

        await result.fold(
          (_) async => emit(const Error(error: addError)),
          (_) async {
            add(const GetNotesEvent());
          },
        );
      },
    );
  }

  Future<void> _onDeleteNoteEvent(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    final result = await deleteNote(DeleteNoteParams(event.id));

    await result.fold(
      (_) async => emit(const Error(error: deleteError)),
      (_) async {
        add(const GetNotesEvent());
      },
    );
  }

  Future<void> _onEditNoteEvent(
      EditNoteEvent event, Emitter<NoteState> emit) async {
    final result = await editNote(
      EditNoteParams(
        event.id,
        Note(
          id: event.id,
          title: event.title,
          text: event.text,
          creationTime: event.creationTime,
          isFavorite: event.isFavorite,
          color: event.color,
        ),
      ),
    );

    await result.fold(
      (_) async => emit(const Error(error: editError)),
      (_) async {
        add(const GetNotesEvent());
      },
    );
  }

  Future<void> _onGetNotesEvent(
      GetNotesEvent event, Emitter<NoteState> emit) async {
    final notes = await getNotes(NoParams());
    notes.fold(
      (_) => emit(const Error(error: getError)),
      (notes) {
        notes.sort(
          (a, b) {
            if (a.isFavorite && !b.isFavorite) {
              return -1;
            } else if (!a.isFavorite && b.isFavorite) {
              return 1;
            } else {
              return b.creationTime.compareTo(a.creationTime);
            }
          },
        );
        emit(Loaded(notes: notes));
      },
    );
  }
}
