import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_app/util/styles.dart';
import 'package:live_app/view/base/room/widget/type_room_item.dart';
import 'package:live_app/view/base/room/widget/type_room_list_view.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../custom_image.dart';

class EditRoom extends StatelessWidget {
  const EditRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_ground_type_room.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16.w,
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                const Spacer(),
                Center(
                    child: Text(
                  'edit room',
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
                const Spacer(),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: ClipOval(
                  child: CustomImage(
                    placeholder: Images.guestIconLight,
                    image:
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.coffee_sharp,
                        color: Colors.orangeAccent,
                      ),
                      Text(
                        'type room',
                        style: robotoWhiteMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const TypeRoomListView()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
