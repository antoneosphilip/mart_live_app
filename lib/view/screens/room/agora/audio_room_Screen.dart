import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/room_controller.dart';
import 'package:live_app/data/model/response/user_model.dart';
import 'package:live_app/view/screens/room/agora/room_row_icons.dart';
import 'package:live_app/view/screens/room/agora/seat_item.dart';

import '../../../../data/model/response/room_model.dart';
import '../../../../util/styles.dart';
import 'custom_owner_iten.dart';
import 'leave_from_room_dialog.dart';
import 'name_widget.dart';

class AudioRoomAgoraScreen extends StatelessWidget {
  final RoomModel room;
  final UserModel userModel;

  const AudioRoomAgoraScreen(
      {super.key, required this.room, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (roomController) {
        return WillPopScope(
          onWillPop: () async {
            showCustomDialog(context, 'room', () async {
              await roomController.leaveChannel(
                userModel,
                room,
              );
            });
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,

            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/back_ground.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: roomController.inRoom != null
                      ? Column(
                          children: [
                            SizedBox(height: 20.h),
                            NameWidget(
                              roomModel: room, userModel: userModel,
                            ),
                            SizedBox(height: 40.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  child: room.owner != null
                                      ? const CustomOwnerItem()
                                      : SeatItem(
                                          chair: roomController.inRoom!.chairs![0],
                                          numberOfItem: 0,
                                          userModel: userModel,
                                          roomModel: room,
                                        ),
                                ),
                                SizedBox(width: 10.w,),
                                SizedBox(
                                  width: 50.w,
                                  child:Column(
                                    children: [
                                      SeatItem(
                                        chair: roomController.inRoom!.chairs![1],
                                        numberOfItem: 2,
                                        userModel: userModel,
                                        roomModel: room,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0),
                                        // Reduce top padding
                                        child: Text(
                                        "",
                                          // Show only the first name
                                          style: robotoWhite.copyWith(
                                              fontSize: 10),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          // Avoid overflow
                                          maxLines: 1,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            SizedBox(height: 15.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        4, // Number of items per row
                                    mainAxisSpacing:
                                        10, // Reduced vertical spacing
                                    crossAxisSpacing: 15,
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  itemCount:
                                      roomController.inRoom!.chairs!.length - 2,
                                  itemBuilder: (context, index) {
                                    return SeatItem(
                                      numberOfItem: index + 3,
                                      userModel: userModel,
                                      roomModel: room,
                                      chair: roomController
                                          .inRoom!.chairs![index + 2],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Spacer(),
                            RoomRowIcons(
                              roomController: roomController,
                              userModel: userModel,
                              room: room,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
