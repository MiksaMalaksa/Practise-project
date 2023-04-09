import 'package:dead_notes/core/exceptions/exceptions.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/features/Deadline/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';

class DeadlineRepository implements IDeadlineRepository {
  final ILocalDatasource localDatasource;

  DeadlineRepository(this.localDatasource);

  @override
  Future<Either<Failure, Nothing>> addDeadline(Deadline deadline) async {
    return _helper(() => localDatasource.addDeadline(deadline));
  }

  @override
  Future<Either<Failure, Nothing>> deleteDeadline(String deadlineId) async {
    return _helper(() => localDatasource.deleteDeadline(deadlineId));
  }

  @override
  Future<Either<Failure, Nothing>> editDeadline(String deadlineId, Deadline newDeadline) async {
    return _helper(() => localDatasource.editDeadline(deadlineId, newDeadline));
  }

  @override
  Future<Either<Failure, List<Deadline>>> getDeadlines() async {
    try {
      final notes = await localDatasource.getDeadlines();
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