import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoggerService {
  static var logger = Logger();

  static void debugLogger(String message) {
    logger.d(message);
  }
  static void errorLogger(String message) {
    logger.e(message);
  }
  static void warningLogger(String message) {
    logger.w(message);
  }
  static void falseLogger(String message) {
    logger.f(message);
  }
  static void infoLogger(String message) {
    logger.i(message);
  }
  static void terminateLogger(String message) {
    logger.t(message);
  }

}
