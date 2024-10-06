import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/styles.dart';
import 'directors_item.dart';

class RoomDirectors extends StatelessWidget {
  const RoomDirectors({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 500.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.w,),
                    Column(
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2.w),
                          ),

                          child: const Icon(Icons.question_mark),
                        ),
                      ],
                    ),

                    const Spacer(),
                    Text(
                      'List of Directors(1/35)',
                      style: robotoBlack2,
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 20.h,),
                const DirectorsItem(),
              ],
            ),

          ],
        )
    );
  }
}
