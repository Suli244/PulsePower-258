import 'package:shared_preferences/shared_preferences.dart';

class FirstOpenPulsePower {
  static Future<bool> getFO() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOpened') ?? false;
  }

  static Future<void> setFO() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOpened', true);
  }
}
