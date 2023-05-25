import 'package:dead_notes/features/Settings/presentation/bloc/settings_bloc.dart';
import 'package:dead_notes/features/Settings/presentation/view/widgets/primary_color_switcher.dart';
import 'package:dead_notes/features/Settings/presentation/view/widgets/theme_switcher.dart';
import 'package:dead_notes/features/Settings/utils/shared_preferences_utils.dart';
import 'package:dead_notes/features/injection.dart';
import 'package:dead_notes/localization/app_localization_constants.dart';
import 'package:dead_notes/main.dart';
import 'package:dead_notes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String? dropdownvalue;

  // List of items in our dropdown menu
  var items = [
    'English',
    'Русский',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      sl.get<SharedPreferencesUtils>().getLang().then((value) {
        setState(() => dropdownvalue = (value == 'en') ? items[0] : items[1]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TopBar(title: settingsLocalize(context),),
            body: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(themeLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ThemeSwitcher(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(colorLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: PrimaryColorSwitcher(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(languageLocalize(context), style: Theme.of(context).textTheme.titleMedium,),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: dropdownvalue ?? ((NoteApp.of(context)?.locale.countryCode == 'en') ? items[0] : items[1]),
                      fillColor: Theme.of(context).primaryColor,
                    ),
                    value: dropdownvalue ?? ((NoteApp.of(context)?.locale.countryCode == 'en') ? items[0] : items[1]),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        NoteApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: dropdownvalue == items[0] ? 'en' : 'ru'));
                        sl.get<SharedPreferencesUtils>().addLang(dropdownvalue == items[0] ? 'en' : 'ru');
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}