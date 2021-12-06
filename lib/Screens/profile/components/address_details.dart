import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/profile/components/add_delivery_address.dart';
import 'package:jeevamrut_app/Screens/profile/components/single_delivery_address.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: Text("Add new Address"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliverAddress(),
              ),
            );
          },
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(
            height: 1,
          ),
          Column(children: [
            SingleDeliveryItem(
                address: "My Home Bhooja,13/678,Room No:450,Madhapur,566722",
                title: "Bhavani Prasad",
                number: '9944588103',
                addressType: "Home")
          ]),
        ],
      ),
    );
  }
}
