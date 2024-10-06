import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/room_controller.dart';
import 'package:live_app/data/model/response/user_model.dart';

import '../../../../data/model/response/room_model.dart';
import '../../../../util/colors.dart';
import '../../../base/room/gift_box.dart';
import 'icon.dart';

class RoomRowIcons extends StatefulWidget {
  final UserModel userModel;
  final RoomModel room;
   const RoomRowIcons({super.key, required this.userModel, required this.room});

  @override
  State<RoomRowIcons> createState() => _RoomRowIconsState();

}

class _RoomRowIconsState extends State<RoomRowIcons> {
  bool isMic=true;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            Get.find<RoomController>().sendMessageAgora(roomId: widget.room.id);

          },
            child: const RoomIcon(iconData: Icons.message)),
        const Spacer(),
         InkWell(
             onTap: (){
               isMic=!isMic;
               print(isMic);
               setState(() {
               });
               Get.find<RoomController>().manageMicrophone(widget.userModel.uuid!,!isMic);
             },
             child:  Get.find<RoomController>().seatNumber.isNotEmpty||widget.room.isOwner!
                 ?RoomIcon(iconData:isMic?
             Icons.mic:Icons.mic_off):const SizedBox()),
        SizedBox(
          width: 10.w,
        ),
        const RoomIcon(
          iconData: Icons.person,
          backGroundColor: ColorManger.colorPurple,
          iconColor: Colors.white,
        ),
        SizedBox(
          width: 10.w,
        ),
        const GiftBox(),
      ],
    );
  }
}
