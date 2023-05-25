import 'package:dead_notes/core/usecases/no_params.dart';
import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:dead_notes/features/Deadline/presentation/view/deadline_list_page.dart';
import 'package:dead_notes/features/Deadline/util/local_notice_service.dart';
import 'package:dead_notes/features/Home/presentation/view/home_page.dart';
import 'package:dead_notes/features/Note/presentation/view/note_list_page.dart';
import 'package:dead_notes/features/Settings/presentation/view/settings_page.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/selector_page.dart';
import 'package:dead_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  //?list of pages
  final List<Widget> _pages = [
    HomePage(),
    DeadlineListPage(),
    SelectorPage(),
    NoteListPage(),
    SettingsPage(),
  ];

  //!switch index
  int _currentIndex = 0;
  final _size = 40.0;

  void switchIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    sl.get<DeadlineBloc>().getDeadlines(NoParams()).then((value) async {
      value.fold(
            (_) => {},
            (deadlines) async {
              for (int i = 0; i < deadlines.length; i++) {
                if (deadlines[i].deadlineTime.difference(DateTime.now()).inHours.abs() <= 24) {
                  await sl.get<LocalNoticeService>().addNotification(
                    title: 'Deadline coming soon!',
                    body: '${deadlines[i].title}\n${DateFormat.yMMMd().format(deadlines[i].deadlineTime)}',
                    endTime: DateTime.now().add(const Duration(hours: 3, seconds: 20)).millisecondsSinceEpoch,
                    channel: 'deadlines',
                  );
                  Future.delayed(const Duration(minutes: 2));
                }
              }

            },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        //*customi
        //color: Theme.of(context).iconTheme.color,
        backgroundColor: Colors.grey[50],
        //*page switch
        onTap: switchIndex,
        //*in final output there are no labels in bottom nav bar
        showSelectedLabels: false, // don't show selected labels
        showUnselectedLabels: false, // don't show unselected labels
        //*need this for 3+ items
        type: BottomNavigationBarType.fixed,
        items: [
          //*home
          _bottomItem(label: 'Home', imagePath: 'assets/home-button.png'),
          //*deadlines
          _bottomItem(label: 'Deadlines', imagePath: 'assets/deadlines.png'),
          //*fast action button
          _bottomItem(label: 'Action', icon: AddButton(color: Theme.of(context).primaryColor)),
          //*notes
          _bottomItem(label: 'Notes', imagePath: 'assets/notes.png'),
          //*settings
          _bottomItem(label: 'Settings', imagePath: 'assets/setting.png'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomItem({required String label, String? imagePath, Widget? icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: imagePath != null ? DesignedIcon(
        assetPath: imagePath,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
      ) : icon ?? Container(),
      activeIcon: imagePath != null ? DesignedIcon(
        assetPath: imagePath,
        color: Theme.of(context).primaryColor,
      ) : icon ?? Container(),
    );
  }
}
