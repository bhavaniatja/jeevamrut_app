import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jeevamrut_app/Screens/checkout/components/final_cart_card.dart';
import 'package:jeevamrut_app/models/Cart.dart';

import '../../../size_config.dart';
import 'payment_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        itemCount: demoCarts.length,
        itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: FinalCartCard(cart: demoCarts[index])),
      ),
    );
  }
}
