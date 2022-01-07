import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/categories/categories_screen.dart';
import 'package:jeevamrut_app/bloc/categories/categories_bloc.dart';
import '../../../constants.dart';
import 'product_grid.dart';
import '../../../models/categories_list.dart';

class Body extends StatefulWidget {
  final String category;
  final String pincode;
  final int selectedInd;
  const Body(this.selectedInd, this.category, this.pincode, {Key? key})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: SizedBox(
            height: 25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: map[widget.category]!.length,
              itemBuilder: (context, index) => buildCategory(index),
            ),
          ),
        ),
        Expanded(
            child: ProductGrid(
                map[widget.category]!.elementAt(widget.selectedInd),
                widget.category,
                widget.pincode)),
      ],
    );
  }

  Widget buildCategory(int index) {
    int selectedIndex;
    return GestureDetector(
      onTap: () {
        selectedIndex = index;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CategoriesScreen(
                    selectedInd: selectedIndex, category: widget.category)));
        // BlocProvider.of<CategoriesBloc>(context).add(LoadingCategoriesEvent());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              map[widget.category]!.elementAt(index),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    widget.selectedInd == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: widget.selectedInd == index
                  ? Colors.black
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
