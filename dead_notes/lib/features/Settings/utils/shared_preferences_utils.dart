import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  Future<void> addLang(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', locale);
  }

  Future<void> addColor(String color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', color);
  }

  Future<String> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lang') ?? 'en';
  }

  Future<String> getColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('color') ?? '';
  }
}