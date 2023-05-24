import 'package:dead_notes/features/Deadline/presentation/view/deadline_page.dart';
import 'package:dead_notes/features/Note/presentation/view/note_page.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/widgets/top_bar.dart';
import 'package:dead_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SelectorPage extends StatelessWidget {
  const SelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: selectOptionLocalize(context),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
              title: '${newLocalize(context)} ${deadlineLocalize(context)}',
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DeadlinePage())),
            ),
            const SizedBox(height: 30,),
            RoundedButton(
              title: '${newLocalize(context)} ${noteLocalize(context)}',
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NotePage())),
            ),
          ],
        ),
      ),
    );
  }
}