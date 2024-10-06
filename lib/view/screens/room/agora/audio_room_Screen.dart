import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/room_controller.dart';
import 'package:live_app/data/model/response/user_model.dart';
import 'package:live_app/view/screens/room/agora/room_row_icons.dart';
import 'package:live_app/view/screens/room/agora/seat_item.dart';

import '../../../../data/model/response/room_model.dart';
import '../../../../util/styles.dart';
import 'leave_from_room_dialog.dart';
import 'name_widget.dart';

class AudioRoomAgoraScreen extends StatefulWidget {
  final RoomModel room;
  final UserModel userModel;

  const AudioRoomAgoraScreen(
      {super.key, required this.room, required this.userModel});

  @override
  State<AudioRoomAgoraScreen> createState() => _AudioRoomAgoraScreenState();
}

class _AudioRoomAgoraScreenState extends State<AudioRoomAgoraScreen>
    with SingleTickerProviderStateMixin {
  final roomController=Get.find<RoomController>();
  @override
  void initState() {
    roomController.userAnimation(
      vsync: this, // تمرير الـ vsync
    );
    if (widget.room.isOwner!) {
      Get.find<RoomController>()
          .agoraEngine
          ?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (roomController) {
        return WillPopScope(
          onWillPop: () async {
            showCustomDialog(context, 'room', () async {
              await roomController.leaveChannel(
                widget.userModel,
                widget.room,
              );
            });
            return true;
          },
          child: Scaffold(
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
                            NameWidget(roomModel: widget.room,),
                            SizedBox(height: 40.h),
                            SizedBox(
                              width: 50.w,
                              child: widget.room.owner != null
                                  ? AnimatedBuilder(
                                      animation: roomController.controller!,
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Transform.translate(
                                          offset: Offset(roomController.animation!.value,0 ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ClipOval(
                                                // Make sure the image fits in a circular shape
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                                                  // Provide a local placeholder image
                                                  image:
                                                      '${roomController.inRoom!.owner!.image}',
                                                  fit: BoxFit.cover,
                                                  // Ensure the image covers the entire circular area
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return const Image(
                                                        image: NetworkImage(
                                                            'https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2')); // Handle image loading error
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                // Reduce top padding
                                                child: Text(
                                                  roomController
                                                      .inRoom!.owner!.name!,
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
                                        );
                                      },
                                    )
                                  : SeatItem(
                                      chair: roomController.inRoom!.chairs![0],
                                      numberOfItem: 0,
                                      userModel: widget.userModel,
                                      roomModel: widget.room,
                                    ),
                            ),
                            SizedBox(width: 4.w,),
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
                                      roomController.inRoom!.chairs!.length - 1,
                                  itemBuilder: (context, index) {
                                    final seatNumber =
                                        roomController.seatNumber[index + 1];
                                    return SeatItem(
                                      numberOfItem: index + 2,
                                      userModel: widget.userModel,
                                      roomModel: widget.room,
                                      chair: roomController
                                          .inRoom!.chairs![index + 1],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Spacer(),
                            RoomRowIcons(
                              userModel: widget.userModel,
                              room: widget.room,
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