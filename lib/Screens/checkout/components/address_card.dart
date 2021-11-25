import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Saved Address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  Divider(),
                  Text(
                    "13-260,indiranagar,Hyderabad,567890",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Change Address",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total :",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "\u20b9 2450",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Delivery Charges :",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  // Spacer(),
                  Text(
                    "\u20b9 24",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "SubTotal :",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\u20b9 2490",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Payment Type",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      "Wallet",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      "Online",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      "COD",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
