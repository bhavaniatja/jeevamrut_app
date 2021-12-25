import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/cart/cart_screen.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(flex: 3, child: SearchField()),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfitem: state.cart
                      .productQuantity(state.cart.productIds)
                      .keys
                      .length,
                  press: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen())),
                );
              }
              return IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfitem: 0,
                press: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen())),
              );
            },
          ),
        ],
      ),
    );
  }
}
