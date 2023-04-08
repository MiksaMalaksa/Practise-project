import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/i_usecase.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';

/// Business logic: changes content of Deadline under id
class EditDeadline implements IUsecase<Nothing, EditDeadlineParams> {
  final IDeadlineRepository repository;

  EditDeadline(this.repository);

  @override
  Future<Either<Failure, Nothing>> call(EditDeadlineParams params) async {
    return await repository.editDeadline(params.deadlineId, params.newDeadline);
  }
}

class EditDeadlineParams extends Equatable {
  final String deadlineId;
  final Deadline newDeadline;

  const EditDeadlineParams(this.deadlineId, this.newDeadline);

  @override
  List<Object> get props => [deadlineId, newDeadline];
}
