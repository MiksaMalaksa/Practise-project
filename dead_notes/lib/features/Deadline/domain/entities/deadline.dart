import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Deadline extends Equatable {
  final String id;

  final String title;
  final String text;
  final DateTime creationTime;
  final DateTime deadlineTime;
  final List<Task> tasks;

  final bool isFavorite;
  final Color color;

  const Deadline({
    required this.id,
    required this.title,
    required this.text,
    required this.creationTime,
    required this.deadlineTime,
    required this.tasks,
    required this.isFavorite,
    required this.color,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      text,
      creationTime,
      deadlineTime,
      tasks,
      isFavorite,
      color,
    ];
  }
}

class Task extends Equatable {
  final String text;
  final bool isDone;

  const Task({
    required this.text,
    required this.isDone,
  });

  @override
  List<Object> get props {
    return [
      text,
      isDone,
    ];
  }
}
