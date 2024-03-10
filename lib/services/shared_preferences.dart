import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:project17/services/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cat.dart';
import '../model/user.dart';

class SharedPrefs {
  static Future<bool> saveObject(
      {required var object, required String objectKey}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String stringObj = jsonEncode(object);
    bool isSaved = await preferences.setString(objectKey, stringObj);
    return isSaved;
  }
  static Future<Cat> getObject(String objectKey) async {
    final SharedPreferences preferences=await SharedPreferences.getInstance();
    final String? stringCat=preferences.getString(objectKey);
    Map<String, dynamic> catMap=jsonDecode(stringCat!);
    Cat cat=Cat.fromJson(catMap);
    return cat;
  }
  static Future<void> removeObject(String objectKey)async {
    final SharedPreferences preferences=await SharedPreferences.getInstance();
bool removedObj=await preferences.remove(objectKey);
LoggerService.warningLogger(removedObj.toString());
  }
}
