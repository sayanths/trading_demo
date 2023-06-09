import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trading_app/feature/home_view/view/home_view.dart';

import '../../wishlist/view/wishlist.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedIndex = 0;
  void indexChange(int ind) {
    selectedIndex = ind;

    log(selectedIndex.toString());
    notifyListeners();
  }

  List<Widget> tabItems = [
    const HomeView(),
    const WishListView(),
    const HomeView(),
  ];
}
