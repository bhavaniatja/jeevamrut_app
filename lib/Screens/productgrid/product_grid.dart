import 'package:flutter/material.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'components/body.dart';

// ignore: must_be_immutable
class ProdcutGridScreen extends StatelessWidget {
  final List<ProductResponse>? productData;
  const ProdcutGridScreen(this.productData, {Key? key}) : super(key: key);
  // static const String routeName = "/productscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Vegetables',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {
              print(this.productData?[0].description);
            },
          ),
        ],
      ),
      body: Body(productData),
    );
  }
}
//https://github.com/rajayogan/flutterui-cookies
