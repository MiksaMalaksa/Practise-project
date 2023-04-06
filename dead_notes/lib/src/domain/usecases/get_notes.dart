import '../../core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../core/usecases/no_params.dart';
import '../../core/usecases/i_usecase.dart';
import '../entities/note.dart';
import '../repositories/i_note_repository.dart';

/// Business logic: gets all notes
class GetNotes implements IUsecase<List<Note>, NoParams> {
  final INoteRepository repository;

  GetNotes(this.repository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) async {
    return await repository.getNotes();
  }
}
