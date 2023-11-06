import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String imageK = "imagek";
  static String nameK = "namek";
  static savedata(String key, String path) async {
    //هخلي الميثود استتيك علشان استدعيها على طول من غير ما اخد منها انستينس
    var prefs = await SharedPreferences.getInstance();
    // السطر دا ثابت معايا باخد انستنس من الshared
    prefs.setString(key, path);
  }

  static Future<String> getdata(String key) async {
    // بحط future علشان هرجع من فانكشن فيها async
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
    //حطيت استرينج فاضي علشان الصورة ممكن تيجي او لا لو جت يحط المسار بتاعها لو لا يحط استرينج فاضي
  }
}
