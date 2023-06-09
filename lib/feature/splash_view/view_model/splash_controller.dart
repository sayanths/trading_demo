import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trading_app/routes/routes.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    Timer(const Duration(seconds: 3), () {
      Routes.push(screen: "/homeView");
    });
  }
}
