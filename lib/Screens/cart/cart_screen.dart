import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/cart/components/cart_product_card.dart';
import 'package:jeevamrut_app/Screens/cart/components/order_summary.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/models/Cart.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  static const String routeName = '/cart';
  final prods = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: _buildCheckoutButton(context),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return CircularProgressIndicator();
          }

          if (state is CartLoaded) {
            if (state.cart.productQuantity(state.cart.products).keys.isEmpty) {
              return Center(
                child: Container(
                    child: Text("Nothing in Cart",
                        style: TextStyle(
                          fontSize: 30,
                        ))),
              );
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.cart.freeDeliveryString,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .length *
                        100.0,
                    child: ListView.builder(
                        itemCount: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartProductCard(
                            product: state.cart
                                .productQuantity(state.cart.products)
                                .keys
                                .elementAt(index),
                            quantity: state.cart
                                .productQuantity(state.cart.products)
                                .values
                                .elementAt(index),
                          );
                        }),
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
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Text(
                  "${state.cart.productQuantity(state.cart.products).keys.length} items",
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

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: ElevatedButton(
              onPressed: () async {
                for (int i = 0;
                    i <
                        state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .length;
                    i++) {
                  prods.add(state.cart
                      .productQuantity(state.cart.products)
                      .keys
                      .elementAt(i));
                }
                // print(prods);
                Future.delayed(Duration(seconds: 2), () async {
                  // 5s over, navigate to a new page
                  await _sendCartData(context, prods);
                });
                BlocProvider.of<AddressBloc>(context).add(LoadAddress());
                Navigator.pushNamed(context, '/checkout');
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
                'Checkout',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
            ),
          );
        }
        return Center(child: Text("ADD SOMETHING"));
      },
    );
  }

  Future<void> _sendCartData(BuildContext context, List data) async {
    final response;
    print(data);
    const String endPoint = "http://192.168.1.17:3000/process";
    final Uri url = Uri.parse(endPoint);
    Map body = {
      "customer": "447d69f2-35e0-41ce-b785-d0ec4a8b650d",
      "products": data
    };
    try {
      response = await http.post(
        url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );
      var data = response.body;
      print(data);
      if (response.statusCode == 200) {
        print("jii");
      }
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  // void _sendCartList(State state) {
  //   BlocListener<CartBloc, CartState>(listener,: (context, state) {
  //     if (state is CartLoaded) {

  //     return null;
  //   });
  // }
}
