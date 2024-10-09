import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/room_controller.dart';
import '../../wallet/widget/custom_line.dart';
import 'custom_line.dart';
import 'leave_from_room_dialog.dart';

void showCustomBottomSheet(BuildContext context,int numberOfItem,int roomId) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black, // Set background color to black
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             InkWell(
               onTap: ()
               {
                 if (numberOfItem != 0 &&
                     Get.find<RoomController>().seatNumber.isEmpty) {
                   Get.find<RoomController>()
                       .sitChair(seatNum: numberOfItem, roomId: roomId, isMute: false);
                   Get.back();
                 }
               },
               child: Text(
                'Take a seat',
                style: TextStyle(color: Colors.white60, fontSize: 12.sp),
                           ),
             ),
            const SizedBox(height: 20), // Space between the two options
            const CustomRoomLine(),
            const SizedBox(height: 5), // Space between the two options

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the bottom sheet
              },
              child:  Text(
                'Cancel',
                style: TextStyle(color: Colors.white60, fontSize: 12.sp),
              ),
            ),
            const SizedBox(height: 5), // Space between the two options
            const CustomRoomLine(),
          ],
        ),
      );
    },
  );
}
