import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeevamrut_app/cubit/app_cubits_cubit.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubitsCubit, AppCubitsState>(
        builder: (context, state) {
          return Body(context);
        },
      ),
    );
  }
}
//special offers image dimensions ~1k*400px