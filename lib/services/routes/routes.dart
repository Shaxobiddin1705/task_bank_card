import 'package:flutter/cupertino.dart';

class AppRoutes{

  static Future push({required BuildContext context, required Widget page}) {
    return Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }

  static Future pushReplace({required BuildContext context, required Widget page}) {
    return Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => page));
  }

  static Future pushAndRemoveUntil({required BuildContext context, required Widget page}) {
    return Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
  }

}