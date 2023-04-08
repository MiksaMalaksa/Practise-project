import '../../../../core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/i_usecase.dart';
import '../entities/deadline.dart';
import '../repositories/i_deadline_repository.dart';

/// Business logic: gets all Deadlines
class GetDeadlines implements IUsecase<List<Deadline>, NoParams> {
  final IDeadlineRepository repository;

  GetDeadlines(this.repository);

  @override
  Future<Either<Failure, List<Deadline>>> call(NoParams params) async {
    return await repository.getDeadlines();
  }
}
