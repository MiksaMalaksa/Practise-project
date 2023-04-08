// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Note entitiy
/// Business logic: main application entity
class Note extends Equatable {
  // Note id
  final String id;

  // Note content
  final String title;
  final String text;
  final DateTime creationTime;

  // Visual setup
  final bool isFavorite;
  final Color color;

  const Note({
    required this.id,
    required this.title,
    required this.text,
    required this.creationTime,
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
      isFavorite,
      color,
    ];
  }
}
