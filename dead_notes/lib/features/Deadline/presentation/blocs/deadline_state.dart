part of 'deadline_bloc.dart';

abstract class DeadlineState extends Equatable {
  const DeadlineState();

  @override
  List<Object> get props => [];
}

class Empty extends DeadlineState {
  const Empty();
}

class Loaded extends DeadlineState {
  final List<Deadline> deadlines;

  const Loaded({
    required this.deadlines,
  });

  @override
  List<Object> get props => [deadlines];
}

class Error extends DeadlineState {
  final String error;

  const Error({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}