import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({Key? key}) : super(key: key);

  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  late String _name;
  late String _email;
  late String _apartNo;
  late String _buildingName;
  late String _phoneNumber;
  late String _altphoneNumber;
  late String _streetName;
  late String _landmark;
  late String _pincode;
  late String _cityName;
  late String _stateName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 20,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildBuildingName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Building Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Building Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _buildingName = value!;
      },
    );
  }

  Widget _buildStreetName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Street Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Street Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _streetName = value!;
      },
    );
  }

  Widget _buildlandmark() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'LandMark'),
      validator: (String? value) {
        return null;
      },
      onSaved: (String? value) {
        _landmark = value!;
      },
    );
  }

  Widget _buildApartmentNo() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apartment/House No'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Apartment No is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _apartNo = value!;
      },
    );
  }

  Widget _buildCityName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'City Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'City Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _cityName = value!;
      },
    );
  }

  Widget _buildStateName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'State Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'State Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _stateName = value!;
      },
    );
  }

  Widget _buildPincode() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Pincode'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Pincode is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _pincode = value!;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Phone number is Required';
        }
        if (!RegExp("[0-9]+").hasMatch(value)) {
          return "Enter Correct Mobile Number";
        }
        return null;
      },
      onSaved: (String? value) {
        _phoneNumber = value!;
      },
    );
  }

  Widget _buildAltPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Alternate Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (!RegExp("[0-9]+").hasMatch(value!)) {
          return "Enter Correct Mobile Number";
        }
        return null;
      },
      onSaved: (String? value) {
        _altphoneNumber = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: MaterialButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            _formKey.currentState!.save();
            submitAddress(_name, _buildingName, _phoneNumber, _altphoneNumber,
                _apartNo, _streetName, _cityName, _stateName, _pincode);
            print(_name);
          },
          child: const Text(
            "Add Address",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildPhoneNumber(),
                _buildAltPhoneNumber(),
                _buildBuildingName(),
                _buildApartmentNo(),
                _buildStreetName(),
                _buildlandmark(),
                _buildCityName(),
                _buildStateName(),
                _buildPincode(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> submitAddress(
    String name,
    String buildingName,
    String phoneNumber,
    String altphoneNumber,
    String apartNo,
    String streetName,
    String cityName,
    String stateName,
    String pincode) async {
  final response;
  print("hii");
  const String endPoint =
      "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/address/";
  final Uri url = Uri.parse(endPoint);
  Map body = {
    "customerId": "447d69f2-35e0-41ce-b785-d0ec4a8b650d",
    "type": "office",
    "preference": 2,
    "buildingName": buildingName,
    "apartmentNumber": apartNo,
    "streetName": streetName,
    "landmark": "NEAR htis",
    "billingAddress": 1,
    "shippingAddress": 1,
    "city": cityName,
    "state": stateName,
    "country": "INDIA",
    "pinCode": pincode,
    "mobile": phoneNumber,
    "alternateMobile": altphoneNumber
  };
  try {
    response = await http.post(
      url,
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;
    print(data);
    if (response.statusCode == 200) {
      print("jii");
    }
  } on Exception catch (e) {
    print(e);
    throw e;
  }
}
