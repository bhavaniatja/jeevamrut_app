import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/profile/components/account_details.dart';
import 'package:jeevamrut_app/Screens/profile/components/address_details.dart';
import 'package:jeevamrut_app/Screens/wallet/wallet_screen.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/bloc/pincode/pincode_bloc.dart';
import 'package:jeevamrut_app/services/auth.dart';
import 'package:jeevamrut_app/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Widget getProfileScreen(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountDetails()));
            },
          ),
          ProfileMenu(
            text: "Wallet",
            icon: "assets/icons/wallet.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WalletScreen()));
            },
          ),
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              return ProfileMenu(
                text: "Saved Address",
                icon: "assets/icons/location.svg",
                press: () {
                  if (state is AddressLoading || state is AddressLoaded) {
                    context.read<AddressBloc>().add(AddressInitial());
                    context.read<AddressBloc>().add(LoadAddress());
                    Navigator.pushNamed(context, '/address');
                  }
                },
              );
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getProfileScreen(context),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  BlocProvider.of<PincodeBloc>(context).add(PincodeInitEvent());
  BlocProvider.of<CartBloc>(context).add(CartStarted());
  // await preferences.remove('pincode');
  // await preferences.remove('cart');
  await _auth.signOut().then((_) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
  });
}
