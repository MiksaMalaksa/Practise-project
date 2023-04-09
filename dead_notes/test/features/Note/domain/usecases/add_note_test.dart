import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';
import 'package:dead_notes/features/Note/domain/usecases/add_note.dart';
import 'package:mocktail/mocktail.dart';

import '../../testing_helpers.dart';

class MockNoteRepository extends Mock implements INoteRepository {}

void main() {
  final MockNoteRepository mockNoteRepository = MockNoteRepository();
  final AddNote usecase = AddNote(mockNoteRepository);

  group('Add note usecase group', () {
    test(
      'should return Nothing and call repository when called successfully',
      () async {
        // arrange
        when(() => mockNoteRepository.addNote(tNote)).thenAnswer(
          (invocation) async => Right(Nothing()),
        );
        // act
        final result = await usecase(AddNoteParams(tNote));
        // assert
        verify(() => mockNoteRepository.addNote(tNote));
        expect(result, Right(Nothing()));
      },
    );

    test(
      'should return DataFailure when called unsuccessfully',
      () async {
        // arrange
        when(() => mockNoteRepository.addNote(tNote)).thenAnswer(
          (invocation) async => Left(DataFailure()),
        );
        // act
        final result = await usecase(AddNoteParams(tNote));
        // assert
        verify(() => mockNoteRepository.addNote(tNote));
        expect(result, Left(DataFailure()));
      },
    );
  });
}
