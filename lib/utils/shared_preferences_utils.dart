import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  SharedPreferencesUtils._privateConstructor();

  static final SharedPreferencesUtils instance =
  SharedPreferencesUtils._privateConstructor();

  setBooleanValue(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  setStringValue(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

}