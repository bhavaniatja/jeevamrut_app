import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bloc/pincode/pincode_bloc.dart';

import 'components/body.dart';

class CategoriesScreen extends StatelessWidget {
  final String? category;
  final int? selectedInd;
  const CategoriesScreen({Key? key, this.category, this.selectedInd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocBuilder<PincodeBloc, PincodeState>(
        builder: (context, state) {
          if (state is PincodeEditedState) {
            return Body(selectedInd!, category!, state.pincode);
          }
          return Center(
            child: Text("Enter Pincode,Go to HomeScreen"),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new),
        color: Colors.black,
      ),
      title: Text(
        "Categories",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
