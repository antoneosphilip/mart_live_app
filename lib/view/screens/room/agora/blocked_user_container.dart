import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_app/data/model/response/room_model.dart';

import 'package:live_app/view/screens/family/widget/custom_netwok_image.dart';

import '../../../widgets/show_bottom_sheet_with_select_menu.dart';
import 'button_item.dart';

class BlockUserContainer extends StatelessWidget {
  final User user;

  const BlockUserContainer({super.key, required this.user});



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
        width: 1000.w,
        height: 400.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Image(
              image:
              const AssetImage('assets/images/member_image.webp'),
              fit: BoxFit.cover,
              height: 400.h,
              width: 300.h,
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                    child: CustomNetworkImage(
                      image: user.image,
                      width: 70.w,
                      height: 70.h,
                    )),
                Text(
                  user.name??" ",
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlueAccent),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.uuid.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.copy_rounded,
                      color: Colors.grey,
                      size: 25.sp,
                    )
                  ],
                ),
                SizedBox(
                  height: 140.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ButtonItem(
                      text: 'Send a Gift',
                      image: 'assets/images/send_gift.webp',
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const ButtonItem(
                      text: 'Follow',
                      image: 'assets/images/send_gift.webp',
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const ButtonItem(
                      text: 'Message',
                      image: 'assets/images/send_gift.webp',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    InkWell(
                      onTap: (){
                        showBottomSheetWithSelectMenu(context,user.id.toString());
                      },
                      child: const ButtonItem(
                        text: 'BlackList',
                        image: 'assets/images/send_gift.webp',
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const ButtonItem(
                      text: 'Mute',
                      image: 'assets/images/send_gift.webp',
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const ButtonItem(
                      text: 'BlackList',
                      image: 'assets/images/send_gift.webp',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(16.r), // Dialog border radius
      ),
    );
  }
}
