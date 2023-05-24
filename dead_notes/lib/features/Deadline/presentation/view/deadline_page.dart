import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DeadlinePage extends StatefulWidget {
  final Deadline? deadline;
  const DeadlinePage({super.key, this.deadline});

  @override
  DeadlinePageState createState() => DeadlinePageState();
}

class DeadlinePageState extends State<DeadlinePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineTimeController = TextEditingController();
  DateTime _deadlineTime = DateTime.now();
  List<TextEditingController> _tasksControllers = [];
  List<bool> _taskStatuses = [];
  Color? _deadlineColor;
  final DeadlineBloc _bloc = sl.get<DeadlineBloc>();
  DateTime? _creationTime;

  bool editing = false;

  @override
  void initState() {
    if (widget.deadline != null) {
      _titleController.text = widget.deadline!.title;
      _descriptionController.text = widget.deadline!.text;
      _deadlineTime = widget.deadline!.deadlineTime;
      _deadlineTimeController.text = DateFormat.yMMMd().format(_deadlineTime);
      _creationTime = widget.deadline!.creationTime;
      _tasksControllers.addAll(List.generate(widget.deadline!.tasks.length, (index) => TextEditingController(text: widget.deadline!.tasks[index].text)));
      _taskStatuses.addAll(List.generate(widget.deadline!.tasks.length, (index) => widget.deadline!.tasks[index].isDone));

      editing = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeadlineBloc, DeadlineState>(
      bloc: _bloc,
      listenWhen: (s1, s2) => true,
      listener: (context, state) {
        if (state is Error) {
          Fluttertoast.showToast(msg: state.error);
        }
        if (state is Loaded && state.deadlines.isNotEmpty && _creationTime != null) {
          final matches = state.deadlines.where((e) => e.creationTime.difference(_creationTime!).inSeconds.abs() < 5).toList();
          if (matches.isNotEmpty) {
            Fluttertoast.showToast(msg: editing ? deadlineUpdatedLocalize(context) : newDeadlineAddedLocalize(context));
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, snapshot) {
        return Scaffold(
          appBar: TopBar(title: '${newLocalize(context)} ${deadlineLocalize(context)}',),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: _titleController,
                  decoration: _decoration(titleLocalize(context)),
                ),
                const SizedBox(height: 15,),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200.0,
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: _decoration(descriptionLocalize(context)),
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  controller: _deadlineTimeController,
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _deadlineTime,
                      firstDate: DateTime(1920),
                      lastDate: DateTime(2200),
                      currentDate: _deadlineTime,
                    ).then((value) {
                      setState(() {
                        _deadlineTime = value ?? _deadlineTime;
                        _deadlineTimeController.text = DateFormat.yMMMd(localeLocalize(context)).format(_deadlineTime);
                      });
                    });
                  },
                  decoration: _decoration(deadlineDayLocalize(context)),
                ),
                const SizedBox(height: 15,),
                ...List<Widget>.generate(
                  _tasksControllers.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        if (editing)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _taskStatuses[index] = !_taskStatuses[index];
                              });
                            },
                            child: Icon(_taskStatuses[index] ? Icons.check_circle_outline : Icons.circle_outlined, size: 25, color: Theme.of(context).colorScheme.secondary,),
                          ),
                        if (editing) const SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            controller: _tasksControllers[index],
                            decoration: _decoration(newTaskLocalize(context)),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tasksControllers.removeAt(index);
                              _taskStatuses.removeAt(index);
                            });
                          },
                          child: Icon(Icons.delete, size: 25, color: Theme.of(context).colorScheme.error,),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tasksControllers.add(TextEditingController(text: newTaskLocalize(context)));
                      _taskStatuses.add(false);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, size: 30, color: Theme.of(context).primaryColor,),
                        const SizedBox(width: 10,),
                        Text(addTaskLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Text(selectColorLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                const SizedBox(height: 10,),
                ColorSwitcher(selectedColor: widget.deadline?.color, onChange: (value) {
                  setState(() {
                    _deadlineColor = value;
                  });
                },),
                const SizedBox(height: 30,),
                RoundedButton(
                  title: saveLocalize(context),
                  onTap: () {
                    if (_tasksControllers.isEmpty) {
                      Fluttertoast.showToast(msg: addOneTaskLocalize(context));
                      return;
                    }
                    _creationTime = DateTime.now();
                    if (editing && widget.deadline != null) {
                      final List<Task> tasks = [];
                      for (int i = 0; i < _tasksControllers.length; i++) {
                        tasks.add(Task(text: _tasksControllers[i].text, isDone: _taskStatuses[i]));
                      }
                      _bloc.add(
                        EditDeadlineEvent(
                          id: widget.deadline!.id,
                          isFavorite: widget.deadline!.isFavorite,
                          title: _titleController.text,
                          text: _descriptionController.text,
                          deadlineTime: _deadlineTime,
                          creationTime: _creationTime!,
                          tasks: tasks,
                          color: _deadlineColor ?? Theme.of(context).primaryColor,
                        ),
                      );
                    } else {
                      _bloc.add(
                        AddDeadlineEvent(
                          title: _titleController.text,
                          text: _descriptionController.text,
                          deadlineTime: _deadlineTime,
                          creationTime: _creationTime!,
                          tasks: _tasksControllers.map((e) => Task(text: e.text)).toList(),
                          color: _deadlineColor ?? Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  },
                ),
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