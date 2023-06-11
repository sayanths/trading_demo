import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_app/feature/home_view/model/wish_list.dart';
import 'package:trading_app/feature/splash_view/view/splash_view.dart';
import 'package:trading_app/provider/provider.dart';
import 'package:trading_app/responsive/responsive.dart';
import 'package:trading_app/routes/pop_up.dart';
import 'package:trading_app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(WishlistModelAdapter().typeId)) {
    Hive.registerAdapter(WishlistModelAdapter());
  }
  runApp(
    const MyApp(),
  );
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderApp(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              Responsive().init(constraints, orientation);
              return MaterialApp(
                routes: Routes().route,
                scaffoldMessengerKey: Messenger.messengerKey,
                navigatorKey: Routes.routeKey,
                debugShowCheckedModeBanner: false,
                title: 'Trading App',
                home: const SplashView(),
              );
            },
          );
        },
      ),
    );
  }
}
