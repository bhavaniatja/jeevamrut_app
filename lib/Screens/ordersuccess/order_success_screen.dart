import 'package:flutter/material.dart';
import 'components/body.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Success!"),
      ),
      body: Body(),
    );
  }
}
