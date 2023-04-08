import 'package:hive_flutter/hive_flutter.dart';
import 'package:dead_notes/features/Note/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/features/Note/domain/entities/note.dart';
import 'package:dead_notes/features/Note/data/models/note_model.dart';

/// Local datasource for working with local database Hive
class LocalDatasource implements ILocalDatasource {
  final Box box;

  LocalDatasource(this.box);

  @override
  Future<void> addNote(Note note) async {
    final model = NoteModel.fromNote(note);
    await box.put(model.id, model.toJson());
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await box.delete(noteId);
  }

  @override
  Future<void> editNote(String noteId, Note newNote) async {
    final model = NoteModel.fromNote(newNote);
    await box.put(model.id, model.toJson());
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    final jsonModels = box.values.toList();
    final models = jsonModels.map((e) => NoteModel.fromJson(e)).toList();
    return models;
  }
}
