import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bloc/orders/orders_bloc.dart';
import 'package:jeevamrut_app/models/Cart.dart';

import 'orders_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add(LoadOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OrdersLoaded) {
            print(state.orders.length);
            if (state.orders.length == 0) {
              return Center(
                child: Text("No Orders"),
              );
            } else {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: OrdersCard(cart: state.orders[index]),
                ),
              );
            }
          }
          return SizedBox();
        },
      ),
    );
  }
}
