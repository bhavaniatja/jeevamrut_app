import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Authenticate/check.dart';
import 'package:jeevamrut_app/bottomnav.dart';
import 'package:jeevamrut_app/repositories/get_location.dart';
import 'package:provider/provider.dart';

import 'models/firebaseuser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return user == null ? CheckScreen() : BottomNav();
  }
}
