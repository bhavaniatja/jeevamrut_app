import 'package:flutter/material.dart';
import 'package:jeevamrut_app/constants.dart';

class LocationField extends StatefulWidget {
  const LocationField({Key? key}) : super(key: key);

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Your Pincode",
          prefixIcon: Icon(Icons.location_on),
        ),
      ),
    );
  }
}
