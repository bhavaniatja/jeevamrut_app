import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/cartscreen.dart';
import 'package:jeevamrut_app/Screens/splash.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/bottomnav.dart';
import 'package:jeevamrut_app/cubit/app_cubits_cubit.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';
import 'package:jeevamrut_app/services/auth.dart';
import 'package:jeevamrut_app/simple_bloc_observer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        )
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/auth": (context) => CheckScreen(),
          "/splashscreen": (context) => SplashScreen(),
          "/": (context) => BottomNav(),
          "/cart": (context) => CartScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
