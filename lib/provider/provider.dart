import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        )
      ],
      child: child,
    );
  }
}
