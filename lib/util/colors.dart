import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

abstract class ColorManger
{
  static const Color primary=Colors.deepPurpleAccent;
  static const Color whiteColor=Color(0xffffffff);
  static const Color orangeColor=Colors.orange;
  static const Color grey=Colors.grey;
  static const Color deepGold=  Color(0xFF996633);
  static const Color deepGrey=  Color(0xFFA9A9A9);
  static const Color colorPurple= Color(0xFF6A1B9A) ;
  static const Color colorPurpleMix= Color(0xff4000bf);


  static LinearGradient get goldToWhiteGradient => const LinearGradient(
    colors: [deepGold, whiteColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get purpleToWhiteGradient => const LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}