import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/usecases/no_params.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';
import 'package:dead_notes/features/Note/domain/usecases/get_notes.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing_helpers.dart';

class MockNoteRepository extends Mock implements INoteRepository {}

void main() {
  final MockNoteRepository mockNoteRepository = MockNoteRepository();
  final GetNotes usecase = GetNotes(mockNoteRepository);

  group('Get notes usecase group', () {
    test(
      'should return list of note entities from note repository when called successfully',
      () async {
        // arrange
        when(() => mockNoteRepository.getNotes()).thenAnswer(
          (invocation) async => Right(tNoteList),
        );
        // act
        final result = await usecase(NoParams());
        // assert
        verify(() => mockNoteRepository.getNotes());
        expect(result, Right(tNoteList));
      },
    );

    test(
      'should return DataFailure when called unsuccessfully',
      () async {
        // arrange
        when(() => mockNoteRepository.getNotes()).thenAnswer(
          (invocation) async => Left(DataFailure()),
        );
        // act
        final result = await usecase(NoParams());
        // assert
        verify(() => mockNoteRepository.getNotes());
        expect(result, Left(DataFailure()));
      },
    );
  });
}
