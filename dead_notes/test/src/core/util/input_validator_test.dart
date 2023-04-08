import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/invalid_note_failure.dart';
import 'package:dead_notes/core/util/input_validator.dart';

import '../../../testing_helpers.dart';

void main() {
  final InputValidator inputValidator = InputValidator();

  group('Input validator group', () {
    test(
      'should return same note when note is valid',
      () async {
        // act
        final result = inputValidator.validateNote(tNote);
        // assert
        expect(result, Right(tNote));
      },
    );

    test(
      'should return Failure when note has empty title',
      () async {
        // act
        final result = inputValidator.validateNote(tNoTitleNote);
        // assert
        expect(result, Left(InvalidNoteFailure()));
      },
    );
  });
}
