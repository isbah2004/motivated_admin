import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motivated_admin/firebase_options.dart';
import 'package:motivated_admin/internetconnectivitysetup/internet_connecitivity.dart';
import 'package:motivated_admin/provider/drawer_button_provider.dart';
import 'package:motivated_admin/provider/home_providers.dart';
import 'package:motivated_admin/provider/update_provider.dart';
import 'package:motivated_admin/splashscreen/splash_screen.dart';
import 'package:motivated_admin/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  Get.put(InternetController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeButtonProvider()),
        ChangeNotifierProvider(create: (_) => ContactButtonProvider()),
        ChangeNotifierProvider(create: (_) => AboutButtonProvider()),
        ChangeNotifierProvider(create: (_) => RateButtonProvider()),
        ChangeNotifierProvider(create: (_) => AddPhilospherProvider()),
        ChangeNotifierProvider(create: (_) => UpdateProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Motivational App',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
