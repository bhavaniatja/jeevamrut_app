import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/login_show.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:provider/provider.dart';

import '../../bottomnav.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Profile", style: TextStyle(color: Colors.black)),
            automaticallyImplyLeading: false,
          ),
          body: user == null ? LoginShow() : Body(),
        ));
  }
}
