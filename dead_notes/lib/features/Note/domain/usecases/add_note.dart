// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/i_usecase.dart';
import 'package:dead_notes/features/Note/domain/entities/note.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';

/// Business logic: adds new note
class AddNote implements IUsecase<Nothing, AddNoteParams> {
  final INoteRepository repository;

  AddNote(this.repository);

  @override
  Future<Either<Failure, Nothing>> call(AddNoteParams params) async {
    return await repository.addNote(params.note);
  }
}

class AddNoteParams extends Equatable {
  final Note note;

  const AddNoteParams(this.note);

  @override
  List<Object> get props => [note];
}
