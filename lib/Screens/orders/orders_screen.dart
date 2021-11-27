import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/orders/components/body.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Orders",
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            "2 items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
// https://www.youtube.com/watch?v=OAIrnAYkKKQ
//added im_stepper dependecy in track order screen;
//found out awesome tool: json to dart from where we get ready to copy modal for your json data;