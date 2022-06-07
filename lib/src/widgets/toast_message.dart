import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static success(String message) {
    _message(message, Colors.white, Colors.black);
  }

  static _message(String message, Color backColor, Color textColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: textColor,
        backgroundColor: backColor,
        timeInSecForIosWeb: 2);
  }

  static error(String message) {
    _message(message, Colors.red, Colors.white);
  }

  static info(String message) {
    _message(message, Colors.black, Colors.white);
  }
}
