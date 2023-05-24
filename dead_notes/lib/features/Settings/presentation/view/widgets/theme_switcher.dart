import 'package:dead_notes/theme/app_theme.dart';
import 'package:dead_notes/theme/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        height: (450 - (17 * 2) - (10 * 2)) / 3,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          crossAxisCount: appThemes.length,
          children: List.generate(
            appThemes.length,
                (i) {
              bool _isSelectedTheme = appThemes[i].mode == themeProvider.selectedThemeMode;
              return GestureDetector(
                onTap: _isSelectedTheme ? null : () => themeProvider.setSelectedThemeMode(appThemes[i].mode),
                child: AnimatedContainer(
                  height: 100,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _isSelectedTheme ? Theme.of(context).primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                      child: Icon(appThemes[i].icon),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}