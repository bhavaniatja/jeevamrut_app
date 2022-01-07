import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/orders/components/track_order.dart';
import 'package:jeevamrut_app/Screens/wallet/components/transactions.dart';
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TrackOrderScreen()));
        },
        child: ordertile(
            widget.cart.id!, widget.cart.status, widget.cart.totalPrice!));
  }

  Widget ordertile(String orderId, String? status, double total) {
    return Container(
      padding: EdgeInsets.all(9.0),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Id:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  orderId,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
              ],
            ),
            flex: 3,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Status:",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    children: [
                      TextSpan(
                        text: status == null ? "Pending" : status,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text.rich(
                  TextSpan(
                    text: "Total:",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    children: [
                      TextSpan(
                        text: "\u20b9 $total",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
