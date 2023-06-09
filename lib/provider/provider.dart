import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/feature/home_view/view_model/home_view.dart';

import '../feature/bottom_av/view_model/bottom_nav_pro.dart';
import '../feature/splash_view/view_model/splash_controller.dart';

class ProviderApp extends StatelessWidget {
  final Widget child;
  const ProviderApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashController(),
        ),
          ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) => BottomNavProvider(),
        ),
        
      ],
      child: child,
    );
  }
}
