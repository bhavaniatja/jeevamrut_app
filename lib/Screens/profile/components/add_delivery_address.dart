import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({Key? key}) : super(key: key);

  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  late String _chosenValue = "Home";
  // late String _name;
  late String _apartNo;
  late String _buildingName;
  // late String _phoneNumber;
  // late String _altphoneNumber;
  late String _streetName;
  late String _landmark;
  late String _pincode;
  late String _cityName;
  late String _stateName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Widget _buildAddressType() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Address Type :", style: TextStyle(fontSize: 20)),
      Container(
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),

            items: <String>[
              'Home',
              'Office',
              'Others',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "Choose Address Type",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (String? value) {
              setState(() {
                _chosenValue = value!;
              });
            },
          )),
    ]);
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

  // Widget _buildAltPhoneNumber() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Alternate Phone number'),
  //     keyboardType: TextInputType.phone,
  //     validator: (String? value) {
  //       if (!RegExp("[0-9]+").hasMatch(value!)) {
  //         return "Enter Correct Mobile Number";
  //       }
  //       return null;
  //     },
  //     onSaved: (String? value) {
  //       _altphoneNumber = value!;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<AddressBloc>(context).add((LoadAddress()));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<AddressBloc>(context).add((LoadAddress()));
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_sharp)),
            title: const Text(
              "Add Delivery Address",
              style: TextStyle(fontSize: 18),
            ),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 48,
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressEditState) {
                  return MaterialButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      submitAddress(
                          _buildingName,
                          _apartNo,
                          _chosenValue,
                          _landmark,
                          _streetName,
                          _cityName,
                          _stateName,
                          _pincode);
                      context.read<AddressBloc>().add(AddressEdited());
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
                  );
                } else if (state is AddressEditedState) {
                  return MaterialButton(
                    onPressed: () {
                      BlocProvider.of<AddressBloc>(context).add(LoadAddress());
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Added",
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
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressEditState) {
                  return Container(
                    margin: EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildBuildingName(),
                          _buildApartmentNo(),
                          _buildStreetName(),
                          _buildlandmark(),
                          _buildAddressType(),
                          _buildCityName(),
                          _buildStateName(),
                          _buildPincode(),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 200),
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<AddressBloc>(context)
                                    .add(LoadAddress());
                                Navigator.of(context).pop();
                              },
                              child: Text("Go back:)"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                onPrimary: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}

Future<void> submitAddress(
    String buildingName,
    String apartNo,
    String type,
    String landmark,
    String streetName,
    String cityName,
    String stateName,
    String pincode) async {
  final response;
  print(type +
      "" +
      apartNo +
      " " +
      buildingName +
      " " +
      cityName +
      " " +
      pincode +
      " " +
      stateName);
  const String endPoint =
      "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/address/";
  final Uri url = Uri.parse(endPoint);
  Map body = {
    "customerId": "447d69f2-35e0-41ce-b785-d0ec4a8b650d",
    "type": type,
    "preference": 2,
    "buildingName": buildingName,
    "apartmentNumber": apartNo,
    "streetName": streetName,
    "landmark": landmark,
    "billingAddress": 1,
    "shippingAddress": 1,
    "city": cityName,
    "state": stateName,
    "country": "INDIA",
    "pinCode": pincode,
    "mobile": "+917322176745",
    "alternateMobile": "+912003220662"
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
