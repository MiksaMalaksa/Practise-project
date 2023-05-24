import 'package:dead_notes/features/Deadline/config/box_setup.dart';
import 'package:dead_notes/features/Deadline/data/repositories/deadline_repository.dart';
import 'package:dead_notes/features/Deadline/domain/repositories/i_deadline_repository.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/add_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/delete_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/edit_deadline.dart';
import 'package:dead_notes/features/Deadline/domain/usecases/get_deadlines.dart';
import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:dead_notes/features/Deadline/util/input_deadline_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dead_notes/features/Note/config/box_setup.dart';
import 'package:dead_notes/features/Note/util/input_validator.dart';
import 'package:dead_notes/features/Note/data/datasources/i_local_datasource.dart';
import 'package:dead_notes/features/Note/data/datasources/local_datasource.dart';
import 'package:dead_notes/features/Deadline/data/datasources/i_local_datasource.dart' as dl;
import 'package:dead_notes/features/Deadline//data/datasources/local_datasource.dart' as dl;
import 'package:dead_notes/features/Note/data/repositories/note_repository.dart';
import 'package:dead_notes/features/Note/domain/repositories/i_note_repository.dart';
import 'package:dead_notes/features/Note/domain/usecases/add_note.dart';
import 'package:dead_notes/features/Note/domain/usecases/delete_note.dart';
import 'package:dead_notes/features/Note/domain/usecases/edit_note.dart';
import 'package:dead_notes/features/Note/domain/usecases/get_notes.dart';
import 'package:dead_notes/features/Note/presentation/blocs/note_bloc.dart';
import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // * CORE
  // Utils
  sl.registerSingleton(InputValidator());
  sl.registerSingleton(InputDeadlineValidator());

  // * EXTERNAL
  // Hive
  await Hive.initFlutter();
  final box1 = await Hive.openBox(notesBox);
  sl.registerSingleton<Box>(box1, instanceName: 'note');
  final box2 = await Hive.openBox(deadlinesBox);
  sl.registerSingleton<Box>(box2, instanceName: 'deadline');

  // Uuid
  sl.registerSingleton<Uuid>(const Uuid());

  // * FEATURES
  // Data sources
  sl.registerSingleton<ILocalDatasource>(LocalDatasource(sl.get<Box>(instanceName: 'note')));
  sl.registerSingleton<dl.ILocalDatasource>(dl.LocalDatasource(sl.get<Box>(instanceName: 'deadline')));

  // Repositories
  sl.registerSingleton<INoteRepository>(NoteRepository(sl()));
  sl.registerSingleton<IDeadlineRepository>(DeadlineRepository(sl()));

  // Use cases
  sl.registerSingleton<AddNote>(AddNote(sl()));
  sl.registerSingleton<DeleteNote>(DeleteNote(sl()));
  sl.registerSingleton<EditNote>(EditNote(sl()));
  sl.registerSingleton<GetNotes>(GetNotes(sl()));

  sl.registerSingleton<AddDeadline>(AddDeadline(sl()));
  sl.registerSingleton<DeleteDeadline>(DeleteDeadline(sl()));
  sl.registerSingleton<EditDeadline>(EditDeadline(sl()));
  sl.registerSingleton<GetDeadlines>(GetDeadlines(sl()));

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

  sl.registerFactory<DeadlineBloc>(
        () {
      return DeadlineBloc(
        addDeadline: sl(),
        deleteDeadline: sl(),
        editDeadline: sl(),
        getDeadlines: sl(),
        inputValidator: sl(),
        uuid: sl(),
      );
    },
  );
}
