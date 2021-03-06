import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/home/components/location_field.dart';
import 'package:jeevamrut_app/Screens/home/components/pincode_request.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/bloc/pincode/pincode_bloc.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _checkPincode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          body:
              BlocBuilder<PincodeBloc, PincodeState>(builder: (context, state) {
            if (state is PincodeInitial || state is PincodeEditState) {
              return PincodeRequestScreen();
            } else if (state is PincodeEditedState) {
              context.read<ProductBloc>().add(LoadProducts(state.pincode));
              final pincode = state.pincode;

              return Body();
            }
            return SizedBox();
          }),
        ));
  }

  Future _checkPincode() async {
    final preferences = await SharedPreferences.getInstance();
    // print(preferences.getString('pincode'));
    if (preferences.containsKey('pincode')) {
      String? str = preferences.getString('pincode');
      BlocProvider.of<PincodeBloc>(context).add(PincodeEditedEvent(str!));
    }
  }
}
//special offers image dimensions ~1k*400px
