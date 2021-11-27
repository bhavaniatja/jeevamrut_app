import 'package:flutter/material.dart';
import 'package:jeevamrut_app/constants.dart';

class LocationField extends StatefulWidget {
  const LocationField({Key? key}) : super(key: key);

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final _textEditingController = TextEditingController();
  String value = "Your Pincode";
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textEditingController.addListener(() {
      //here you have the changes of your textfield
      print("value: ${_textEditingController.text}");
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
        editModalBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: value,
            prefixIcon: Icon(Icons.location_on),
          ),
        ),
      ),
    );
  }

  void editModalBottomSheet(context) {
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
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(),
                      hintText: "Your Pincode",
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Submit")),
                ],
              ),
            ),
          );
        });
  }
}
