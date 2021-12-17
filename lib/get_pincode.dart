import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetPincode extends StatefulWidget {
  @override
  _GetPincodeState createState() => _GetPincodeState();
}

class _GetPincodeState extends State<GetPincode> {
  String currentAddress = 'My Address';
  Position? currentposition;

  Future<void> _determinePosition() async {
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

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Center(
          child: Column(
        children: [
          Text(currentAddress),
          currentposition != null
              ? Text('Latitude = ' + currentposition!.latitude.toString())
              : Container(),
          currentposition != null
              ? Text('Longitude = ' + currentposition!.longitude.toString())
              : Container(),
          TextButton(
              onPressed: () {
                _determinePosition();
              },
              child: Text('Locate me'))
        ],
      )),
    );
  }
}
// https://gist.github.com/akmadan/37c576cee96142fe4e23b9d5c2ec3720/revisions