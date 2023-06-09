import 'package:flutter/material.dart';
import 'package:trading_app/feature/home_view/view/home_view.dart';

class BottomNavProvider extends ChangeNotifier {
  final int selectedIndex = 0;

  int index = 0;
  void indexChange(int ind) {
    index = ind;
    notifyListeners();
  }

  List<Widget> tabItems = [
    const HomeView(),
    const HomeView(),
    const HomeView(),
  ];
}
