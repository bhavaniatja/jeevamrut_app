import 'package:flutter/material.dart';
import 'package:jeevamrut_app/models/product_response.dart';

class Body extends StatefulWidget {
  final List<ProductResponse>? productData;
  const Body(this.productData, {Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFAF8),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
            ),
            itemCount: widget.productData!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                width: MediaQuery.of(context).size.width - 30.0,
                height: MediaQuery.of(context).size.height - 50.0,
                child: _buildCard(
                    '${widget.productData![index].name}',
                    '\u20b9 ${widget.productData![index].prices![0].price}',
                    '${widget.productData![index].productImage!.imageUrl}',
                    false,
                    false,
                    context),
              );
            }));
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    String url = imgPath.toString();
    return Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: InkWell(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isFavorite
                              ? const Icon(Icons.favorite,
                                  color: Color(0xFFEF7532))
                              : const Icon(Icons.favorite_border,
                                  color: Color(0xFFEF7532))
                        ])),
                Container(
                    padding: EdgeInsets.zero,
                    height: 80.0,
                    // width: 90.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(url), fit: BoxFit.contain))),
                const SizedBox(height: 4.0),
                Text(price,
                    style: const TextStyle(
                        color: Color(0xFFCC8053),
                        fontFamily: 'Varela',
                        fontSize: 20.0)),
                Text(name,
                    style: const TextStyle(
                        color: Color(0xFF575E67),
                        fontFamily: 'Varela',
                        fontSize: 20.0)),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Container(color: const Color(0xFFEBEBEB), height: 1.0)),
                Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.remove_circle_outline,
                                color: Color(0xFFD17E50), size: 18.0),
                            Text('3',
                                style: TextStyle(
                                  fontFamily: 'Varela',
                                  color: Color(0xFFD17E50),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                )),
                            Icon(Icons.add_circle_outline,
                                color: Color(0xFFD17E50), size: 18.0),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.shopping_basket,
                                  color: Color(0xFFD17E50), size: 18.0),
                              Text('Add to cart',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Color(0xFFD17E50),
                                      fontSize: 18.0))
                            ]),
                      ],
                    )),
              ])),
        ));
  }
}
//main axis spacing helped get rid off bottom overflow for every card;