import 'package:dead_notes/features/Note/presentation/blocs/note_bloc.dart';
import 'package:dead_notes/features/Note/presentation/view/note_page.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  NoteListPageState createState() => NoteListPageState();
}

class NoteListPageState extends State<NoteListPage> {
  final NoteBloc _bloc = sl.get<NoteBloc>();

  @override
  void initState() {
    _bloc.add(const GetNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: TopBar(title: notesLocalize(context),),
          body: (state is Loaded) ? ListView.builder(
            itemCount: state.notes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      _bloc.add(DeleteNoteEvent(id: note.id));
                      Fluttertoast.showToast(msg: noteRemovedLocalize(context));
                    } else if (direction == DismissDirection.startToEnd) {
                      _bloc.add(EditNoteEvent(
                        id: note.id,
                        title: note.title,
                        text: note.text,
                        color: note.color,
                        creationTime: note.creationTime,
                        isFavorite: !note.isFavorite,
                      ));
                      Fluttertoast.showToast(msg: notePinnedLocalize(context));
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotePage(note: note,))).then((value) => _bloc.add(const GetNotesEvent()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: state.notes[index].color
                      ),
                      child: Row(
                        children: [
                          note.isFavorite ? const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.flag, color: Colors.white),
                          ) : Container(),
                          Expanded(child: Text(note.title)),
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