// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/i_usecase.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';

/// Business logic: Deletes note by id
class DeleteNote implements IUsecase<Nothing, DeleteNoteParams> {
  final INoteRepository repository;

  DeleteNote(this.repository);

  @override
  Future<Either<Failure, Nothing>> call(DeleteNoteParams params) async {
    return await repository.deleteNote(params.noteId);
  }
}

class DeleteNoteParams extends Equatable {
  final String noteId;

  const DeleteNoteParams(this.noteId);

  @override
  List<Object> get props => [noteId];
}
