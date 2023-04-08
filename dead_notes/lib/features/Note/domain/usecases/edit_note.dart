// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/i_usecase.dart';
import 'package:dead_notes/features/Note/domain/entities/note.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';

/// Business logic: changes content of note under id
class EditNote implements IUsecase<Nothing, EditNoteParams> {
  final INoteRepository repository;

  EditNote(this.repository);

  @override
  Future<Either<Failure, Nothing>> call(EditNoteParams params) async {
    return await repository.editNote(params.noteId, params.newNote);
  }
}

class EditNoteParams extends Equatable {
  final String noteId;
  final Note newNote;

  const EditNoteParams(this.noteId, this.newNote);

  @override
  List<Object> get props => [noteId, newNote];
}
