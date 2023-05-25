import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Deadline extends Equatable {
  final String id;

  final String title;
  final String text;
  final DateTime creationTime;
  final DateTime modificationTime;
  final DateTime deadlineTime;
  final DateTime? finishTime;
  final List<Task> tasks;

  final bool isFavorite;
  final Color color;

  const Deadline({
    required this.id,
    required this.title,
    required this.text,
    required this.creationTime,
    required this.modificationTime,
    required this.deadlineTime,
    this.finishTime,
    required this.tasks,
    required this.isFavorite,
    required this.color,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      text,
      creationTime,
      modificationTime,
      deadlineTime,
      finishTime,
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
    this.isDone = false,
  });

  @override
  List<Object> get props {
    return [
      text,
      isDone,
    ];
  }
}
