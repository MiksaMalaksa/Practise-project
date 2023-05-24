// ignore_for_file: prefer_const_declarations, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:dead_notes/features/Note/data/models/note_model.dart';
import 'package:dead_notes/features/Note/domain/entities/note.dart';
import 'package:dead_notes/features/Note/domain/usecases/add_note.dart';
import 'package:dead_notes/features/Note/domain/usecases/delete_note.dart';
import 'package:dead_notes/features/Note/domain/usecases/edit_note.dart';

// DateTime setup
final tDateTimeMilliseconds = 1000000;

// Note setup
final tNoteId = 'test_note_id';
final tNoteTitle = 'test_title';
final tNoteText = 'test_text';
final tNoteDateTime =
    DateTime.fromMillisecondsSinceEpoch(tDateTimeMilliseconds);
final tNoteIsFavorite = false;
final tNoteColor = Colors.black;
final tCreationTime = DateTime.now();

// Note impl
final tNote = Note(
  id: tNoteId,
  title: tNoteTitle,
  text: tNoteText,
  creationTime: tNoteDateTime,
  isFavorite: tNoteIsFavorite,
  color: tNoteColor,
);

final tNoteList = [tNote];

// Model setup
final tNoteModelJson = tNoteModel.toJson();

// Model impl
final tNoteModel = NoteModel(
  id: tNoteId,
  title: tNoteTitle,
  text: tNoteText,
  creationTime: tNoteDateTime,
  isFavorite: tNoteIsFavorite,
  color: tNoteColor,
);

final tNoteModelList = [tNoteModel];

// Box setup
final tNoteModelJsonList = [tNoteModelJson];

// Input validator setup
final tEmptyTitle = '';
final tNoTitleNote = Note(
  id: tNoteId,
  title: tEmptyTitle,
  text: tNoteText,
  creationTime: tNoteDateTime,
  isFavorite: tNoteIsFavorite,
  color: tNoteColor,
);

// Uuid setup
final tUuidV1 = 'test_uuid_v1';

// Params setup
final tAddNoteParams = AddNoteParams(tNote);
final tDeleteNoteParams = DeleteNoteParams(tNoteId);
final tEditNoteParams = EditNoteParams(tNoteId, tNote);
