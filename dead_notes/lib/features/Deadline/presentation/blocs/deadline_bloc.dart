import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dead_notes/core/usecases/no_params.dart';
import 'package:uuid/uuid.dart';

import 'package:dead_notes/features/Deadline/util/input_deadline_validator.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/delete_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/edit_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/get_deadlines.dart';

import '../../domain/usecases/add_deadline.dart';

part 'deadline_event.dart';
part 'deadline_state.dart';

const String inputError = 'Title must be not empty';
const String addError = 'Failed to add';
const String deleteError = 'Failed to delete';
const String getError = 'Failed to get';
const String editError = 'Failed to edit';

class DeadlineBloc extends Bloc<DeadlineEvent, DeadlineState> {
  final AddDeadline addDeadline;
  final DeleteDeadline deleteDeadline;
  final EditDeadline editDeadline;
  final GetDeadlines getDeadlines;
  final InputDeadlineValidator inputValidator;
  final Uuid uuid;

  DeadlineBloc({
    required this.addDeadline,
    required this.deleteDeadline,
    required this.editDeadline,
    required this.getDeadlines,
    required this.inputValidator,
    required this.uuid,
  }) : super(const Empty()) {
    on<AddDeadlineEvent>(_onAddDeadlineEvent);
    on<DeleteDeadlineEvent>(_onDeleteDeadlineEvent);
    on<EditDeadlineEvent>(_onEditDeadlineEvent);
    on<GetDeadlinesEvent>(_onGetDeadlinesEvent);
  }

  Future<void> _onAddDeadlineEvent(
      AddDeadlineEvent event, Emitter<DeadlineState> emit) async {
    final newDeadline = Deadline(
      id: uuid.v1(),
      title: event.title,
      text: event.text,
      creationTime: event.creationTime,
      deadlineTime: event.deadlineTime,
      tasks: event.tasks,
      isFavorite: false,
      color: event.color,
    );

    final inputEither = inputValidator.validateDeadline(newDeadline);

    await inputEither.fold(
      (_) async {
        emit(Error(error: inputError));
      },
      (deadline) async {
        final result = await addDeadline(AddDeadlineParams(deadline));

        await result.fold(
          (_) async => emit(const Error(error: addError)),
          (_) async {
            add(const GetDeadlinesEvent());
          },
        );
      },
    );
  }

  Future<void> _onDeleteDeadlineEvent(
      DeleteDeadlineEvent event, Emitter<DeadlineState> emit) async {
    final result = await deleteDeadline(DeleteDeadlineParams(event.id));

    await result.fold(
      (_) async => emit(const Error(error: deleteError)),
      (_) async {
        add(const GetDeadlinesEvent());
      },
    );
  }

  Future<void> _onEditDeadlineEvent(
      EditDeadlineEvent event, Emitter<DeadlineState> emit) async {
    final result = await editDeadline(
      EditDeadlineParams(
        event.id,
        Deadline(
          id: event.id,
          title: event.title,
          text: event.text,
          creationTime: event.creationTime,
          deadlineTime: event.deadlineTime,
          tasks: event.tasks,
          isFavorite: event.isFavorite,
          color: event.color,
        ),
      ),
    );

    await result.fold(
      (_) async => emit(const Error(error: editError)),
      (_) async {
        add(const GetDeadlinesEvent());
      },
    );
  }

  Future<void> _onGetDeadlinesEvent(
      GetDeadlinesEvent event, Emitter<DeadlineState> emit) async {
    final deadlines = await getDeadlines(NoParams());
    deadlines.fold(
      (_) => emit(const Error(error: getError)),
      (deadlines) {
        deadlines.sort(
          (a, b) {
            if (a.isFavorite && !b.isFavorite) {
              return -1;
            } else if (!a.isFavorite && b.isFavorite) {
              return 1;
            } else {
              return b.creationTime.compareTo(a.creationTime);
            }
          },
        );
        deadlines.sort((a, b) {
          if(b.isFavorite) {
            return 1;
          }
          return -1;
        });
        emit(Loaded(deadlines: deadlines));
      },
    );
  }
}