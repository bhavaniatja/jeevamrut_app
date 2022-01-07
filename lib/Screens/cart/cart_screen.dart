import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/cart/components/cart_product_card.dart';
import 'package:jeevamrut_app/Screens/home/components/icon_btn_with_counter.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/bloc/order_id/orderid_bloc.dart';
import 'package:jeevamrut_app/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'package:jeevamrut_app/models/product_response.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);
  static const String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List<ProductResponse> prods = [];
  ProductResponse? finProd;
  double subtotal = 0;
  List<Map<String, dynamic>> list = [];
  @override
  void initState() {
    super.initState();
    subtotal = 0;
    BlocProvider.of<OrderidBloc>(context).add(LoadingOrderidEvent());
    final state = BlocProvider.of<ProductBloc>(context).state;
    if (state is ProductLoaded) {
      prods = state.products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        bottomNavigationBar: _buildCheckoutButton(context),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return CircularProgressIndicator();
            }

            if (state is CartLoaded) {
              if (state.cart
                  .productQuantity(state.cart.productIds)
                  .keys
                  .isEmpty) {
                return Center(
                  child: Container(
                      child: Text("Nothing in Cart",
                          style: TextStyle(
                            fontSize: 30,
                          ))),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
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
                                          .productQuantity(
                                              state.cart.productIds)
                                          .keys
                                          .elementAt(index)) {
                                    list.add({
                                      "productId": prod.id,
                                      "quantity": state.cart
                                          .productQuantity(
                                              state.cart.productIds)
                                          .values
                                          .elementAt(index),
                                      "amount": prod.prices![0].price,
                                      "discount": 10
                                    });
                                    subtotal += prod.prices![0].price! *
                                        state.cart.productQuantity(state
                                            .cart.productIds)["${prod.id}"];
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
                      ],
                    ),
                  ],
                ),
              );
            }
            return Text('Something went wrong');
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.home),
        color: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
        },
      ),
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              return Container(
                margin: EdgeInsets.all(5),
                child: IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfitem: state.cart
                      .productQuantity(state.cart.productIds)
                      .keys
                      .length,
                  press: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen())),
                ),
              );
            }
            return Container(
              margin: EdgeInsets.all(5),
              child: IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfitem: 0,
                press: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen())),
              ),
            );
          },
        ),
      ],
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

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: ElevatedButton(
              onPressed: () async {
                await _sendCartData(context, list);
                BlocProvider.of<AddressBloc>(context)
                    .add(LoadAddress(user!.uid));
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
    // print(data);
    const String endPoint =
        "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/api/order/save";
    final Uri url = Uri.parse(endPoint);
    Map body = {
      "userId": user!.uid,
      "orderProducts": list,
      "totalPrice": subtotal,
      "cgstTax": 4.0,
      "sgstTax": 3.0,
      "igstTax": 1.0,
      "discount": 0.0,
      "paymentId": "b9515dbf-679f-49e4-b1b1-e7632bb6e50p",
      "promisedDate": "2022-01-01T10:56:15.000+00:00",
      "createDate": "2022-01-01T10:56:15.000+00:00",
      "createdBy": "MOHAN",
      "updatedDate": "2022-01-01T10:56:15.000+00:00",
      "updatedBy": "KIRAN"
    };
    try {
      response = await http.post(
        url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );
      var data = json.decode(response.body);
      print(data);
      BlocProvider.of<OrderidBloc>(context)
          .add(LoadOrderid(data["id"], data["totalPrice"]));
      if (response.statusCode == 200) {
        print("jii");
      }
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }
}
