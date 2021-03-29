import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("name") ?? "";
  }

  static Future<String> getMatricNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("matric_no") ?? "";
  }

  static Future<void> setMatricNo(String matricNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("matric_no", matricNo);
  }

  static Future<void> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
  }

  static Future<void> saveImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("imageUrl", imageUrl);
  }

  static Future<String> getImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("imageUrl") ?? "";
  }
}
