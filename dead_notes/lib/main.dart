import 'package:dead_notes/features/Deadline/presentation/blocs/deadline_bloc.dart';
import 'package:dead_notes/localization/app_localization.dart';
import 'package:dead_notes/manager_page.dart';
import 'package:dead_notes/theme/app_colors.dart';
import 'package:dead_notes/theme/app_theme_data.dart';
import 'package:dead_notes/theme/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  NoteAppState createState() => NoteAppState();

  static NoteAppState? of(BuildContext context) => context.findAncestorStateOfType<NoteAppState>();
}

class NoteAppState extends State<NoteApp> {
  Locale locale = const Locale('en');

  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppThemeProvider(),
        ),
      ],
      child: Consumer<AppThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.selectedThemeMode,
              theme: AppThemeData.lightTheme(
                primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
                primaryColor: themeProvider.selectedPrimaryColor,
              ),
              darkTheme: AppThemeData.darkTheme(
                primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
                primaryColor: themeProvider.selectedPrimaryColor,
              ),
              locale: locale,
              supportedLocales: const [Locale('ru'), Locale('en')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: MultiBlocProvider(
                providers: [
                  BlocProvider<DeadlineBloc>(create: (BuildContext context) => DeadlineBloc(addDeadline: addDeadline, deleteDeadline: deleteDeadline, editDeadline: editDeadline, getDeadlines: getDeadlines, inputValidator: inputValidator, uuid: uuid))
                ],
                child: const ManagerPage(),
              ),
            );
          }
      ),
    );
  }
}