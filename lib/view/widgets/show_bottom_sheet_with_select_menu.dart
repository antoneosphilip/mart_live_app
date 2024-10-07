import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/src/components/member/select_menu.dart';

void showBottomSheetWithSelectMenu(BuildContext context,String userId) {

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SelectMenuBottomSheet(userId: userId,);
    },
  );
}
