import 'package:flutter/material.dart';

class Helper {
  static void showMessage(BuildContext context, String message,
      {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 5,
        backgroundColor: error ? Colors.red : Colors.green,
        margin: EdgeInsets.only(
          right: 135,
          left: 120,
          bottom: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
