import 'package:dartz/dartz.dart';

import '../failures/failure.dart';

/// Usecase interface
abstract class IUsecase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}
