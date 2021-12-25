import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/cart/cart_screen.dart';
import 'package:jeevamrut_app/Screens/checkout/checkout_screen.dart';
import 'package:jeevamrut_app/Screens/home/home_screen.dart';
import 'package:jeevamrut_app/Screens/productgrid/product_grid.dart';
import 'package:jeevamrut_app/Screens/profile/components/address_details.dart';
import 'package:jeevamrut_app/Screens/profile/profile_screen.dart';
import 'package:jeevamrut_app/Screens/splash.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/auth/bloc/auth_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/bloc/pincode/pincode_bloc.dart';
import 'package:jeevamrut_app/bottomnav.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';
import 'package:jeevamrut_app/services/auth.dart';
import 'package:jeevamrut_app/simple_bloc_observer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc/product_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // print(pref.getString('phone'));

  BlocOverrides.runZoned(
    () => runApp(StreamProvider<FirebaseUser?>.value(
        value: AuthService().user,
        catchError: (_, __) => null,
        initialData: null,
        child: MyApp())),
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
          )..add(LoadingProductEvent()),
        ),
        BlocProvider(
            create: (_) => AddressBloc(productRepository: ProductRepository())),
        BlocProvider(create: (_) => PincodeBloc()),
      ],
      child: MaterialApp(
        initialRoute: "/splashscreen",
        routes: {
          "/auth": (context) => CheckScreen(),
          "/splashscreen": (context) => SplashScreen(),
          "/": (context) => BottomNav(),
          "/cart": (context) => CartScreen(),
          "/profile": (context) => ProfileScreen(),
          "/address": (context) => DeliveryDetails(),
          "/checkout": (context) => CheckOutScreen(),
          // "/productscreen": (context) => ProdcutGridScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
