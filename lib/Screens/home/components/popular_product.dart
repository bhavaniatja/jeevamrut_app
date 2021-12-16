import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/components/product_card.dart';
import 'package:jeevamrut_app/models/Product.dart';
import 'package:jeevamrut_app/models/product_response.dart';

import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts(this.products, {Key? key}) : super(key: key);
  final List<ProductResponse> products;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(title: "Popular Products", press: () {}),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      products.length,
                      (index) {
                        // if (products[index].isPopular) {
                        return ProductCard(product: products[index]);
                        // }

                        // return const SizedBox
                        //     .shrink(); // here by default width and height is 0
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            ],
          );
        }
        return Text("Nothing");
      },
    );
  }
}
