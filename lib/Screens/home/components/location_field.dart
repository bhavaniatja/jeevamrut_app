import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/home/components/pincode_request.dart';
import 'package:jeevamrut_app/bloc/pincode/pincode_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationField extends StatefulWidget {
  const LocationField({Key? key}) : super(key: key);

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PincodeRequestScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: BlocBuilder<PincodeBloc, PincodeState>(
          builder: (context, state) {
            if (state is PincodeInitial || state is PincodeEditState) {
              return const TextField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Enter Pincode",
                  prefixIcon: Icon(Icons.location_on),
                ),
              );
            }
            if (state is PincodeEditedState) {
              return TextField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: state.pincode.length > 2
                      ? state.pincode
                      : "Enter Pincode",
                  prefixIcon: Icon(Icons.location_on),
                ),
              );
            }
            return Text("Enter Pincode");
          },
        ),
      ),
    );
  }
}
