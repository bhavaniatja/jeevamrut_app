import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/home/components/title_header.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            TitleHeader(),
            SizedBox(height: 20),
            HomeHeader(),
            SizedBox(height: 10),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: 30),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return PopularProducts(state.products);
                } else {
                  return Text('Something went wrong.');
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
