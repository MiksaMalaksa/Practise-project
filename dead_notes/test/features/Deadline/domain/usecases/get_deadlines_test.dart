import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/usecases/no_params.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/get_deadlines.dart';
import 'package:mocktail/mocktail.dart';

import '../../testing_helpers.dart';

class MockDeadlineRepository extends Mock implements IDeadlineRepository {}

void main() {
  final MockDeadlineRepository mockDeadlineRepository = MockDeadlineRepository();
  final GetDeadlines usecase = GetDeadlines(mockDeadlineRepository);

  group('Get notes usecase group', () {
    test(
      'should return list of deadline entities from deadline repository when called successfully',
      () async {
        // arrange
        when(() => mockDeadlineRepository.getDeadlines()).thenAnswer(
          (invocation) async => Right(tDeadlineList),
        );
        // act
        final result = await usecase(NoParams());
        // assert
        verify(() => mockDeadlineRepository.getDeadlines());
        expect(result, Right(tDeadlineList));
      },
    );

    test(
      'should return DataFailure when called unsuccessfully',
      () async {
        // arrange
        when(() => mockDeadlineRepository.getDeadlines()).thenAnswer(
          (invocation) async => Left(DataFailure()),
        );
        // act
        final result = await usecase(NoParams());
        // assert
        verify(() => mockDeadlineRepository.getDeadlines());
        expect(result, Left(DataFailure()));
      },
    );
  });
}