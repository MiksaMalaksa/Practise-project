import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/i_usecase.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';

/// Business logic: Deletes Deadline by id
class DeleteDeadline implements IUsecase<Nothing, DeleteDeadlineParams> {
  final IDeadlineRepository repository;

  DeleteDeadline(this.repository);

  @override
  Future<Either<Failure, Nothing>> call(DeleteDeadlineParams params) async {
    return await repository.deleteDeadline(params.deadlineId);
  }
}

class DeleteDeadlineParams extends Equatable {
  final String deadlineId;

  const DeleteDeadlineParams(this.deadlineId);

  @override
  List<Object> get props => [deadlineId];
}
