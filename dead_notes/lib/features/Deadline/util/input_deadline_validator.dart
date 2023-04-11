import 'package:dartz/dartz.dart';
import 'package:dead_notes/core/failures/failure.dart';
import 'package:dead_notes/core/failures/invalid_deadline_failure.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';

class InputDeadlineValidator {
  Either<Failure, Deadline> validateDeadline(Deadline deadline) {
    if (deadline.title.isEmpty) return Left(InvalidDeadlineFailure());
    return Right(deadline);
  }
}