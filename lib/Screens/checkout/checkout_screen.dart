import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jeevamrut_app/Screens/cart/cart_screen.dart';
import 'package:jeevamrut_app/Screens/checkout/components/payment_options.dart';
import 'package:jeevamrut_app/Screens/ordersuccess/order_success_screen.dart';
import 'package:jeevamrut_app/Screens/profile/components/single_delivery_address.dart';
import 'package:jeevamrut_app/bloc/address/address_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/bloc/order_id/orderid_bloc.dart';
import 'package:jeevamrut_app/bloc/orders/orders_bloc.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/wrapper.dart';
import 'package:provider/provider.dart';

import 'package:jeevamrut_app/Screens/cart/components/cart_product_card.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../order_summary.dart';

class CheckOutScreen extends StatefulWidget {
  static const String routeName = '/checkout';

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<ProductResponse> prods = [];
  ProductResponse? finProd;
  late Razorpay razorpay;
  String? walletId, orderId;
  double? amount;
  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    final state = BlocProvider.of<ProductBloc>(context).state;
    if (state is ProductLoaded) {
      prods = state.products;
    }
    final addressstate = BlocProvider.of<AddressBloc>(context).state;
    if (addressstate is AddressLoaded) {
      walletId = addressstate.Address.wallet!.id!;
    }
    final orderstate = BlocProvider.of<OrderidBloc>(context).state;
    if (orderstate is OrderidLoaded) {
      orderId = orderstate.orderId.id;
      amount = orderstate.orderId.amount;
    }
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS");
    _sendToWallet(context, orderId, amount, "approved");
    print("yes");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Fail");
    _sendToWallet(context, orderId, amount, "pending");
    print("yes");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
    print("no");
  }

  void handlerExternalWallet() {
    Fluttertoast.showToast(msg: "Wallet");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CartScreen()));
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        bottomNavigationBar: user == null
            ? _buildLoginButton(context)
            : _buildPaymentButton(context, razorpay),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return CircularProgressIndicator();
            }
            if (state is CartLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
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
                                          .productQuantity(
                                              state.cart.productIds)
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
                                              address:
                                                  '${state.Address.address!.city}',
                                              title: '${state.Address.fname}',
                                              number:
                                                  '${state.Address.mobileNumber}',
                                              addressType:
                                                  '${state.Address.address!.type}')
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
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
          icon: Icon(Icons.arrow_back_ios)),
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

Widget _buildPaymentButton(BuildContext context, Razorpay razorpay) {
  return BlocBuilder<OrderidBloc, OrderidState>(
    builder: (context, state) {
      if (state is OrderidLoaded) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
          child: ElevatedButton(
            onPressed: () async {
              var orderOptions = {
                'amount': state.orderId.amount! *
                    100, // amount in the smallest currency unit
                'currency': "INR",
                'receipt': state.orderId.id,
              };
              final client = HttpClient();
              final request = await client
                  .postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
              request.headers.set(HttpHeaders.contentTypeHeader,
                  "application/json; charset=UTF-8");
              String basicAuth = 'Basic ' +
                  base64Encode(utf8.encode(
                      '${'rzp_test_lkbLQjQeH5hPIF'}:${'ky2gWU7qqGXzUQp3mU2Mc7bV'}'));
              request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
              request.add(utf8.encode(json.encode(orderOptions)));
              final response = await request.close();
              response.transform(utf8.decoder).listen((contents) {
                print('ORDERID' + contents);
                String orderId = contents.split(',')[0].split(":")[1];
                orderId = orderId.substring(1, orderId.length - 1);
                Fluttertoast.showToast(
                    msg: "ORDERID: " + orderId,
                    toastLength: Toast.LENGTH_SHORT);
                if (orderId.isNotEmpty) {
                  Map<String, dynamic> checkoutOptions = {
                    'key': 'rzp_test_lkbLQjQeH5hPIF',
                    'amount': 200,
                    'name': 'Demo',
                    'order_id': orderId,
                    'description': 'Fssai Registrtion Charge',
                    'prefill': {
                      'contact': '9944588103',
                      'email': 'xx.xx@gmail.com'
                    },
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  try {
                    razorpay.open(checkoutOptions);
                  } catch (e) {
                    print(e.toString());
                  }
                }
              });
              // await _generateOrderId(state.orderId.id!, state.orderId.amount!);
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
      return CircularProgressIndicator();
    },
  );
}

Future<void> _sendToWallet(
    BuildContext context, String? id, double? amount, String status) async {
  String? walletId;
  print(amount);
  final state = BlocProvider.of<AddressBloc>(context).state;
  if (state is AddressLoaded) {
    walletId = state.Address.wallet!.id!;
  }
  print(walletId);
  final response;
  const String endPoint =
      "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/api/wallet-transaction/save";
  final Uri url = Uri.parse(endPoint);
  Map body = {
    "orderId": id,
    "walletId": walletId,
    "amount": amount,
    "type": status,
    "description": "AMOunt deposited",
    "status": "approved",
    "createDate": "2022-01-05T07:03:29.000+00:00",
    "createdBy": "MOHAN",
    "updatedDate": "2022-01-05T07:03:29.000+00:00",
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
    if (response.statusCode == 200) {
      print("jii");
    }
  } on Exception catch (e) {
    print(e);
    throw e;
  }
}
//issue sol: https://stackoverflow.com/questions/57158031/how-to-make-a-screen-scrollable-in-flutter