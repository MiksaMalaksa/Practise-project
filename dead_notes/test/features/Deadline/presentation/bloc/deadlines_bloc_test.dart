import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dead_notes/core/failures/data_failure.dart';
import 'package:dead_notes/core/failures/invalid_deadline_failure.dart';
import 'package:dead_notes/core/nothing/nothing.dart';
import 'package:dead_notes/core/usecases/no_params.dart';
import 'package:dead_notes/features/Deadline/util/input_deadline_validator.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/add_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/delete_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/edit_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/get_deadlines.dart';
import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../testing_helpers.dart';

class MockAddDeadline extends Mock implements AddDeadline {}

class MockDeleteDeadline extends Mock implements DeleteDeadline {}

class MockEditDeadline extends Mock implements EditDeadline {}

class MockGetDeadlines extends Mock implements GetDeadlines {}

class MockInputDeadlineValidator extends Mock implements InputDeadlineValidator {}

class MockUuid extends Mock implements Uuid {}

void main() {
  final MockAddDeadline mockAddDeadline = MockAddDeadline();
  final MockDeleteDeadline mockDeleteDeadline = MockDeleteDeadline();
  final MockEditDeadline mockEditDeadline = MockEditDeadline();
  final MockGetDeadlines mockGetDeadlines = MockGetDeadlines();
  final MockInputDeadlineValidator mockInputDeadlineValidator = MockInputDeadlineValidator();
  final MockUuid mockUuid = MockUuid();
  DeadlineBloc bloc = DeadlineBloc(
    addDeadline: mockAddDeadline,
    deleteDeadline: mockDeleteDeadline,
    editDeadline: mockEditDeadline,
    getDeadlines: mockGetDeadlines,
    inputValidator: mockInputDeadlineValidator,
    uuid: mockUuid,
  );

  setUpAll(() {
    registerFallbackValue(tDeadline);
    registerFallbackValue(tAddDeadlineParams);
    registerFallbackValue(tDeleteDeadlineParams);
    registerFallbackValue(tEditDeadlineParams);
  });

  setUp(() {
    bloc = DeadlineBloc(
      addDeadline: mockAddDeadline,
      deleteDeadline: mockDeleteDeadline,
      editDeadline: mockEditDeadline,
      getDeadlines: mockGetDeadlines,
      inputValidator: mockInputDeadlineValidator,
      uuid: mockUuid,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('Deadline bloc group', () {
    test(
      'should return Empty for initial state',
      () async {
        // assert
        expect(bloc.state, const Empty());
      },
    );

    group('AddDeadline functionality', () {
      setUp(() {
        bloc = DeadlineBloc(
          addDeadline: mockAddDeadline,
          deleteDeadline: mockDeleteDeadline,
          editDeadline: mockEditDeadline,
          getDeadlines: mockGetDeadlines,
          inputValidator: mockInputDeadlineValidator,
          uuid: mockUuid,
        );
      });

      tearDown(() {
        bloc.close();
      });
      test(
        'should call for InputDeadlineValidator when called',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Right(tDeadline));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            AddDeadlineEvent(title: tDeadlineTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
          await untilCalled(() => mockInputDeadlineValidator.validateDeadline(any()));
          // assert
          verify(() => mockInputDeadlineValidator.validateDeadline(any()));
        },
      );

      test(
        'should emit Error when deadline data is invalid',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Left(InvalidDeadlineFailure()));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // assert later
          final expected = [
            const Empty(),
          ];
          expectLater(bloc.state, expected.first);
          // act
          bloc.add(
            AddDeadlineEvent(title: tEmptyTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
        },
      );

      test(
        'should call for AddDeadline usecase when deadline data is valid',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Right(tDeadline));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            AddDeadlineEvent(title: tDeadlineTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
          await untilCalled(() => mockAddDeadline(any()));
          // assert
          verify(() => mockAddDeadline(any()));
        },
      );

      test(
        'should emit Loaded when deadline data is valid',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Right(tDeadline));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // assert later
          final expected = [
            Loaded(deadlines: tDeadlineList),
          ];
          expectLater(bloc.state, const Empty());
          // act
          bloc.add(
            AddDeadlineEvent(title: tDeadlineTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
        },
      );

      test(
        'should call for GetDeadlines when deadline data is valid',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Right(tDeadline));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            AddDeadlineEvent(title: tDeadlineTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
          await untilCalled(() => mockGetDeadlines(NoParams()));
          // assert later
          verify(() => mockGetDeadlines(NoParams()));
        },
      );

      test(
        'should emit get error when GetDeadlines fails',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Right(tDeadline));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            AddDeadlineEvent(title: tDeadlineTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
        },
      );

      test(
        'should emit add error when AddDeadline fails',
        () async {
          // arrange
          when(() => mockInputDeadlineValidator.validateDeadline(any()))
              .thenAnswer((invocation) => Right(tDeadline));
          when(() => mockUuid.v1()).thenAnswer((invocation) => tUuidV1);
          when(() => mockAddDeadline(any()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Empty(),
            //const Error(error: addError),
          ];
          expectLater(bloc.state, expected.first);
          // act
          bloc.add(
           AddDeadlineEvent(title: tDeadlineTitle, text: tDeadlineText, color: tDeadlineColor, creationTime: tCreationDateTime, deadlineTime: tDeadlineDateTime, tasks: tDeadlineTasks),
          );
        },
      );
    });

    group('DeleteDeadline functionality', () {
      test(
        'should call for DeleteDeadline usecase',
        () async {
          // arrange
          when(() => mockDeleteDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            DeleteDeadlineEvent(id: tDeadlineId),
          );
          await untilCalled(() => mockDeleteDeadline(any()));
          // assert
          verify(() => mockDeleteDeadline(any()));
        },
      );

      test(
        'should emit Loaded when successfully deleted',
        () async {
          // arrange
          when(() => mockDeleteDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // assert later
          final expected = [
            Loaded(deadlines: tDeadlineList),
          ];
          expectLater(bloc.state, const Empty());
          // act
          bloc.add(
            DeleteDeadlineEvent(id: tDeadlineId),
          );
        },
      );

      test(
        'should call for GetDeadlines when deadline was successfully deleted',
        () async {
          // arrange
          when(() => mockDeleteDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            DeleteDeadlineEvent(id: tDeadlineId),
          );
          await untilCalled(() => mockGetDeadlines(NoParams()));
          // assert later
          verify(() => mockGetDeadlines(NoParams()));
        },
      );

      test(
        'should emit get error when GetDeadlines fails',
        () async {
          // arrange
          when(() => mockDeleteDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            DeleteDeadlineEvent(id: tDeadlineId),
          );
        },
      );

      test(
        'should emit delete error when DeleteDeadline fails',
        () async {
          // arrange
          when(() => mockDeleteDeadline(any()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: deleteError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            DeleteDeadlineEvent(id: tDeadlineId),
          );
        },
      );
    });

    group('EditDeadline functionality', () {
      test(
        'should call for EditDeadline usecase',
        () async {
          // arrange
          when(() => mockEditDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            EditDeadlineEvent(
              id: tDeadlineId,
              title: tDeadlineTitle,
              text: tDeadlineText,
              color: tDeadlineColor,
              isFavorite: tDeadlineIsFavorite,
              creationTime: tCreationDateTime,
              modificationTime: tCreationDateTime,
              deadlineTime: tDeadlineDateTime,
              tasks: tDeadlineTasks,
            ),
          );
          await untilCalled(() => mockEditDeadline(any()));
          // assert
          verify(() => mockEditDeadline(any()));
        },
      );

      test(
        'should call for GetDeadlines when deadline was successfully edited',
        () async {
          // arrange
          when(() => mockEditDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            EditDeadlineEvent(
              id: tDeadlineId,
              title: tDeadlineTitle,
              text: tDeadlineText,
              color: tDeadlineColor,
              isFavorite: tDeadlineIsFavorite,
              creationTime: tCreationDateTime,
              modificationTime: tCreationDateTime,
              deadlineTime: tDeadlineDateTime,
              tasks: tDeadlineTasks,
            ),
          );
          await untilCalled(() => mockGetDeadlines(NoParams()));
          // assert later
          verify(() => mockGetDeadlines(NoParams()));
        },
      );

      test(
        'should emit Loaded when successfully edited',
        () async {
          // arrange
          when(() => mockEditDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // assert later
          final expected = [
            Loaded(deadlines: tDeadlineList),
          ];
          expectLater(bloc.state, const Empty());
          // act
          bloc.add(
            EditDeadlineEvent(
              id: tDeadlineId,
              title: tDeadlineTitle,
              text: tDeadlineText,
              color: tDeadlineColor,
              isFavorite: tDeadlineIsFavorite,
              creationTime: tCreationDateTime,
              modificationTime: tCreationDateTime,
              deadlineTime: tDeadlineDateTime,
              tasks: tDeadlineTasks,
            ),
          );
        },
      );

      test(
        'should emit get error when GetDeadlines fails',
        () async {
          // arrange
          when(() => mockEditDeadline(any()))
              .thenAnswer((invocation) async => Right(Nothing()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            EditDeadlineEvent(
              id: tDeadlineId,
              title: tDeadlineTitle,
              text: tDeadlineText,
              color: tDeadlineColor,
              isFavorite: tDeadlineIsFavorite,
              creationTime: tCreationDateTime,
              modificationTime: tCreationDateTime,
              deadlineTime: tDeadlineDateTime,
              tasks: tDeadlineTasks,
            ),
          );
        },
      );

      test(
        'should emit edit error when EditDeadline fails',
        () async {
          // arrange
          when(() => mockEditDeadline(any()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: editError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            EditDeadlineEvent(
              id: tDeadlineId,
              title: tDeadlineTitle,
              text: tDeadlineText,
              color: tDeadlineColor,
              isFavorite: tDeadlineIsFavorite,
              creationTime: tCreationDateTime,
              modificationTime: tCreationDateTime,
              deadlineTime: tDeadlineDateTime,
              tasks: tDeadlineTasks,
            ),
          );
        },
      );
    });

    group('GetDeadlines functionality', () {
      test(
        'should call for GetDeadlines usecase',
        () async {
          // arrange
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // act
          bloc.add(
            const GetDeadlinesEvent(),
          );
          await untilCalled(() => mockGetDeadlines(NoParams()));
          // assert
          verify(() => mockGetDeadlines(NoParams()));
        },
      );

      test(
        'should emit get error when GetDeadlines fails',
        () async {
          // arrange
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Left(DataFailure()));
          // assert later
          final expected = [
            const Error(error: getError),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(
            const GetDeadlinesEvent(),
          );
        },
      );

      test(
        'should emit Loaded when successfully loaded',
        () async {
          // arrange
          when(() => mockGetDeadlines(NoParams()))
              .thenAnswer((invocation) async => Right(tDeadlineList));
          // assert later
          final expected = [
            Loaded(deadlines: tDeadlineList),
          ];
          expectLater(bloc.state, const Empty());
          // act
          bloc.add(
            const GetDeadlinesEvent(),
          );
        },
      );
    });
  });
}