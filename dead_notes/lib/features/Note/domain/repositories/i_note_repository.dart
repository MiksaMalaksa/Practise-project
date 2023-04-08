import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/nothing/nothing.dart';
import '../entities/note.dart';

/// Repository for operations with notes
abstract class INoteRepository {
  /// Gets all notes
  ///
  /// Success: returns list of [Note]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, List<Note>>> getNotes();

  /// Adds new note to the notes list
  ///
  /// Success: returns [Nothing]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, Nothing>> addNote(Note note);

  /// Deletes note by its id
  ///
  /// Success: returns [Nothing]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, Nothing>> deleteNote(String noteId);

  /// Changes content of note by its id
  ///
  /// Success: returns [Nothing]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, Nothing>> editNote(String noteId, Note newNote);
}
