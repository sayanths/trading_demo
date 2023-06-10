import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/feature/bottom_av/view_model/bottom_nav_pro.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, value, _) => Scaffold(
        body: value.tabItems[value.selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.bounceIn,
          selectedIndex: value.selectedIndex,
          iconSize: 20,
          showElevation: false, 
          onItemSelected: (index) {
            value.indexChange(index);
          },
          items: [
            FlashyTabBarItem(
              icon: const Icon(IconlyBroken.home),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              icon: const Icon(IconlyBroken.heart),
              title: const Text('WatchList'),
            ),
            FlashyTabBarItem(
              icon: const Icon(IconlyBroken.profile),
              title: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
