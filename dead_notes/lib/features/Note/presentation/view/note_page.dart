import 'package:dead_notes/features/Note/domain/entities/note.dart';
import 'package:dead_notes/features/Note/presentation/blocs/note_bloc.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  final Note? note;

  const NotePage({super.key, this.note});

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Color? _noteColor;
  final NoteBloc _bloc = sl.get<NoteBloc>();
  DateTime? _creationTime;
  bool editing = false;

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.text;
      _creationTime = widget.note!.creationTime;
      editing = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
        bloc: _bloc,
        listenWhen: (s1, s2) => true,
        listener: (context, state) {
          if (state is Error) {
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is Loaded && state.notes.isNotEmpty && _creationTime != null) {
            final matches = state.notes.where((e) => e.creationTime.difference(_creationTime!).inSeconds.abs() < 60).toList();
            if (matches.isNotEmpty) {
              Fluttertoast.showToast(msg: editing ? noteUpdatedLocalize(context) : newNoteAddedLocalize(context));
              Navigator.of(context).pop();
            }
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            appBar: TopBar(title: '${newLocalize(context)} ${noteLocalize(context)}',),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: _decoration(titleLocalize(context)),
                  ),
                  const SizedBox(height: 15,),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 300.0,
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: _decoration(descriptionLocalize(context)),
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(selectColorLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 10,),
                  ColorSwitcher(selectedColor: widget.note?.color, onChange: (value) {
                    setState(() {
                      _noteColor = value;
                    });
                  },),
                  const SizedBox(height: 30,),
                  RoundedButton(title: saveLocalize(context), onTap: () {
                    _creationTime = DateTime.now();
                    if (editing && widget.note != null) {
                      _bloc.add(
                        EditNoteEvent(
                          id: widget.note!.id,
                          title: _titleController.text,
                          text: _descriptionController.text,
                          creationTime: _creationTime!,
                          color: _noteColor ?? Theme.of(context).primaryColor,
                          isFavorite: widget.note!.isFavorite,
                        ),
                      );
                    } else {
                      _bloc.add(
                        AddNoteEvent(
                          title: _titleController.text,
                          text: _descriptionController.text,
                          creationTime: _creationTime!,
                          color: _noteColor ?? Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 15,),
                  RoundedButton(
                    color: Colors.grey,
                    title: cancelLocalize(context),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      labelText: label,
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

}