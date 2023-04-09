import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/exceptions/exceptions.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/features/Deadline/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/features/Deadline/data/repositories/deadline_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../testing_helpers.dart';

class MockLocalDatasource extends Mock implements ILocalDatasource {}

void main() {
  final MockLocalDatasource mockLocalDatasource = MockLocalDatasource();
  final DeadlineRepository repository = DeadlineRepository(mockLocalDatasource);

  group('DeadlineRepository repository group', () {
    group('getNotes', () {
      test(
        'should return list of deadline models when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.getDeadlines())
              .thenAnswer((invocation) async => tDeadlineModelList);
          // act
          final result = await repository.getDeadlines();
          // assert
          verify(() => mockLocalDatasource.getDeadlines());
          expect(result, Right(tDeadlineModelList));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.getDeadlines())
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.getDeadlines();
          // assert
          verify(() => mockLocalDatasource.getDeadlines());
          expect(result, Left(DataFailure()));
        },
      );
    });

    group('addDeadline', () {
      test(
        'should return Nothing when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.addDeadline(tDeadline))
              .thenAnswer((invocation) async {});
          // act
          final result = await repository.addDeadline(tDeadline);
          // assert
          verify(() => mockLocalDatasource.addDeadline(tDeadline));
          expect(result, Right(Nothing()));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.addDeadline(tDeadline))
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.addDeadline(tDeadline);
          // assert
          verify(() => mockLocalDatasource.addDeadline(tDeadline));
          expect(result, Left(DataFailure()));
        },
      );
    });

    group('deleteDeadline', () {
      test(
        'should return Nothing when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.deleteDeadline(tDeadlineId))
              .thenAnswer((invocation) async {});
          // act
          final result = await repository.deleteDeadline(tDeadlineId);
          // assert
          verify(() => mockLocalDatasource.deleteDeadline(tDeadlineId));
          expect(result, Right(Nothing()));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.deleteDeadline(tDeadlineId))
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.deleteDeadline(tDeadlineId);
          // assert
          verify(() => mockLocalDatasource.deleteDeadline(tDeadlineId));
          expect(result, Left(DataFailure()));
        },
      );
    });

    group('editDeadline', () {
      test(
        'should return Nothing when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.editDeadline(tDeadlineId, tDeadline))
              .thenAnswer((invocation) async {});
          // act
          final result = await repository.editDeadline(tDeadlineId, tDeadline);
          // assert
          verify(() => mockLocalDatasource.editDeadline(tDeadlineId, tDeadline));
          expect(result, Right(Nothing()));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.editDeadline(tDeadlineId, tDeadline))
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.editDeadline(tDeadlineId, tDeadline);
          // assert
          verify(() => mockLocalDatasource.editDeadline(tDeadlineId, tDeadline));
          expect(result, Left(DataFailure()));
        },
      );
    });
  });
}