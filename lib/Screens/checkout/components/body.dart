import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/checkout/components/address_card.dart';
import 'package:jeevamrut_app/Screens/checkout/components/final_cart_card.dart';
import 'package:jeevamrut_app/models/Cart.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(
          height: 200, // constrain height
          child: LstView(),
        ),
        Expanded(child: AddressCard()),
      ],
    );
  }
}

class LstView extends StatelessWidget {
  const LstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: demoCarts.length,
      itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: FinalCartCard(cart: demoCarts[index])),
    );
  }
}
