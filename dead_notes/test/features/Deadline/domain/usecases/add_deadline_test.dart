import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/add_deadline.dart';
import 'package:mocktail/mocktail.dart';

import '../../testing_helpers.dart';

class MockDeadlineRepository extends Mock implements IDeadlineRepository {}

void main() {
  final MockDeadlineRepository mockDeadlineRepository =
      MockDeadlineRepository();
  final AddDeadline usecase = AddDeadline(mockDeadlineRepository);

  group('Add deadline usecase group', () {
    test(
      'should return Nothing and call repository when called successfully',
      () async {
        // arrange
        when(() => mockDeadlineRepository.addDeadline(tDeadline)).thenAnswer(
          (invocation) async => Right(Nothing()),
        );
        // act
        final result = await usecase(AddDeadlineParams(tDeadline));
        // assert
        verify(() => mockDeadlineRepository.addDeadline(tDeadline));
        expect(result, Right(Nothing()));
      },
    );

    test(
      'should return DataFailure when called unsuccessfully',
      () async {
        // arrange
        when(() => mockDeadlineRepository.addDeadline(tDeadline)).thenAnswer(
          (invocation) async => Left(DataFailure()),
        );
        // act
        final result = await usecase(AddDeadlineParams(tDeadline));
        // assert
        verify(() => mockDeadlineRepository.addDeadline(tDeadline));
        expect(result, Left(DataFailure()));
      },
    );
  });
}
