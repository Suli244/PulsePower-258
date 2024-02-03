import 'package:shared_preferences/shared_preferences.dart';

class PremiumWebPulsePower {
  static Future<bool> getPremium() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ISBUY') ?? false;
  }

  static Future<void> setPremium() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('ISBUY', true);
  }
}
