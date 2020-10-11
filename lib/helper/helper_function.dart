import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedPreferenceLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUSerNameKey = "USERNAME";

  Future<bool> saveUserLoggedInKey(bool isLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(sharedPreferenceLoggedInKey, isLoggedIn);
  }

  Future<String> saveUserNameKey(String UserName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(sharedPreferenceUSerNameKey, UserName);
  }

  Future<bool> getUserLoggedInKey() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getBool(sharedPreferenceLoggedInKey);
  }

  Future<String> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString(sharedPreferenceUSerNameKey);
  }
}
