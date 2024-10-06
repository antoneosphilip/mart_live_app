import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/room_model.dart';
import 'package:live_app/view/screens/room/agora/custom_name_user_room.dart';
import 'package:live_app/view/screens/room/agora/cutom_image_person_room.dart';
import 'package:live_app/view/screens/room/agora/take_seat_Dailog.dart';

import '../../../../controller/room_controller.dart';
import '../../../../data/model/response/user_model.dart';
import 'leave_from_room_dialog.dart';

class SeatItem extends StatelessWidget {
  final int numberOfItem;
  final RoomModel roomModel;
  final UserModel userModel;
  final Chairs? chair;

  const SeatItem({
    super.key,
    required this.numberOfItem,
    required this.roomModel,
    required this.userModel,
    this.chair,
  });

  @override
  Widget build(BuildContext context) {
    final seatNumber = Get.find<RoomController>().seatNumber[numberOfItem];
    return InkWell(
      onTap: () {
        if (chair!.user == null && chair!.isLocked != 1) {
          if (Get.find<RoomController>().seatNumber.isEmpty) {
            showCustomBottomSheet(context, numberOfItem, roomModel.id!);
          } else {
            if (seatNumber == true) {
              print("sssssssssssss");
              showCustomDialog(context, "seat", () async {
                await Get.find<RoomController>()
                    .leaveChair(seatNum: numberOfItem);
              });
            } else if (numberOfItem != 0 && seatNumber == null) {
              Get.find<RoomController>()
                  .sitChair(seatNum: numberOfItem, roomId: roomModel.id!,isMute:chair!.isMuted==0?false:true);
            }
          }
        }
      },
      child: Column(
        children: [
          Container(
            width: 50.w, // Reduced width
            decoration: BoxDecoration(
              color: Colors.white70.withOpacity(.7),
              shape: BoxShape.circle,
            ),
            child: chair!.user == null &&
                    (seatNumber == null || seatNumber == false)
                ? Container(
                    decoration: chair!.teamNumber == 0
                        ? const BoxDecoration()
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            color: chair!.teamNumber == 1
                                ? Colors.red
                                : Colors.green,
                          ),
                    child: Padding(
                      padding: EdgeInsets.all(chair!.teamNumber == 0 ? 0 : 1.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/image/chair.webp'),
                                fit: BoxFit
                                    .cover, // Ensure the image covers the circle
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5), // Reduced padding
                                child: Text(
                                  numberOfItem.toString(),
                                  style: const TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 12), // Reduced font size
                                ),
                              ),
                            ],
                          ),
                          chair!.isLocked == 1
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 1.h, right: 1.w),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                        size: 20.sp,
                                      )),
                                )
                              : chair!.isMuted == 1
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 1.h, right: 1.w),
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Icon(
                                            Icons.volume_off,
                                            color: Colors.grey,
                                            size: 20.sp,
                                          )),
                                    )
                                  : const SizedBox()
                        ],
                      ),
                    ),
                  )
                : chair!.user == null &&
                        (seatNumber != null && seatNumber != false)
                    ? CustomImagePersonRoom(
                        image: userModel.image!,
                        chair: chair,
                      )
                    : chair!.user != null &&
                            (seatNumber == null || seatNumber == false)
                        ? CustomImagePersonRoom(
                            image: chair!.user!.image!,
                            chair: chair,
                          )
                        : const SizedBox(),
          ),
          chair!.user == null && (seatNumber == null || seatNumber == false)
              ? const SizedBox()
              : chair!.user == null &&
                      (seatNumber != null && seatNumber != false)
                  ? CustomNameUserRoom(
                      text: userModel.name.toString(),
                    )
                  : chair!.user != null &&
                          (seatNumber == null || seatNumber == false)
                      ? CustomNameUserRoom(
                          text: chair!.user!.name.toString(),
                        )
                      : const SizedBox()
        ],
      ),
    );
  }
}