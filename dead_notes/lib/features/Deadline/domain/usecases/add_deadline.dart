import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/i_usecase.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';

/// Business logic: adds new Deadline
class AddDeadline implements IUsecase<Nothing, AddDeadlineParams> {
  final IDeadlineRepository repository;

  AddDeadline(this.repository);

  @override
  Future<Either<Failure, Nothing>> call(AddDeadlineParams params) async {
    return await repository.addDeadline(params.deadline);
  }
}

class AddDeadlineParams extends Equatable {
  final Deadline deadline;

  const AddDeadlineParams(this.deadline);

  @override
  List<Object> get props => [deadline];
}
