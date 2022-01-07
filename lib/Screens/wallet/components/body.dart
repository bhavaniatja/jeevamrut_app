import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/wallet/components/transactions.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'balance_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      child: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressLoaded) {
            return Column(
              children: [
                BalanceCard(state.Address.wallet!.amount),
                SizedBox(),
                TransactionsScreen(state.Address.wallet!.walletTransactions),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
