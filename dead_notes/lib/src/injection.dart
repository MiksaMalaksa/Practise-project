import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dead_notes/src/config/box_setup.dart';
import 'package:dead_notes/src/core/util/input_validator.dart';
import 'package:dead_notes/src/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/src/data/datasources/local_datasource.dart';
import 'package:dead_notes/src/data/repositories/note_repository.dart';
import 'package:dead_notes/src/domain/repositories/i_note_repository.dart';
import 'package:dead_notes/src/domain/usecases/add_note.dart';
import 'package:dead_notes/src/domain/usecases/delete_note.dart';
import 'package:dead_notes/src/domain/usecases/edit_note.dart';
import 'package:dead_notes/src/domain/usecases/get_notes.dart';
import 'package:dead_notes/src/presentation/blocs/note_bloc.dart';
import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // * CORE
  // Utils
  sl.registerSingleton(InputValidator());

  // * EXTERNAL
  // Hive
  await Hive.initFlutter();
  final box = await Hive.openBox(notesBox);
  sl.registerSingleton<Box>(box);

  // Uuid
  sl.registerSingleton<Uuid>(const Uuid());

  // * FEATURES
  // Data sources
  sl.registerSingleton<ILocalDatasource>(LocalDatasource(sl()));

  // Repositories
  sl.registerSingleton<INoteRepository>(NoteRepository(sl()));

  // Use cases
  sl.registerSingleton<AddNote>(AddNote(sl()));
  sl.registerSingleton<DeleteNote>(DeleteNote(sl()));
  sl.registerSingleton<EditNote>(EditNote(sl()));
  sl.registerSingleton<GetNotes>(GetNotes(sl()));

  // BLoC
  sl.registerFactory<NoteBloc>(
    () {
      return NoteBloc(
        addNote: sl(),
        deleteNote: sl(),
        editNote: sl(),
        getNotes: sl(),
        inputValidator: sl(),
        uuid: sl(),
      );
    },
  );
}
