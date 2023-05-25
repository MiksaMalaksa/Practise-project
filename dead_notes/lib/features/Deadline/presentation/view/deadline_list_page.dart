import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:dead_notes/features/Deadline/presentation/view/deadline_page.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeadlineListPage extends StatefulWidget {
  const DeadlineListPage({super.key});

  @override
  DeadlineListPageState createState() => DeadlineListPageState();
}

class DeadlineListPageState extends State<DeadlineListPage> {
  final DeadlineBloc _bloc = sl.get<DeadlineBloc>();

  @override
  void initState() {
    _bloc.add(const GetDeadlinesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeadlineBloc, DeadlineState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: TopBar(title: deadlinesLocalize(context),),
          body: (state is Loaded) ? ListView.builder(
            itemCount: state.deadlines.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final deadline = state.deadlines[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    _bloc.add(DeleteDeadlineEvent(id: deadline.id));
                    Fluttertoast.showToast(msg: deadlineRemovedLocalize(context));
                  } else if (direction == DismissDirection.startToEnd) {
                    _bloc.add(EditDeadlineEvent(
                      id: deadline.id,
                      title: deadline.title,
                      text: deadline.text,
                      color: deadline.color,
                      creationTime: deadline.creationTime,
                      modificationTime: deadline.modificationTime,
                      deadlineTime: deadline.deadlineTime,
                      tasks: deadline.tasks,
                      isFavorite: !deadline.isFavorite,
                    ));
                    Fluttertoast.showToast(msg: deadlinePinnedLocalize(context));
                  }
                },
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15),
                  color: Colors.transparent,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: const Icon(Icons.flag, color: Colors.white),
                  ),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 15),
                  color: Colors.transparent,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.error,
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeadlinePage(deadline: deadline,))).then((value) => _bloc.add(const GetDeadlinesEvent()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: deadline.color
                    ),
                    child: Row(
                      children: [
                        deadline.isFavorite ? const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.flag, color: Colors.white),
                        ) : Container(),
                        deadline.tasks.where((e) => !e.isDone).isEmpty ? const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.check, color: Colors.white),
                        ) : Container(),
                        Expanded(child: Text(deadline.title)),
                      ],
                    ),
                  ),
                )
              );
            },
          ) : Container(),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

}