import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:project17/services/logger.dart';

import '../model/user.dart';

class HiveService {
  static var box = Hive.box('login');
  static var userbox = Hive.box('user');

  static storeInfo({required String email, required String password}) {
    box.put("email", email);
    box.put("password", password);
    LoggerService.warningLogger("Stored successfully");
  }

  static getInfo({required String emailKey, required String passwordKey}) {
    var email = box.get(emailKey);
    var password = box.get(passwordKey);
    LoggerService.errorLogger("Email is: $email");
    LoggerService.errorLogger("Password is: $password");
  }

  static deleteInfo({required String emailKey, required String passwordKey}) {
    box.delete(emailKey);
    box.delete(passwordKey);
    LoggerService.debugLogger("Infos deleted");
  }

  static storeUserObj({required var object, required String objectKey}) {
    String objString = jsonEncode(object);
    userbox.put(objectKey, objString);
    LoggerService.errorLogger("Stored successfully");
  }

  static User getUserObj({required String objKey}) {
    String userString;
    try {
      userString = userbox.get(objKey);
    } catch (e) {
      return User(
        firstName: null,
        lastName: null,
        email: null,
        password: null,
      );
    }
    Map<String, dynamic> objMap = jsonDecode(userString);
    User user = User.fromJson(objMap);
    return user;
  }
  static bool removeObject({required String objKey}) {
    try{
      userbox.delete(objKey);
      print("Deleted");
    }
    catch(e){
      return false;
    }
    return true;
  }


  }
/*static  removeObject(String objKey) {
  bool removedObj=  userbox.put(objectKey, objString);
LoggerService.warningLogger(removedObj.toString());
  }*/
