import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/room_controller.dart';
import 'package:live_app/data/model/response/room_model.dart';
import 'package:live_app/data/model/response/user_model.dart';
import 'package:live_app/view/screens/room/zego_platform/audio/zego_helpers.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

import '../../../../../controller/splash_controller.dart';

class ZegoRoomScreen extends StatefulWidget {
  final UserModel user;
  final RoomModel room;

  const ZegoRoomScreen({
    Key? key,
    required this.room,
    required this.user,
  }) : super(key: key);

  @override
  _ZegoRoomScreenState createState() => _ZegoRoomScreenState();
}

class _ZegoRoomScreenState extends State<ZegoRoomScreen> {
  final isSeatClosedNotifier = ValueNotifier<bool>(false);
  final isRequestingNotifier = ValueNotifier<bool>(false);

  Map<int, ZegoUIKitUser> previousTakenSeats = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RoomController>(
        builder: (roomController) {
          return ZegoUIKitPrebuiltLiveAudioRoom(
            appID: int.parse(
              "${Get.find<SplashController>().configModel!.liveStreamingAppID}",
            ),
            appSign:
                "${Get.find<SplashController>().configModel!.liveStreamingAppSign}",
            userID: "${widget.user.id}",
            userName: "${widget.user.name}",
            roomID: "${widget.room.id}",
            events: ZegoUIKitPrebuiltLiveAudioRoomEvents(
              user: ZegoLiveAudioRoomUserEvents(
                  // onLeave: (user) {}
                  ),
              seat: ZegoLiveAudioRoomSeatEvents(
                // onClicked: (index, user) {
                //   if (user == null) {
                //     if (roomController.inRoom?.IsUserRoomMicBlocked == true) {
                //       ZegoUIKitPrebuiltLiveAudioRoomController
                //           .instance.seat.audience
                //           .cancelTakingRequest();
                //       Get.defaultDialog(title: 'mic blocked');
                //     } else {
                //       ZegoUIKitPrebuiltLiveAudioRoomController
                //           .instance.seat.audience
                //           .applyToTake();
                //       // ZegoUIKitPrebuiltLiveAudioRoomController
                //       //     .instance.seat.host
                //       //     .acceptTakingRequest(userID);
                //     }
                //   }
                // },
                onClosed: () {
                  isSeatClosedNotifier.value = true;
                },
                onOpened: () {
                  isSeatClosedNotifier.value = false;
                },
                onChanged: (
                  Map<int, ZegoUIKitUser> takenSeats,
                  List<int> untakenSeats,
                ) {
                  Get.find<RoomController>().mics = [];
                  if (isRequestingNotifier.value) {
                    if (takenSeats.values
                        .map((e) => e.id)
                        .toList()
                        .contains("${widget.user.id}")) {
                      isRequestingNotifier.value = false;
                    }
                  }
                  takenSeats.forEach((seatID, user) async {
                    Get.find<RoomController>().updateMicList({
                      'seat': seatID,
                      'user_id': user.id,
                      'image': user.inRoomAttributes.value['img']
                    });
                  });
                  untakenSeats.forEach((seatID) {
                    // if (previousTakenSeats.containsKey(seatID) &&
                    //     !takenSeats.containsKey(seatID)) {
                    //   if (previousTakenSeats[seatID]?.id == userID) {
                    //     roomController.leaveMic(roomID, "${seatID}");
                    //   }
                    // }
                  });

                  previousTakenSeats = takenSeats;

                  // Update the previous state for the next onChanged event
                },
                host: ZegoLiveAudioRoomSeatHostEvents(
                  onTakingInvitationFailed: () {},
                  onTakingRequested: (user) {
                    if (user.inRoomAttributes.value['micbloc'] == 'true') {
                      isRequestingNotifier.value = false;
                    }
                  },
                ),
                audience: ZegoLiveAudioRoomSeatAudienceEvents(
                    onTakingRequestFailed: () {
                  isRequestingNotifier.value = false;
                }, onTakingRequestRejected: () {
                  isRequestingNotifier.value = false;
                }, onTakingInvitationReceived: () {
                  isRequestingNotifier.value = false;
                }),
              ),
            ),
            config: ZegoHelper.zegoUIKitPrebuiltLiveAudioRoomConfig(
                isHost: widget.room.isOwner!)
              ..turnOnMicrophoneWhenJoining = false
              ..useSpeakerWhenJoining = false
              ..seat.closeWhenJoining = false
              ..innerText.memberListTitle = 'Members'.tr
              ..seat.hostIndexes = [0]
              ..userInRoomAttributes = {
                'lvl': '1',
                'mb':
                    widget.room.IsUserRoomMicBlocked == true ? 'true' : 'false',
                'img': "${widget.user.image}",
              }
              ..seat.layout.rowConfigs = ZegoHelper.rowConfigs()
              ..confirmDialogInfo = ZegoHelper.zegoDialogInfo()
              ..background = ZegoHelper.background(
                backgroundImg: widget.room.background,
                roomName: widget.room.name,
                roomID: "${widget.user.uuid}",
              )
              ..mediaPlayer.supportTransparent = true
              ..bottomMenuBar = ZegoHelper.zegoBottomMenuBarConfig()
              ..bottomMenuBar.showInRoomMessageButton = true
              ..inRoomMessage = ZegoHelper.zegoInRoomMessageConfig(
                  userImage: widget.user.image)
              ..seat.backgroundBuilder = ZegoHelper.backgroundBuilder
              ..seat.foregroundBuilder = ZegoHelper.foregroundBuilder
              ..seat.avatarBuilder = (BuildContext context, Size size,
                      ZegoUIKitUser? user, Map extraInfo) =>
                  ZegoHelper.avatarBuilder(
                    size: size,
                    userImage: "${user?.inRoomAttributes.value['img']}",
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Cleanup actions if needed
    isSeatClosedNotifier.dispose();
    isRequestingNotifier.dispose();
    Get.find<RoomController>().leaveRoom();
    super.dispose();
  }
}

//https://docs.zegocloud.com/article/16270
