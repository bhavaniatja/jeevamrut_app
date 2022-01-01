import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/bloc/categories/categories_bloc.dart';
import 'package:jeevamrut_app/components/product_card.dart';
import 'package:jeevamrut_app/models/product_response.dart';

class ProductGrid extends StatefulWidget {
  final String? selectedSubCategory;
  final String? category;
  final String? pincode;
  const ProductGrid(this.selectedSubCategory, this.category, this.pincode,
      {Key? key})
      : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(LoadingCategoriesEvent());
    BlocProvider.of<CategoriesBloc>(context).add(LoadCategories(
        widget.category!, widget.selectedSubCategory!, widget.pincode!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.category}" + widget.selectedSubCategory!);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoriesLoaded) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: 1.0,
                childAspectRatio: 0.8,
              ),
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  width: MediaQuery.of(context).size.width - 30.0,
                  height: MediaQuery.of(context).size.height - 50.0,
                  child: ProductCard(product: state.products[index]),
                );
              });
        }
        return Text("Nothing");
      },
    );
  }
}
