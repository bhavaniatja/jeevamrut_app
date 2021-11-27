import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/wallet/wallet_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Wallet",
            icon: "assets/icons/wallet.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WalletScreen()));
            },
          ),
          ProfileMenu(
            text: "Saved Address",
            icon: "assets/icons/location.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
