import 'package:flutter/material.dart';
import 'package:jeevamrut_app/models/address_response.dart';

class TransactionsScreen extends StatelessWidget {
  final List<WalletTransaction>? list;
  const TransactionsScreen(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list!.isEmpty) {
      return Center(
        child: Text("Order Something"),
      );
    }
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 26, right: 26, top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60)),
          color: Colors.brown[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listTile(
                          list![(list!.length - 1) - index].type!,
                          list![(list!.length - 1) - index].orderId!,
                          list![(list!.length - 1) - index].currentBalance!,
                          list![(list!.length - 1) - index].previousBalance!);
                    }))
          ],
        ),
      ),
    );
  }
}

Widget listTile(String type, String orderId, double curBal, double prevBal) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(9.0),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  color: Colors.white,
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
                ),
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Current Balance:\n",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    children: [
                      TextSpan(
                        text: "\u20b9 $curBal",
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
                    text: "Previous Balance:\n",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    children: [
                      TextSpan(
                        text: "\u20b9 $prevBal",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
