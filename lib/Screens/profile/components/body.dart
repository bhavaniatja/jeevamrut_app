import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/Screens/profile/components/account_details.dart';
import 'package:jeevamrut_app/Screens/profile/components/address_details.dart';
import 'package:jeevamrut_app/Screens/wallet/wallet_screen.dart';
import 'package:jeevamrut_app/cubit/app_cubits_cubit.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Widget getProfileScreen(BuildContext context) {
    final cubit = BlocProvider.of<AppCubitsCubit>(context);
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
          ProfileMenu(
            text: "Saved Address",
            icon: "assets/icons/location.svg",
            press: () {
              cubit.getAddress();
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
    final cubit = BlocProvider.of<AppCubitsCubit>(context);
    return BlocListener<AppCubitsCubit, AppCubitsState>(
      listener: (context, state) {
        if (state is AppLoading) {
          CircularProgressIndicator();
        } else if (state is AddressLoaded && cubit.address != []) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeliveryDetails(cubit.address)));
        } else {
          Container(
            child: Text("Error Bae!"),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(body: getProfileScreen(context)),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut().then((_) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckScreen()));
  });
}
