import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/room_model.dart';

import '../../../../controller/room_controller.dart';
import '../../../../controller/user_controller.dart';
import '../../../../util/app_constants.dart';
import '../../../widgets/masked_image.dart';

class SquareTopRoomsItem extends StatelessWidget {
  final RoomModel room;
  final String? no;
  const SquareTopRoomsItem({super.key, required this.room, this.no});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<RoomController>().joinRoomAgora(room,Get.find<UserController>().userModel!);
      },
      child: MaskedImage(
        frame: room.frame != null
            ? "${AppConstants.mediaUrl}/${room.frame}"
            : null,
        name: room.name,
        no: no,
        hotIcon: 'assets/images/hot.webp',
        hot: room.totalIncome != null ? "${room.totalIncome}" : "0",
        numOfVisitors: "${room.visitorsCount}",
        country: room.owner?.country?.flag != null
            ? AppConstants.getMedia('country', "${room.owner?.country?.flag}")
            : null,
        isLocked: room.hasPassword!,
        image: AppConstants.getMedia('', "${room.cover}"),
      ),
    );
  }
}
