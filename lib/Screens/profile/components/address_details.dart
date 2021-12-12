import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/profile/components/add_delivery_address.dart';
import 'package:jeevamrut_app/Screens/profile/components/single_delivery_address.dart';
import 'package:jeevamrut_app/models/address_response.dart';

// ignore: must_be_immutable
class DeliveryDetails extends StatefulWidget {
  AddressResponse addressdata;
  DeliveryDetails(this.addressdata, {Key? key}) : super(key: key);

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
                address: '${widget.addressdata.city}',
                title: '${widget.addressdata.createdBy}',
                number: '${widget.addressdata.mobile}',
                addressType: '${widget.addressdata.type}')
          ]),
        ],
      ),
    );
  }
}
