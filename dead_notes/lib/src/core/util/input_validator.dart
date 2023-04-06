import 'package:dartz/dartz.dart';
import 'package:dead_notes/src/core/failures/failure.dart';
import 'package:dead_notes/src/core/failures/invalid_note_failure.dart';
import 'package:dead_notes/src/domain/entities/note.dart';

class InputValidator {
  Either<Failure, Note> validateNote(Note note) {
    if (note.title.isEmpty) return Left(InvalidNoteFailure());
    return Right(note);
  }
}
