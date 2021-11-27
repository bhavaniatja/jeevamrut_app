import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/wallet/components/transactions.dart';
import 'balance_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      child: Column(
        children: [
          BalanceCard(),
          SizedBox(),
          TransactionsScreen(),
        ],
      ),
    );
  }
}
