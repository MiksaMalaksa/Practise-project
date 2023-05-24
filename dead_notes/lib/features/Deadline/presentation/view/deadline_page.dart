import 'package:dead_notes/features/Deadline/domain/entities/deadline.dart';
import 'package:dead_notes/features/Deadline/presentation/view/widgets/color_switcher.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeadlinePage extends StatefulWidget {
  const DeadlinePage({super.key});

  @override
  DeadlinePageState createState() => DeadlinePageState();
}

class DeadlinePageState extends State<DeadlinePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineTimeController = TextEditingController();
  DateTime _deadlineTime = DateTime.now();
  List<TextEditingController> _tasksControllers = [];
  Color? _deadlineColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: '${newLocalize(context)} ${deadlineLocalize(context)}',),
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
            ...List<Widget>.generate(
              _tasksControllers.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
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
                        });
                      },
                      child: Icon(Icons.delete, size: 30, color: Theme.of(context).colorScheme.error,),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _tasksControllers.add(TextEditingController(text: newTaskLocalize(context)));
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
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
            ColorSwitcher(onChange: (value) {
              setState(() {
                _deadlineColor = value;
              });
            },),
            RoundedButton(title: saveLocalize(context), onTap: () {

            }),
          ],
        ),
      ),
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

}