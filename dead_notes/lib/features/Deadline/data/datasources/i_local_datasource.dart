import 'package:dead_notes/features/Deadline/data/models/deadline_model.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';

/// Local datasource interface
abstract class ILocalDatasource {
  /// Gets list of DeadlineModels from local database
  ///
  /// Success: returns [List<DeadlineModel>]
  /// Failure: throws [LocalDatabaseException]
  Future<List<DeadlineModel>> getDeadlines();

  /// Adds new deadline to local database
  ///
  /// Success: returns [void]
  /// Failure: throws [LocalDatabaseException]
  Future<void> addDeadline(Deadline deadline);

  /// Deletes deadline by id from local database
  ///
  /// Success: returns [void]
  /// Failure: throws [LocalDatabaseException]
  Future<void> deleteDeadline(String deadlineId);

  /// Changes content of deadline under id in local database
  ///
  /// Success: returns [void]
  /// Failure: throws [LocalDatabaseException]
  Future<void> editDeadline(String deadlineId, Deadline newDeadline);
}
