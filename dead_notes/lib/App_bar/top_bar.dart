import 'package:flutter/material.dart';
import 'styled_text.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Title(color: Color(0xff3d5a80), child: StyledText()),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
