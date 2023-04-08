import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/nothing/nothing.dart';
import '../entities/deadline.dart';

/// Repository for operations with deadlines
abstract class IDeadlineRepository {
  /// Gets all deadlines
  ///
  /// Success: returns list of [Deadline]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, List<Deadline>>> getDeadlines();

  /// Adds new deadline to the deadlines list
  ///
  /// Success: returns [Nothing]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, Nothing>> addDeadline(Deadline deadline);

  /// Deletes deadline by its id
  ///
  /// Success: returns [Nothing]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, Nothing>> deleteDeadline(String deadlineId);

  /// Changes content of deadline by its id
  ///
  /// Success: returns [Nothing]
  /// Failure: returns [DataFailure]
  Future<Either<Failure, Nothing>> editDeadline(
      String deadlineId, Deadline newDeadline);
}
