import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dead_notes/features/Deadline/data/models/deadline_model.dart';
import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/add_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/delete_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/edit_deadline.dart';

final tCreationTimeMilliseconds = 1000000;
final tDeadlineTimeMilliseconds = 2 * tCreationTimeMilliseconds;

final tTaskText = 'test_text';
final tTaskIsDone = false;
final tTask = Task(
  text: tTaskText,
  isDone: tTaskIsDone,
);

// Deadline setup
final tDeadlineId = 'test_note_id';
final tDeadlineTitle = 'test_title';
final tDeadlineText = 'test_text';
final tDeadlineDateTime =
    DateTime.fromMillisecondsSinceEpoch(tDeadlineTimeMilliseconds);
final tCreationDateTime =
    DateTime.fromMillisecondsSinceEpoch(tCreationTimeMilliseconds);
final tDeadlineTasks = [tTask];
final tDeadlineIsFavorite = false;
final tDeadlineColor = Colors.black;

final tDeadline = Deadline(
    id: tDeadlineId,
    title: tDeadlineTitle,
    text: tDeadlineText,
    creationTime: tCreationDateTime,
    modificationTime: tCreationDateTime,
    deadlineTime: tDeadlineDateTime,
    tasks: tDeadlineTasks,
    isFavorite: tDeadlineIsFavorite,
    color: tDeadlineColor
);

final tDeadlineList = [tDeadline];

// Model setup
final tDeadlineModelJson = tDeadlineModel.toJson();

// Model impl
final tDeadlineModel = DeadlineModel(
  id: tDeadlineId,
  title: tDeadlineTitle,
  text: tDeadlineText,
  creationTime: tCreationDateTime,
  modificationTime: tCreationDateTime,
  deadlineTime: tDeadlineDateTime,
  tasks: tDeadlineTasks,
  isFavorite: tDeadlineIsFavorite,
  color: tDeadlineColor
);

final tDeadlineModelList = [tDeadlineModel];

// Box setup
final tDeadlineModelJsonList = [tDeadlineModelJson];

// Uuid setup
final tUuidV1 = 'test_uuid_v1';

// Input validator setup
final tEmptyTitle = '';
final tNoTitleDeadline = Deadline(
  id: tDeadlineId,
  title: tEmptyTitle,
  text: tDeadlineText,
  creationTime: tDeadlineDateTime,
  modificationTime: tCreationDateTime,
  deadlineTime: tDeadlineDateTime,
  tasks: tDeadlineTasks,
  isFavorite: tDeadlineIsFavorite,
  color: tDeadlineColor,
);

// Params setup
final tAddDeadlineParams = AddDeadlineParams(tDeadline);
final tDeleteDeadlineParams = DeleteDeadlineParams(tDeadlineId);
final tEditDeadlineParams = EditDeadlineParams(tDeadlineId, tDeadline);
