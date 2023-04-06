import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/src/core/failures/data_failure.dart';
import 'package:dead_notes/src/core/failures/invalid_note_failure.dart';
import 'package:dead_notes/src/core/nothing/nothing.dart';
import 'package:dead_notes/src/core/usecases/no_params.dart';
import 'package:dead_notes/src/core/util/input_validator.dart';
import 'package:dead_notes/src/domain/usecases/add_note.dart';
import 'package:dead_notes/src/domain/usecases/delete_note.dart';
import 'package:dead_notes/src/domain/usecases/edit_note.dart';
import 'package:dead_notes/src/domain/usecases/get_notes.dart';
import 'package:dead_notes/src/presentation/blocs/note_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../../testing_helpers.dart';

class MockAddNote extends Mock implements AddNote {}

class MockDeleteNote extends Mock implements DeleteNote {}

class MockEditNote extends Mock implements EditNote {}

class MockGetNotes extends Mock implements GetNotes {}

class MockInputValidator extends Mock implements InputValidator {}

class MockUuid extends Mock implements Uuid {}

void main() {
  final MockAddNote mockAddNote = MockAddNote();
  final MockDeleteNote mockDeleteNote = MockDeleteNote();
  final MockEditNote mockEditNote = MockEditNote();
  final MockGetNotes mockGetNotes = MockGetNotes();
  final MockInputValidator mockInputValidator = MockInputValidator();
  final MockUuid mockUuid = MockUuid();
  NoteBloc bloc = NoteBloc(
    addNote: mockAddNote,
    deleteNote: mockDeleteNote,
    editNote: mockEditNote,
    getNotes: mockGetNotes,
    inputValidator: mockInputValidator,
    uuid: mockUuid,
  );

  setUpAll(() {
    registerFallbackValue(tNote);
    registerFallbackValue(tAddNoteParams);
    registerFallbackValue(tDeleteNoteParams);
    registerFallbackValue(tEditNoteParams);
  });

  setUp(() {
    bloc = NoteBloc(
      addNote: mockAddNote,
      deleteNote: mockDeleteNote,
      editNote: mockEditNote,
      getNotes: mockGetNotes,
      inputValidator: mockInputValidator,
      uuid: mockUuid,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('Note bloc group', () {
    test(
      'should return Empty for initial state',
      () async {
        // assert
        expect(bloc.state, const Empty());
      },
    );

    group('AddNote functionality', () {
      setUp(() {
        bloc = NoteBloc(
          addNote: mockAddNote,
          deleteNote: mockDeleteNote,
          editNote: mockEditNote,
          getNotes: mockGetNotes,
          inputValidator: mockInputValidator,
          uuid: mockUuid,
        );
      });

      tearDown(() {
        bloc.close();
      });
      test(
        'should call for InputValidator when called',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Right(tNote));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
          await untilCalled(() => mockInputValidator.validateNote(any()));
          // assert
          verify(() => mockInputValidator.validateNote(any()));
        },
      );

      test(
        'should emit Error when note data is invalid',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Left(InvalidNoteFailure()));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // assert later
          final expected = [
            const Error(error: inputError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
        },
      );

      test(
        'should call for AddNote usecase when note data is valid',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Right(tNote));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
          await untilCalled(() => mockAddNote(any()));
          // assert
          verify(() => mockAddNote(any()));
        },
      );

      test(
        'should emit Loaded when note data is valid',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Right(tNote));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // assert later
          final expected = [
            Loaded(notes: tNoteList),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
        },
      );

      test(
        'should call for GetNotes when note data is valid',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Right(tNote));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
          await untilCalled(() => mockGetNotes(NoParams()));
          // assert later
          verify(() => mockGetNotes(NoParams()));
        },
      );

      test(
        'should emit get error when GetNotes fails',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Right(tNote));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
        },
      );

      test(
        'should emit add error when AddNote fails',
        () async {
          // arrange
          when(() => mockInputValidator.validateNote(any()))
              .thenAnswer((invocation) => Right(tNote));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddNote(any()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: addError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            AddNoteEvent(title: tNoteTitle, text: tNoteText, color: tNoteColor),
          );
        },
      );
    });

    group('DeleteNote functionality', () {
      test(
        'should call for DeleteNote usecase',
        () async {
          // arrange
          when(() => mockDeleteNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            DeleteNoteEvent(id: tNoteId),
          );
          await untilCalled(() => mockDeleteNote(any()));
          // assert
          verify(() => mockDeleteNote(any()));
        },
      );

      test(
        'should emit Loaded when successfully deleted',
        () async {
          // arrange
          when(() => mockDeleteNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // assert later
          final expected = [
            Loaded(notes: tNoteList),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            DeleteNoteEvent(id: tNoteId),
          );
        },
      );

      test(
        'should call for GetNotes when note was successfully deleted',
        () async {
          // arrange
          when(() => mockDeleteNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            DeleteNoteEvent(id: tNoteId),
          );
          await untilCalled(() => mockGetNotes(NoParams()));
          // assert later
          verify(() => mockGetNotes(NoParams()));
        },
      );

      test(
        'should emit get error when GetNotes fails',
        () async {
          // arrange
          when(() => mockDeleteNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            DeleteNoteEvent(id: tNoteId),
          );
        },
      );

      test(
        'should emit delete error when DeleteNote fails',
        () async {
          // arrange
          when(() => mockDeleteNote(any()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: deleteError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            DeleteNoteEvent(id: tNoteId),
          );
        },
      );
    });

    group('EditNote functionality', () {
      test(
        'should call for EditNote usecase',
        () async {
          // arrange
          when(() => mockEditNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            EditNoteEvent(
              id: tNoteId,
              title: tNoteTitle,
              text: tNoteText,
              color: tNoteColor,
              isFavorite: tNoteIsFavorite,
              creationTime: tNoteDateTime,
            ),
          );
          await untilCalled(() => mockEditNote(any()));
          // assert
          verify(() => mockEditNote(any()));
        },
      );

      test(
        'should call for GetNotes when note was successfully edited',
        () async {
          // arrange
          when(() => mockEditNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            EditNoteEvent(
              id: tNoteId,
              title: tNoteTitle,
              text: tNoteText,
              color: tNoteColor,
              isFavorite: tNoteIsFavorite,
              creationTime: tNoteDateTime,
            ),
          );
          await untilCalled(() => mockGetNotes(NoParams()));
          // assert later
          verify(() => mockGetNotes(NoParams()));
        },
      );

      test(
        'should emit Loaded when successfully edited',
        () async {
          // arrange
          when(() => mockEditNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // assert later
          final expected = [
            Loaded(notes: tNoteList),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            EditNoteEvent(
              id: tNoteId,
              title: tNoteTitle,
              text: tNoteText,
              color: tNoteColor,
              isFavorite: tNoteIsFavorite,
              creationTime: tNoteDateTime,
            ),
          );
        },
      );

      test(
        'should emit get error when GetNotes fails',
        () async {
          // arrange
          when(() => mockEditNote(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            EditNoteEvent(
              id: tNoteId,
              title: tNoteTitle,
              text: tNoteText,
              color: tNoteColor,
              isFavorite: tNoteIsFavorite,
              creationTime: tNoteDateTime,
            ),
          );
        },
      );

      test(
        'should emit edit error when EditNote fails',
        () async {
          // arrange
          when(() => mockEditNote(any()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: editError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            EditNoteEvent(
              id: tNoteId,
              title: tNoteTitle,
              text: tNoteText,
              color: tNoteColor,
              isFavorite: tNoteIsFavorite,
              creationTime: tNoteDateTime,
            ),
          );
        },
      );
    });

    group('GetNotes functionality', () {
      test(
        'should call for GetNotes usecase',
        () async {
          // arrange
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // act
          bloc.add(
            const GetNotesEvent(),
          );
          await untilCalled(() => mockGetNotes(NoParams()));
          // assert
          verify(() => mockGetNotes(NoParams()));
        },
      );

      test(
        'should emit get error when GetNotes fails',
        () async {
          // arrange
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            const GetNotesEvent(),
          );
        },
      );

      test(
        'should emit Loaded when successfully loaded',
        () async {
          // arrange
          when(() => mockGetNotes(NoParams()))
              .thenAnswer((invocation) async => Right(tNoteList));
          // assert later
          final expected = [
            Loaded(notes: tNoteList),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            const GetNotesEvent(),
          );
        },
      );
    });
  });
}
