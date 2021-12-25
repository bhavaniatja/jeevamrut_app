import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';

import 'bloc/bloc/product_bloc.dart';
import 'models/product_response.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  List<ProductResponse> prods = [];
  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<ProductBloc>(context).state;
    if (state is ProductLoaded) {
      prods = state.products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          double subtotal = 0;
          double delivery_fee = 30;
          double total = 0;
          for (int i = 0; i < prods.length; i++) {
            if (state.cart
                .productQuantity(state.cart.productIds)
                .containsKey(prods[i].id)) {
              subtotal += prods[i].prices![0].price! *
                  state.cart
                      .productQuantity(state.cart.productIds)["${prods[i].id}"];
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Divider(thickness: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SUBTOTAL',
                          style: Theme.of(context).textTheme.headline5),
                      Text('\$${subtotal}',
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DELIVERY FEE',
                          style: Theme.of(context).textTheme.headline5),
                      Text('\$${delivery_fee}',
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(50),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'TOTAL',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              '\$${subtotal + delivery_fee}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}
