import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/intro/introduction_screen.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrapperIntro extends StatefulWidget {
  const WrapperIntro({Key? key}) : super(key: key);

  @override
  State<WrapperIntro> createState() => _WrapperIntroState();
}

class _WrapperIntroState extends State<WrapperIntro> {
  bool check = false;
  @override
  void initState() {
    _checkExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !check ? IntroScreen() : Wrapper();
  }

  void _checkExists() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('pincode')) {
      setState(() {
        check = true;
      });
    }
  }
}
