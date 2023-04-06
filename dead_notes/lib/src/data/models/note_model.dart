// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:dead_notes/src/domain/entities/note.dart';

/// Note model for Note entity
class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.text,
    required super.creationTime,
    required super.isFavorite,
    required super.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'text': text,
      'creationTime': creationTime.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
      'color': color.value.toRadixString(16),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      title: map['title'] as String,
      text: map['text'] as String,
      creationTime:
          DateTime.fromMillisecondsSinceEpoch(map['creationTime'] as int),
      isFavorite: map['isFavorite'] as bool,
      color: Color(int.parse(map['color'] as String, radix: 16)),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory NoteModel.fromNote(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      text: note.text,
      creationTime: note.creationTime,
      isFavorite: note.isFavorite,
      color: note.color,
    );
  }
}
