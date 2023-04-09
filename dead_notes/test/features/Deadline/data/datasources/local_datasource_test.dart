import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dead_notes/core/exceptions/exceptions.dart';
import 'package:dead_notes/features/Deadline/data/datasources/local_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../testing_helpers.dart';

class MockBox extends Mock implements Box {}

void main() {
  final MockBox mockBox = MockBox();
  final LocalDatasource localDatasource = LocalDatasource(mockBox);

  group('Local datasource group', () {
    group('getNotes', () {
      test(
        'should return list of deadline models and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.values.toList())
              .thenAnswer((invocation) => tDeadlineModelJsonList);
          // act
          final result = await localDatasource.getDeadlines();
          // assert
          verify(() => mockBox.values.toList());
          expect(result, tDeadlineModelList);
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.values.toList())
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.getDeadlines();
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });

    group('addDeadline', () {
      test(
        'should return void and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.put(tDeadlineModel.id, tDeadlineModel.toJson()))
              .thenAnswer((invocation) async {});
          // act
          await localDatasource.addDeadline(tDeadline);
          // assert
          verify(() => mockBox.put(tDeadlineModel.id, tDeadlineModel.toJson()));
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.put(tDeadlineModel.id, tDeadlineModel.toJson()))
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.addDeadline(tDeadline);
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });

    group('deleteDeadline', () {
      test(
        'should return void and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.delete(tDeadline.id))
              .thenAnswer((invocation) async {});
          // act
          await localDatasource.deleteDeadline(tDeadline.id);
          // assert
          verify(() => mockBox.delete(tDeadline.id));
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.delete(tDeadline.id))
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.deleteDeadline(tDeadline.id);
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });

    group('editDeadline', () {
      test(
        'should return void and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.put(tDeadlineModel.id, tDeadlineModel.toJson()))
              .thenAnswer((invocation) async {});
          // act
          await localDatasource.editDeadline(tDeadline.id, tDeadline);
          // assert
          verify(() => mockBox.put(tDeadlineModel.id, tDeadlineModel.toJson()));
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.put(tDeadlineModel.id, tDeadlineModel.toJson()))
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.editDeadline(tDeadline.id, tDeadline);
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });
  });
}
