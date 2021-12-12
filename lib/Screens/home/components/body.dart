import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/home/components/title_header.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 20),
            TitleHeader(),
            SizedBox(height: 20),
            HomeHeader(),
            SizedBox(height: 10),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: 30),
            PopularProducts(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
