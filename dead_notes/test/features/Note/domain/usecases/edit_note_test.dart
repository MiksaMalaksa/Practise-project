import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';
import 'package:dead_notes/features/Note/domain/usecases/edit_note.dart';
import 'package:mocktail/mocktail.dart';

import '../../testing_helpers.dart';

class MockNoteRepository extends Mock implements INoteRepository {}

void main() {
  final MockNoteRepository mockNoteRepository = MockNoteRepository();
  final EditNote usecase = EditNote(mockNoteRepository);

  group('Edit note usecase group', () {
    test(
      'should return Nothing and call repository when called successfully',
      () async {
        // arrange
        when(() => mockNoteRepository.editNote(tNoteId, tNote)).thenAnswer(
          (invocation) async => Right(Nothing()),
        );
        // act
        final result = await usecase(EditNoteParams(tNoteId, tNote));
        // assert
        verify(() => mockNoteRepository.editNote(tNoteId, tNote));
        expect(result, Right(Nothing()));
      },
    );

    test(
      'should return DataFailure when called unsuccessfully',
      () async {
        // arrange
        when(() => mockNoteRepository.editNote(tNoteId, tNote)).thenAnswer(
          (invocation) async => Left(DataFailure()),
        );
        // act
        final result = await usecase(EditNoteParams(tNoteId, tNote));
        // assert
        verify(() => mockNoteRepository.editNote(tNoteId, tNote));
        expect(result, Left(DataFailure()));
      },
    );
  });
}
