import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/response/room_model.dart';
import '../../../../util/styles.dart';

class NameWidget extends StatelessWidget {
  final RoomModel roomModel;
  const NameWidget({super.key, required this.roomModel});

  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  roomModel.name!,
                  style: robotoWhite700,
                ),
                 Text(
                  "id: ${roomModel.owner?.uuid??""}",
                  style: robotoWhite700,
                )
              ],
            )
          ],
        ),
        const Spacer(),
        Padding(
          padding:  EdgeInsets.only(top: 5.h),
          child: const Icon(Icons.add_circle_outline,color: Colors.white,size: 28,),
        )
      ],
    );
  }
}
