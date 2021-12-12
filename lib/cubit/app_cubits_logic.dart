import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/bottomnav.dart';
import 'package:jeevamrut_app/cubit/app_cubits_cubit.dart';

class AppLogic extends StatefulWidget {
  const AppLogic({Key? key}) : super(key: key);

  @override
  _AppLogicState createState() => _AppLogicState();
}

class _AppLogicState extends State<AppLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubitsCubit, AppCubitsState>(
        builder: (context, state) {
          if (state is AppLoading) {
            print("Loading...");
            return CircularProgressIndicator();
          } else if (state is AppLoaded) {
            print("Yes");
            return BottomNav();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
