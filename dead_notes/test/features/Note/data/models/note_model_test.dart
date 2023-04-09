import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/features/Note/data/models/note_model.dart';
import 'package:dead_notes/features/Note/domain/entities/note.dart';

import '../../testing_helpers.dart';

void main() {
  group('NoteModel group', () {
    test(
      'should be subclass of Note',
      () async {
        // arrange
        expect(tNoteModel, isA<Note>());
      },
    );

    test(
      'should return valid NoteModel json representation when toJson is called',
      () async {
        // act
        final result = tNoteModel.toJson();
        // assert
        expect(result, tNoteModelJson);
      },
    );

    test(
      'should return valid NoteModel when fromJson is called',
      () async {
        // act
        final result = NoteModel.fromJson(tNoteModelJson);
        // assert
        expect(result, tNoteModel);
      },
    );

    test(
      'should return valid NoteModel when fromNote is called',
      () async {
        // act
        final result = NoteModel.fromNote(tNote);
        // assert
        expect(result, tNoteModel);
      },
    );
  });
}
