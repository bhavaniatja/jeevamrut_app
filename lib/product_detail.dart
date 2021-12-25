import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';
import 'package:jeevamrut_app/Screens/cart/cart_screen.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/models/product.dart';
import 'package:jeevamrut_app/models/product_response.dart';

class ProductDetail extends StatelessWidget {
  final ProductResponse product;
  const ProductDetail(this.product, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                  )),
            ],
            title: Text(
              "Jeevamrut",
              textAlign: TextAlign.center,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Image.network(
                    "${product.productImage!.imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product.name!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          '\u20b9 ${product.prices![0].price}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  color: Color(0xFFFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              final snackBar = SnackBar(
                                content: Text('Added to your Cart!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              context.read<CartBloc>().add(
                                    CartProductAdded(product.id!),
                                  );
                            },
                          ),
                          BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                            if (state is CartLoaded) {
                              Future.delayed(Duration(seconds: 1));
                              int ind;
                              if (state.cart
                                  .productQuantity(state.cart.productIds)
                                  .keys
                                  .contains("${product.id}")) {
                                for (int i = 0;
                                    i <
                                        state.cart
                                            .productQuantity(
                                                state.cart.productIds)
                                            .keys
                                            .length;
                                    i++) {
                                  if (state.cart
                                          .productQuantity(
                                              state.cart.productIds)
                                          .keys
                                          .elementAt(i) ==
                                      product.id) {
                                    return Text(
                                        '${state.cart.productQuantity(state.cart.productIds).values.elementAt(i)}');
                                  }
                                }
                              } else {
                                return Text("0",
                                    style: TextStyle(fontSize: 20));
                              }
                            }
                            return Text(
                              "0",
                              style: TextStyle(fontSize: 20),
                            );
                          }),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    CartProductRemoved(product.id!),
                                  );
                            },
                          ),
                        ],
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartLoading) {
                            return CircularProgressIndicator();
                          }
                          if (state is CartLoaded) {
                            return ElevatedButton(
                              onPressed: () {
                                // context
                                //     .read<CartBloc>()
                                //     .add(CartProductAdded(product.id!));
                                // Navigator.pushNamed(context, '/cart');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all((Radius.circular(5))),
                                ),
                              ),
                              child: Text(
                                'ADD TO CART',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          }
                          return Text('Something went wrong!');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  color: Color(0xFFFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("SKU".toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF565656))),
                      Text('234',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFfd0100))),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF999999),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  color: Color(0xFFFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Price".toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF565656))),
                      Text("\u20b9 ${product.prices![0]}",
                          style: TextStyle(
                              fontFamily: 'Roboto-Light.ttf',
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  color: Color(0xFFFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Description",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF565656))),
                      SizedBox(
                        height: 15,
                      ),
                      Text("This is Description of product",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4c4c4c))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
