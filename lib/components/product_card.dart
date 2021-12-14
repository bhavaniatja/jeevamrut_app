import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/product_detail.dart';
import 'package:jeevamrut_app/bloc/cart/cart_bloc.dart';
import 'package:jeevamrut_app/models/product_response.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductResponse product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductDetail())),
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: 150,
                child: Image.network(
                  product.productImage!.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 60,
                left: 5,
                child: Container(
                  width: width,
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(50),
                  ),
                ),
              ),
              Positioned(
                top: 65,
                left: 10,
                child: Container(
                  width: width,
                  height: 70,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              '\$${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                final snackBar = SnackBar(
                                  content: Text('Added to your Cart!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                context.read<CartBloc>().add(
                                      CartProductAdded(product),
                                    );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
