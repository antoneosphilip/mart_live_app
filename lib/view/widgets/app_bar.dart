import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../util/dimensions.dart';
import '../base/custom_app_bar.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const AppBarCustom({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return  CustomAppBar (
      title: name.tr,
      font: Dimensions.fontSizeExtraLarge,
      fontWeight: FontWeight.w500,
      iconSize: 20,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60.0); // Adjust the height here
}
