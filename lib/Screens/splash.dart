import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/wrapper_intro.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String routeName = "/splashscreen";
  @override
  void initState() {
    super.initState();
    _getCartData();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WrapperIntro()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/jeevamrut_logo.png'),
        ],
      ),
    ));
  }

  Future<void> _getCartData() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('cart')) {
      List<String> list = preferences.getStringList('cart')!;
      for (var prod in list) {
        BlocProvider.of<CartBloc>(context).add(CartProductAdded(prod));
      }
      // BlocProvider.of<CartBloc>(context).add(CartTrigger(productsList));
    }
  }
}
