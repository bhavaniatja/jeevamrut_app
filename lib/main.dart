import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/home/home_screen.dart';
import 'package:jeevamrut_app/Screens/productgrid/product_grid.dart';
import 'package:jeevamrut_app/Screens/splash.dart';
import 'package:jeevamrut_app/bottomnav.dart';
import 'package:jeevamrut_app/cubit/app_cubits_cubit.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // print(pref.getString('phone'));
  runApp(BlocProvider(
    create: (context) => AppCubitsCubit(productdata: ProductRepository()),
    child: const MyApp(),
  ));
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
        "/": (context) => BottomNav(),
        // "/productscreen": (context) => ProdcutGridScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
