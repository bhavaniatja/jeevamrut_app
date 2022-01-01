import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/orders/components/track_order.dart';
import 'package:jeevamrut_app/models/Cart.dart';
import 'package:jeevamrut_app/models/orders_response.dart';

import '../../../constants.dart';

class OrdersCard extends StatefulWidget {
  const OrdersCard({
    Key? key,
    required this.cart,
  }) : super(key: key);
  final OrdersResponse cart;
  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TrackOrderScreen()));
      },
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                    "${widget.cart.product!.productImage!.imageUrl}"),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                child: Text(
                  "${widget.cart.product!.name}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\u20b9 ${widget.cart.product!.prices![0].price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: " x2",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Status: Paid",
                    style: TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.orange[300],
                        color: Colors.white,
                        fontStyle: FontStyle.italic)),
                SizedBox(width: 5),
                Text(
                  "\u20b9 500",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
