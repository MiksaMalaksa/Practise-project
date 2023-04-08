import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dead_notes/core/exceptions/exceptions.dart';
import 'package:dead_notes/features/Note/data/datasources/local_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing_helpers.dart';

class MockBox extends Mock implements Box {}

void main() {
  final MockBox mockBox = MockBox();
  final LocalDatasource localDatasource = LocalDatasource(mockBox);

  group('Local datasource group', () {
    group('getNotes', () {
      test(
        'should return list of note models and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.values.toList())
              .thenAnswer((invocation) => tNoteModelJsonList);
          // act
          final result = await localDatasource.getNotes();
          // assert
          verify(() => mockBox.values.toList());
          expect(result, tNoteModelList);
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.values.toList())
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.getNotes();
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });

    group('addNote', () {
      test(
        'should return void and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.put(tNoteModel.id, tNoteModel.toJson()))
              .thenAnswer((invocation) async {});
          // act
          await localDatasource.addNote(tNote);
          // assert
          verify(() => mockBox.put(tNoteModel.id, tNoteModel.toJson()));
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.put(tNoteModel.id, tNoteModel.toJson()))
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.addNote(tNote);
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });

    group('deleteNote', () {
      test(
        'should return void and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.delete(tNote.id))
              .thenAnswer((invocation) async {});
          // act
          await localDatasource.deleteNote(tNote.id);
          // assert
          verify(() => mockBox.delete(tNote.id));
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.delete(tNote.id))
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.deleteNote(tNote.id);
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });

    group('editNote', () {
      test(
        'should return void and call box methods when called successfully',
        () async {
          // arrange
          when(() => mockBox.put(tNoteModel.id, tNoteModel.toJson()))
              .thenAnswer((invocation) async {});
          // act
          await localDatasource.editNote(tNote.id, tNote);
          // assert
          verify(() => mockBox.put(tNoteModel.id, tNoteModel.toJson()));
        },
      );

      test(
        'should throw LocalDatabaseException when called unsuccessfully',
        () async {
          // arrange
          when(() => mockBox.put(tNoteModel.id, tNoteModel.toJson()))
              .thenThrow(LocalDatabaseException());
          // act
          call() => localDatasource.editNote(tNote.id, tNote);
          // assert
          expect(call, throwsA(isA<LocalDatabaseException>()));
        },
      );
    });
  });
}
