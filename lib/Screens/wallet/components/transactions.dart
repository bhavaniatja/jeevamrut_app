import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: ListView(
              children: [
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
                listTile(Icons.shopping_cart, Colors.pink, "Fruits",
                    "Apples 20KGs", 2000.0),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget listTile(
    IconData icon, Color color, String type, String title, double value) {
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
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                icon,
                color: color,
              )),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                )
              ],
            ),
          ),
          Text(
            "\u20b9 $value",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
