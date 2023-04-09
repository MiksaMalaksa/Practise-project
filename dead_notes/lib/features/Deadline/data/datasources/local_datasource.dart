import 'package:hive_flutter/hive_flutter.dart';
import 'package:dead_notes/features/Deadline/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/data/models/deadline_model.dart';

/// Local datasource for working with local database Hive
class LocalDatasource implements ILocalDatasource {
  final Box box;

  LocalDatasource(this.box);

  @override
  Future<void> addDeadline(Deadline deadline) async {
    final model = DeadlineModel.fromDeadline(deadline);
    await box.put(model.id, model.toJson());
  }

  @override
  Future<void> deleteDeadline(String deadlineId) async {
    await box.delete(deadlineId);
  }

  @override
  Future<void> editDeadline(String deadlineId, Deadline newDeadline) async {
    final model = DeadlineModel.fromDeadline(newDeadline);
    await box.put(model.id, model.toJson());
  }

  @override
  Future<List<DeadlineModel>> getDeadlines() async {
    final jsonModels = box.values.toList();
    final models = jsonModels.map((e) => DeadlineModel.fromJson(e)).toList();
    return models;
  }
}