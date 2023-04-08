import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/exceptions/exceptions.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/features/Note/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/features/Note/data/repositories/note_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing_helpers.dart';

class MockLocalDatasource extends Mock implements ILocalDatasource {}

void main() {
  final MockLocalDatasource mockLocalDatasource = MockLocalDatasource();
  final NoteRepository repository = NoteRepository(mockLocalDatasource);

  group('NoteRepository repository group', () {
    group('getNotes', () {
      test(
        'should return list of note models when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.getNotes())
              .thenAnswer((invocation) async => tNoteModelList);
          // act
          final result = await repository.getNotes();
          // assert
          verify(() => mockLocalDatasource.getNotes());
          expect(result, Right(tNoteModelList));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.getNotes())
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.getNotes();
          // assert
          verify(() => mockLocalDatasource.getNotes());
          expect(result, Left(DataFailure()));
        },
      );
    });

    group('addNote', () {
      test(
        'should return Nothing when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.addNote(tNote))
              .thenAnswer((invocation) async {});
          // act
          final result = await repository.addNote(tNote);
          // assert
          verify(() => mockLocalDatasource.addNote(tNote));
          expect(result, Right(Nothing()));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.addNote(tNote))
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.addNote(tNote);
          // assert
          verify(() => mockLocalDatasource.addNote(tNote));
          expect(result, Left(DataFailure()));
        },
      );
    });

    group('deleteNote', () {
      test(
        'should return Nothing when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.deleteNote(tNoteId))
              .thenAnswer((invocation) async {});
          // act
          final result = await repository.deleteNote(tNoteId);
          // assert
          verify(() => mockLocalDatasource.deleteNote(tNoteId));
          expect(result, Right(Nothing()));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.deleteNote(tNoteId))
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.deleteNote(tNoteId);
          // assert
          verify(() => mockLocalDatasource.deleteNote(tNoteId));
          expect(result, Left(DataFailure()));
        },
      );
    });

    group('editNote', () {
      test(
        'should return Nothing when called successfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.editNote(tNoteId, tNote))
              .thenAnswer((invocation) async {});
          // act
          final result = await repository.editNote(tNoteId, tNote);
          // assert
          verify(() => mockLocalDatasource.editNote(tNoteId, tNote));
          expect(result, Right(Nothing()));
        },
      );

      test(
        'should return data failure when called unsuccessfully',
        () async {
          // arrange
          when(() => mockLocalDatasource.editNote(tNoteId, tNote))
              .thenThrow(LocalDatabaseException());
          // act
          final result = await repository.editNote(tNoteId, tNote);
          // assert
          verify(() => mockLocalDatasource.editNote(tNoteId, tNote));
          expect(result, Left(DataFailure()));
        },
      );
    });
  });
}
