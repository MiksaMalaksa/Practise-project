import 'package:dead_notes/features/Note/data/models/note_model.dart';
import 'package:dead_notes/features/Note/domain/entities/note.dart';

/// Local datasource interface
abstract class ILocalDatasource {
  /// Gets list of NoteModels from local database
  ///
  /// Success: returns [List<NoteModel>]
  /// Failure: throws [LocalDatabaseException]
  Future<List<NoteModel>> getNotes();

  /// Adds new note to local database
  ///
  /// Success: returns [void]
  /// Failure: throws [LocalDatabaseException]
  Future<void> addNote(Note note);

  /// Deletes note by id from local database
  ///
  /// Success: returns [void]
  /// Failure: throws [LocalDatabaseException]
  Future<void> deleteNote(String noteId);

  /// Changes content of note under id in local database
  ///
  /// Success: returns [void]
  /// Failure: throws [LocalDatabaseException]
  Future<void> editNote(String noteId, Note newNote);
}
