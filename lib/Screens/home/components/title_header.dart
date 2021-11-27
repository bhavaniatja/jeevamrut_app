import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/cart/cart_screen.dart';
import 'package:jeevamrut_app/Screens/home/components/app_title.dart';
import 'package:jeevamrut_app/Screens/home/components/location_field.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          AppTitle(),
          Spacer(),
          Expanded(
            flex: 2,
            child: LocationField(),
          ),
        ],
      ),
    );
  }
}
