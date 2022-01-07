import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BalanceCard extends StatefulWidget {
  final double? amount;
  const BalanceCard(this.amount, {Key? key}) : super(key: key);

  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              text: "Your Balance\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "\u20b9 ${widget.amount}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AddMoney(user!.uid);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange[300]),
            ),
            child: Text(
              "Add Money",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void AddMoney(String uid) async {
    final response;
    const String endPoint =
        "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/wallet-transaction/save";
    final Uri url = Uri.parse(endPoint);
    Map body = {
      "userId": uid,
      "walletId": "cb205d92-5ce4-44ee-8432-8941c7f2fdec",
      "amount": 300.0,
      "type": "Deposit",
      "description": "Amont deposited",
      "status": "approved",
      "createDate": "2022-03-02T07:03:29.000+00:00",
      "createdBy": "MOHAN",
      "updatedDate": "2022-03-02T07:03:29.000+00:00",
      "updatedBy": "KIRAN"
    };
    try {
      var payload = json.encode(body);
      response = await http.post(
        url,
        body: payload,
        headers: {
          "Content-Type": "application/json",
        },
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
}
