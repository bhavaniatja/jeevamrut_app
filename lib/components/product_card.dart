import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/Screens/product_detail.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductResponse product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: widget.width,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetail(widget.product))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.product.id.toString(),
                    child: Image.network(
                      widget.product.productImage!.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Text(
                "\$${widget.product.price}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
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
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      context.read<CartBloc>().add(
                            CartProductAdded(widget.product),
                          );
                    },
                  ),
                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                    if (state is CartLoaded) {
                      Future.delayed(Duration(seconds: 1));
                      int ind;
                      if (state.cart
                          .productQuantity(state.cart.products)
                          .keys
                          .contains(widget.product)) {
                        // print(state.cart
                        //     .productQuantity(state.cart.products)
                        //     .keys
                        //     .length);
                        for (int i = 0;
                            i <
                                state.cart
                                    .productQuantity(state.cart.products)
                                    .keys
                                    .length;
                            i++) {
                          if (state.cart
                                  .productQuantity(state.cart.products)
                                  .keys
                                  .elementAt(i) ==
                              widget.product) {
                            return Text(
                                '${state.cart.productQuantity(state.cart.products).values.elementAt(i)}');
                          }
                          // print("yes ${i}");
                        }
                      } else {
                        return Text("0", style: TextStyle(fontSize: 20));
                      }
                      // int ind = state.cart.products.indexWhere(
                      //     (element) => element.id == widget.product.id);
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
                      // print(widget.product.name);
                      context.read<CartBloc>().add(
                            CartProductRemoved(widget.product),
                          );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
