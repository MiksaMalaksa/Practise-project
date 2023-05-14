import 'package:flutter/material.dart';
import 'deadline_page.dart';
import 'notes_page.dart';
import 'settings_page.dart';
import 'home_page.dart';
import 'fast_action_page.dart';
import 'package:dead_notes/App_bar/top_bar.dart';
import 'Navigation bar/styled_icon.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  //?list of pages
  final List<Widget> _pages = [
    HomePage(),
    DeadlinePage(),
    FastAction(),
    NotesPage(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
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
          BottomNavigationBarItem(
            icon: DesignedIcon(
              assetPath: 'lib/icons/home-button.png',
            ),
            label: 'Home',
          ),
          //*deadlines
          BottomNavigationBarItem(
            icon: DesignedIcon(
              assetPath: 'lib/icons/deadlines.png',
            ),
            label: 'Deadlines',
          ),
          //*fast action button
          BottomNavigationBarItem(
            icon: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 101, 168, 201),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            label: 'Action',
          ),
          //*notes
          BottomNavigationBarItem(
            icon: DesignedIcon(
              assetPath: 'lib/icons/notes.png',
            ),
            label: 'Notes',
          ),
          //*settings
          BottomNavigationBarItem(
            icon: DesignedIcon(
              assetPath: 'lib/icons/setting.png',
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
