import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';

class DeadlineModel extends Deadline {
  const DeadlineModel({
    required super.id,
    required super.title,
    required super.text,
    required super.creationTime,
    required super.modificationTime,
    required super.deadlineTime,
    super.finishTime,
    required super.tasks,
    required super.isFavorite,
    required super.color,
  });

 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'creationTime': creationTime.millisecondsSinceEpoch,
      'modificationTime': modificationTime.millisecondsSinceEpoch,
      'deadlineTime': deadlineTime.millisecondsSinceEpoch,
      'finishTime': finishTime?.millisecondsSinceEpoch,
      'tasks': tasks.map((task) => TaskModel.toMap(task)).toList(),
      'isFavorite': isFavorite,
      'color': color.value.toRadixString(16),
    };
  }

  factory DeadlineModel.fromMap(Map<String, dynamic> map) {
    return DeadlineModel(
      id: map['id'] as String,
      title: map['title'] as String,
      text: map['text'] as String,
      creationTime: 
          DateTime.fromMillisecondsSinceEpoch(map['creationTime'] as int),
      modificationTime:
          DateTime.fromMillisecondsSinceEpoch(map['modificationTime'] as int),
      deadlineTime: 
          DateTime.fromMillisecondsSinceEpoch(map['deadlineTime'] as int),
      finishTime: map['finishTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['finishTime'] as int)
          : null,
      tasks: List<Task>.from(
          (map['tasks']).map((taskMap) => TaskModel.fromMap(taskMap))),
      isFavorite: map['isFavorite'] as bool,
      color: Color(int.parse(map['color'] as String, radix: 16)),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeadlineModel.fromJson(String source) =>
      DeadlineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory DeadlineModel.fromDeadline(Deadline deadline) {
    return DeadlineModel(
      id: deadline.id,
      title: deadline.title,
      text: deadline.text,
      creationTime: deadline.creationTime,
      modificationTime: deadline.modificationTime,
      deadlineTime: deadline.deadlineTime,
      finishTime: deadline.finishTime,
      tasks: deadline.tasks,
      isFavorite: deadline.isFavorite,
      color: deadline.color,
    );
  }

}

class TaskModel extends Task {
  const TaskModel({
    required super.text,
    required super.isDone,
  });

  static Map<String, dynamic> toMap(Task task) {
    return {
      'text': task.text,
      'isDone': task.isDone,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Task(
      text: map['text'] as String,
      isDone: map['isDone'] as bool,
    );
  }
}