import 'package:flutter/material.dart';
import 'package:jeevamrut_app/wrapper.dart';

class LoginShow extends StatelessWidget {
  const LoginShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Wrapper()));
          },
          child: Text("Login"),
          style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
