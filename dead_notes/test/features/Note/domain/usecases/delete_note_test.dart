import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';
import 'package:dead_notes/features/Note/domain/usecases/delete_note.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing_helpers.dart';

class MockNoteRepository extends Mock implements INoteRepository {}

void main() {
  final MockNoteRepository mockNoteRepository = MockNoteRepository();
  final DeleteNote usecase = DeleteNote(mockNoteRepository);

  group('Delete note usecase group', () {
    test(
      'should return Nothing and call repository when called successfully',
      () async {
        // arrange
        when(() => mockNoteRepository.deleteNote(tNoteId)).thenAnswer(
          (invocation) async => Right(Nothing()),
        );
        // act
        final result = await usecase(DeleteNoteParams(tNoteId));
        // assert
        verify(() => mockNoteRepository.deleteNote(tNoteId));
        expect(result, Right(Nothing()));
      },
    );

    test(
      'should return DataFailure when called unsuccessfully',
      () async {
        // arrange
        when(() => mockNoteRepository.deleteNote(tNoteId)).thenAnswer(
          (invocation) async => Left(DataFailure()),
        );
        // act
        final result = await usecase(DeleteNoteParams(tNoteId));
        // assert
        verify(() => mockNoteRepository.deleteNote(tNoteId));
        expect(result, Left(DataFailure()));
      },
    );
  });
}
