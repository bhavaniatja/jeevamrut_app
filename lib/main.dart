import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/home/home_screen.dart';
import 'package:jeevamrut_app/Screens/splash.dart';
import 'package:jeevamrut_app/bottomnav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/splashscreen",
      routes: {
        "/auth": (context) => CheckScreen(),
        "/splashscreen": (context) => SplashScreen(),
        "/": (context) => const BottomNav(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
