import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static late SharedPreferences _prefs;
  static const _whatsApp = 'whatsApp';
  static const _autoResponse = 'autoResponse';
  static const _fbMassager = 'fbMassager';
  static const _viber = 'viber';

  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void clearSharedPreferences(String value) {
    _prefs.remove(value);
    return;
  }

  // static const String theme = "theme";

  ///-------------
  static Future setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String getString(String key) {
    final String? value = _prefs.getString(key);
    return value ?? "";
  }

  static Future setBoolean(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
  }

  static bool getBoolean(String key) {
    final bool? value = _prefs.getBool(key);
    return value ?? false;
  }

  static Future setLong(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static double getLong(String key) {
    final double? value = _prefs.getDouble(key);
    return value ?? 0.0;
  }

  static Future setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int getInt(String key) {
    final int? value = _prefs.getInt(key);
    return value ?? 0;
  }

  static Future setInComingKeyword(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String getInComingKeyword(String key) {
    final String? value = _prefs.getString(key);
    return value ?? "";
  }

  ///
  static Future<void> setWhatsApp({required bool whatsApp}) async {
    final SharedPreferences prefs = _prefs;
    prefs.setBool(_whatsApp, whatsApp);
  }

  static Future<void> setAutoResponse({required bool autoResponse}) async {
    final SharedPreferences prefs = _prefs;
    prefs.setBool(_autoResponse, autoResponse);
  }

  static Future<void> setFbMassager({required bool fbMassager}) async {
    final SharedPreferences prefs = _prefs;
    prefs.setBool(_fbMassager, fbMassager);
  }

  static Future<void> setViber({required bool viber}) async {
    final SharedPreferences prefs = _prefs;
    prefs.setBool(_viber, viber);
  }

  static bool get whatsApp {
    final bool value = _prefs.getBool(_whatsApp) ?? false;
    return value;
  }

  static bool get autoResponse {
    final bool value = _prefs.getBool(_autoResponse) ?? false;
    return value;
  }

  static bool get fbMassager {
    final bool value = _prefs.getBool(_fbMassager) ?? false;
    return value;
  }

  static bool get viber {
    final bool value = _prefs.getBool(_viber) ?? false;
    return value;
  }

// static Future setUserToken(String token) async {
//   await _prefs.setString(Constants.keyToken, token);
// }
//
// static Future setUser(User? user) async {
//   user?.jwtToken = "";
//   await _prefs.setString(Constants.keyUser, jsonEncode(user));
// }
//
// static String? getUserToken() {
//   return _prefs.get(Constants.keyToken) as String?;
// }
//
// static User? getUser() {
//   return User.fromJson(
//       jsonDecode(_prefs.get(Constants.keyUser) as String? ?? ""));
// }
//
// static bool isUserLogin() {
//   final String? getToken = getUserToken();
//   return getToken != null && getToken.isNotEmpty;
// }
}
