import 'package:flutter/material.dart';
import 'package:jeevamrut_app/models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            demoCarts[0].product.title!,
            style: TextStyle(fontSize: 30),
          ),
          Text("No of Items: ${demoCarts[0].numOfItem}"),
        ],
      )),
    );
  }
}
