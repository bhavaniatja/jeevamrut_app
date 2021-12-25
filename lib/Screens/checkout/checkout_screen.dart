import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/checkout/components/payment_options.dart';
import 'package:jeevamrut_app/Screens/ordersuccess/order_success_screen.dart';
import 'package:jeevamrut_app/Screens/profile/components/single_delivery_address.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/wrapper.dart';
import 'package:provider/provider.dart';

import 'package:jeevamrut_app/Screens/cart/components/cart_product_card.dart';
import '../../order_summary.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key? key}) : super(key: key);
  static const String routeName = '/checkout';

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<ProductResponse> prods = [];
  ProductResponse? finProd;
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
    final user = Provider.of<FirebaseUser?>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: user == null
          ? _buildLoginButton(context)
          : _buildPaymentButton(context),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return CircularProgressIndicator();
          }
          if (state is CartLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   state.cart.freeDeliveryString,
                          //   style: Theme.of(context).textTheme.headline5,
                          // ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: state.cart
                                    .productQuantity(state.cart.productIds)
                                    .keys
                                    .length <
                                4
                            ? state.cart
                                    .productQuantity(state.cart.productIds)
                                    .keys
                                    .length *
                                100.0
                            : 400,
                        child: ListView.builder(
                            itemCount: state.cart
                                .productQuantity(state.cart.productIds)
                                .keys
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              for (ProductResponse prod in prods) {
                                if (prod.id ==
                                    state.cart
                                        .productQuantity(state.cart.productIds)
                                        .keys
                                        .elementAt(index)) {
                                  finProd = prod;
                                  break;
                                }
                              }
                              return CartProductCard(
                                product: finProd!,
                                quantity: state.cart
                                    .productQuantity(state.cart.productIds)
                                    .values
                                    .elementAt(index),
                              );
                            }),
                      ),
                      user == null
                          ? Text(
                              "Login to Add Address",
                              style: TextStyle(fontSize: 30),
                            )
                          : BlocBuilder<AddressBloc, AddressState>(
                              builder: (context, state) {
                                if (state is AddressLoaded) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text("Deliver To"),
                                      ),
                                      Divider(
                                        height: 1,
                                      ),
                                      Column(children: [
                                        SingleDeliveryItem(
                                            address: '${state.Address.city}',
                                            title: '${state.Address.createdBy}',
                                            number: '${state.Address.mobile}',
                                            addressType:
                                                '${state.Address.type}')
                                      ]),
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                      SizedBox(height: 200, child: OrderSummary()),
                      PaymentOption(),
                    ],
                  ),
                ],
              ),
            );
          }
          return Text('Something went wrong');
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Text(
                  "${state.cart.productQuantity(state.cart.productIds).keys.length} items",
                  style: Theme.of(context).textTheme.caption,
                );
              }
              return Text("0 Items");
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildLoginButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Wrapper()));
    },
    child: Text("Login"),
    style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  );
}

Widget _buildPaymentButton(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
    child: ElevatedButton(
      onPressed: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all((Radius.circular(8))),
        ),
        elevation: 0,
        padding: EdgeInsets.all(8),
      ),
      child: Text(
        'Payment',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white),
      ),
    ),
  );
}
//issue sol: https://stackoverflow.com/questions/57158031/how-to-make-a-screen-scrollable-in-flutter