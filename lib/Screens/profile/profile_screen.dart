import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/login_show.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: user == null ? LoginShow() : Body(),
    );
  }
}
