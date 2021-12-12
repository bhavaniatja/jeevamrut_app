import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/Screens/productgrid/product_grid.dart';
import 'package:jeevamrut_app/cubit/app_cubits_cubit.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  getCategories(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 10.0, left: 10.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('Vegetables', 'assets/images/apples.png', context),
                  _buildCard('Fruits', 'assets/images/apples.png', context),
                  _buildCard('Leafies', 'assets/images/apples.png', context),
                  _buildCard('Rare', 'assets/images/apples.png', context),
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(String name, String imgPath, context) {
    final cubit = BlocProvider.of<AppCubitsCubit>(context);
    return Padding(
        padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              cubit.getData();
            },
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                          tag: imgPath,
                          child: Container(
                              height: 200.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(imgPath),
                                      fit: BoxFit.contain)))),
                      // SizedBox(height: 4.0),
                      Text(name,
                          style: TextStyle(
                              color: Color(0xFF575E67),
                              fontFamily: 'Varela',
                              fontSize: 20.0)),
                    ]))));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubitsCubit>(context);
    return BlocListener<AppCubitsCubit, AppCubitsState>(
      listener: (context, state) {
        if (state is AppLoading) {
          CircularProgressIndicator();
        } else if (state is AppLoaded && cubit.products != []) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProdcutGridScreen(cubit.products)));
        } else {
          Container(
            child: Text("Error Bae!"),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(body: getCategories(context)),
    );
  }
}
