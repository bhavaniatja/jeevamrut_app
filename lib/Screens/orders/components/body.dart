import 'package:flutter/material.dart';
import 'package:jeevamrut_app/models/Cart.dart';

import 'orders_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        itemCount: demoCarts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: OrdersCard(cart: demoCarts[index]),
        ),
      ),
    );
  }
}
