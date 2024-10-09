import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../data/model/response/my_profile_model.dart';
import '../../../../helper/route_helper.dart';
import '../../countries/country_list.dart';
import '../phone_screen.dart';

List<MyProfileModel> profileItems = [
  MyProfileModel(
    icon: getIconForText('Nickname'),
    text: 'Nickname',
    text2: 'tony3',
    isIcon: true,
    onPressed: () {
      Get.toNamed(RouteHelper.nickName);
    },
    colorIcon: getColorForText('Nickname'),
  ),
  MyProfileModel(
    icon: getIconForText('Gender'),
    text: 'Gender',
    text2: 'male',
    isIcon: false,
    onPressed: () {},
    colorIcon: getColorForText('Gender'),
  ),
  MyProfileModel(
    icon: getIconForText('Location'),
    text: 'Location',
    text2: '',
    isIcon: false,
    onPressed: () {
      Get.to( PhoneScreen());
    },
    colorIcon: getColorForText('Location'),
  ),
  MyProfileModel(
    icon: getIconForText('Level'),
    text: 'Level',
    text2: 'Lv.0',
    isIcon: false,
    onPressed: () {},
    colorIcon: getColorForText('Level'),
  ),
  MyProfileModel(
    icon: getIconForText('Signature'),
    text: 'Signature',
    text2: '',
    isIcon: true,
    onPressed: () {
      Get.toNamed(RouteHelper.signature);
    },
    colorIcon: getColorForText('Signature'),
  ),
];

IconData getIconForText(String text) {
  switch (text) {
    case 'Nickname':
      return Icons.person;
    case 'Gender':
      return Icons.male;
    case 'Location':
      return Icons.location_city;
    case 'Level':
      return Icons.format_align_justify;
    case 'Signature':
      return Icons.edit;
    default:
      return Icons.help_outline; // أيقونة افتراضية في حال عدم تطابق النص
  }
}

Color getColorForText(String text) {
  switch (text) {
    case 'Nickname':
      return Colors.pink;
    case 'Gender':
      return Colors.blue;
    case 'Location':
      return Colors.green;
    case 'Level':
      return Colors.orange;
    case 'Signature':
      return Colors.red;
    default:
      return Colors.grey; // لون افتراضي في حال عدم تطابق النص
  }
}
