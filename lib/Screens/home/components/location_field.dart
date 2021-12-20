import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _textEditingController = TextEditingController();
  String value = "";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _checkPincode();
    _textEditingController.addListener(() {
      //here you have the changes of your textfield
      // print("value: ${_textEditingController.text}");
      //use setState to rebuild the widget
      setState(() {
        value = _textEditingController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        editModalBottomSheet();
        // _determinePosition();
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
                  hintText: state.pincode,
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

  Future<String> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      return "${place.postalCode}";

      // BlocProvider.of(context)
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  void editModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Please Enter Your Pincode",
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  BlocBuilder<PincodeBloc, PincodeState>(
                    builder: (context, state) {
                      if (state is PincodeInitial) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            border: OutlineInputBorder(),
                            hintText: "Enter Pincode",
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        );
                      }
                      if (state is PincodeEditState) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          controller: _textEditingController
                            ..text = state.pincode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            border: OutlineInputBorder(),
                            // hintText: state.pincode,
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        );
                      }
                      if (state is PincodeEditedState) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          controller: _textEditingController
                            ..text = state.pincode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            border: InputBorder.none,
                            hintText: state.pincode,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        );
                      }
                      return Text("Something Wrong");
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        print(value);
                        BlocProvider.of<PincodeBloc>(context)
                            .add(PincodeInitEvent());
                        BlocProvider.of<PincodeBloc>(context)
                            .add(PincodeEditedEvent(value));
                        final preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setString('pincode', value);
                        Navigator.of(context).pop();
                      },
                      child: Text("Submit")),
                  ElevatedButton(
                      onPressed: () async {
                        String getpin = await _determinePosition();
                        // BlocProvider.of<PincodeBloc>(context)
                        //     .add(PincodeInitEvent());
                        Future.delayed(Duration(seconds: 1));
                        BlocProvider.of<PincodeBloc>(context)
                            .add(PincodeEditEvent(getpin));
                        // print(_determinePosition());
                      },
                      child: Text("Detect")),
                ],
              ),
            ),
          );
        });
  }

  Future _checkPincode() async {
    final preferences = await SharedPreferences.getInstance();
    // print(preferences.getString('pincode'));
    if (preferences.containsKey('pincode')) {
      String? str = preferences.getString('pincode');
      BlocProvider.of<PincodeBloc>(context).add(PincodeEditedEvent(str!));
    }
  }
}
