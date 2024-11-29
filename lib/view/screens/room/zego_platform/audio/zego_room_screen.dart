import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/room_controller.dart';
import 'package:live_app/data/model/response/room_model.dart';
import 'package:live_app/data/model/response/user_model.dart';
import 'package:live_app/view/screens/room/zego_platform/audio/zego_helpers.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

import '../../gift/components/mp4_player_widget.dart';
import '../../gift/components/svga_player_widget.dart';
import '../../gift/gift_manager/defines.dart';
import '../../gift/gift_manager/gift_data.dart';
import '../../gift/gift_manager/gift_manager.dart';

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
  final List<StreamSubscription<dynamic>?> _subscriptions = [];

  @override
  void initState() {
    ZegoGiftManager().cache.cacheAllFiles(giftItemList);

    ZegoGiftManager().service.recvNotifier.addListener(onGiftReceived);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ZegoGiftManager().service.init(
        appID: 942627096,
        liveID: widget.room.id.toString(),
        localUserID: widget.user.id.toString(),
        localUserName: 'user_${widget.user.id}',
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RoomController>(
        builder: (roomController) {
          return ZegoUIKitPrebuiltLiveAudioRoom(
            appID: 942627096,
            appSign:
                '69e9e1f54945e58f8a55f1cc94d0903611886e06e8b731010a9889a7cd533ce8',
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
                //     if (roomController.inRoom?.isUserRoomMicBlocked == true) {
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
                    widget.room.isUserRoomMicBlocked == true ? 'true' : 'false',
                'img': "${widget.user.image}",
              }
              ..seat.layout.rowConfigs = ZegoHelper.rowConfigs()
              ..confirmDialogInfo = ZegoHelper.zegoDialogInfo()
              ..background = ZegoHelper.background(
                backgroundImg: widget.room.background,
                roomName: widget.room.name,
                roomID: "${widget.user.uuid}",
              )
              ..foreground=giftForeground()
              ..mediaPlayer.supportTransparent = true
              ..bottomMenuBar =
                  ZegoHelper.zegoBottomMenuBarConfig(roomId: widget.room.id!)
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
Widget giftForeground() {
  return ValueListenableBuilder<PlayData?>(
    valueListenable: ZegoGiftManager().playList.playingDataNotifier,
    builder: (context, playData, _) {
      if (null == playData) {
        return const SizedBox.shrink();
      }

      if (playData.giftItem.type == ZegoGiftType.svga) {
        return svgaWidget(playData);
      } else {
        return mp4Widget(playData);
      }
    },
  );
}

Widget svgaWidget(PlayData playData) {
  if (playData.giftItem.type != ZegoGiftType.svga) {
    return const SizedBox.shrink();
  }

  /// you can define the area and size for displaying your own
  /// animations here
  int level = 1;
  if (playData.giftItem.weight < 10) {
    level = 1;
  } else if (playData.giftItem.weight < 100) {
    level = 2;
  } else {
    level = 3;
  }
  switch (level) {
    case 2:
      return Positioned(
        top: 100,
        bottom: 100,
        left: 10,
        right: 10,
        child: ZegoSvgaPlayerWidget(
          key: UniqueKey(),
          playData: playData,
          onPlayEnd: () {
            ZegoGiftManager().playList.next();
          },
        ),
      );
    case 3:
      return ZegoSvgaPlayerWidget(
        key: UniqueKey(),
        playData: playData,
        onPlayEnd: () {
          ZegoGiftManager().playList.next();
        },
      );
  }
  // level 1
  return Positioned(
    bottom: 200,
    left: 10,
    child: ZegoSvgaPlayerWidget(
      key: UniqueKey(),
      size: const Size(100, 100),
      playData: playData,
      onPlayEnd: () {
        /// if there is another gift animation, then play
        ZegoGiftManager().playList.next();
      },
    ),
  );
}

Widget mp4Widget(PlayData playData) {
  if (playData.giftItem.type != ZegoGiftType.mp4) {
    return const SizedBox.shrink();
  }

  /// you can define the area and size for displaying your own
  /// animations here
  int level = 1;
  if (playData.giftItem.weight < 10) {
    level = 1;
  } else if (playData.giftItem.weight < 100) {
    level = 2;
  } else {
    level = 3;
  }
  switch (level) {
    case 2:
      return Positioned(
        top: 100,
        bottom: 100,
        left: 10,
        right: 10,
        child: ZegoMp4PlayerWidget(
          key: UniqueKey(),
          playData: playData,
          onPlayEnd: () {
            ZegoGiftManager().playList.next();
          },
        ),
      );
    case 3:
      return ZegoMp4PlayerWidget(
        key: UniqueKey(),
        playData: playData,
        onPlayEnd: () {
          ZegoGiftManager().playList.next();
        },
      );
  }
  // level 1
  return Positioned(
    bottom: 200,
    left: 10,
    child: ZegoMp4PlayerWidget(
      key: UniqueKey(),
      size: const Size(100, 100),
      playData: playData,
      onPlayEnd: () {
        /// if there is another gift animation, then play
        ZegoGiftManager().playList.next();
      },
    ),
  );
}
void onGiftReceived() {
  final receivedGift = ZegoGiftManager().service.recvNotifier.value ?? ZegoGiftProtocolItem.empty();
  final giftData = queryGiftInItemList(receivedGift.name);
  if (null == giftData) {
    debugPrint('not ${receivedGift.name} exist');
    return;
  }

  ZegoGiftManager().playList.add(PlayData(
    giftItem: giftData,
    count: receivedGift.count,
  ));
}
void onInRoomCommandMessageReceived(ZegoSignalingPluginInRoomCommandMessageReceivedEvent event,UserModel user) {
  final messages = event.messages;

  // You can display different animations according to gift-type
  for (final commandMessage in messages) {
    final senderUserID = commandMessage.senderUserID;
    final message = utf8.decode(commandMessage.message);
    debugPrint('onInRoomCommandMessageReceived: $message');
    if (senderUserID != user.id.toString()) {
      final gift = ZegoGiftProtocol.fromJson(message);
      ZegoGiftManager().service. recvNotifier.value = gift.giftItem;
    }
  }
}

//https://docs.zegocloud.com/article/16270
