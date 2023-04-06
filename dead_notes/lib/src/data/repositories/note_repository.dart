import 'package:dead_notes/src/core/exceptions/exceptions.dart';
import 'package:dead_notes/src/core/failures/data_failure.dart';
import 'package:dead_notes/src/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/src/domain/entities/note.dart';
import 'package:dead_notes/src/core/nothing/nothing.dart';
import 'package:dead_notes/src/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dead_notes/src/domain/repositories/i_note_repository.dart';

class NoteRepository implements INoteRepository {
  final ILocalDatasource localDatasource;

  NoteRepository(this.localDatasource);

  @override
  Future<Either<Failure, Nothing>> addNote(Note note) async {
    return _helper(() => localDatasource.addNote(note));
  }

  @override
  Future<Either<Failure, Nothing>> deleteNote(String noteId) async {
    return _helper(() => localDatasource.deleteNote(noteId));
  }

  @override
  Future<Either<Failure, Nothing>> editNote(String noteId, Note newNote) async {
    return _helper(() => localDatasource.editNote(noteId, newNote));
  }

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final notes = await localDatasource.getNotes();
      return Right(notes);
    } on LocalDatabaseException {
      return Left(DataFailure());
    }
  }

  Future<Either<Failure, Nothing>> _helper(Function callback) async {
    try {
      await callback();
      return Right(Nothing());
    } on LocalDatabaseException {
      return Left(DataFailure());
    }
  }
}
