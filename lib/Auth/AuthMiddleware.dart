import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sampleproject/main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (pref.getBool('fetch') != null) {
      return RouteSettings(name: '/welcomeScreen');
    }
  }
}
