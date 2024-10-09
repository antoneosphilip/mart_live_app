import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/my_profile_model.dart';
import 'package:live_app/helper/route_helper.dart';
import 'package:live_app/util/styles.dart';
import 'package:live_app/view/screens/users/widget/image_person.dart';
import 'package:live_app/view/screens/users/widget/list_profile_item.dart';
import 'package:live_app/view/screens/users/widget/my_profile_item.dart';
import 'package:live_app/view/screens/wallet/widget/custom_line.dart';

import '../../widgets/app_bar.dart';
import '../all_families/all_faimiles_Appbar_widget/image_person.dart';
import '../countries/country_list.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        name: 'Edit information',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            const ProfileImagePerson(),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                "Signature:",
                style: robotoBlack.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            const CustomLine(),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.w),
              child: Text("My Profile",style: robotoBlack.copyWith(fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 20.h,),
            ListView.separated(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return  MyProfileItem(
                    icon: profileItems[index].icon,
                    text: profileItems[index].text,
                    text2: profileItems[index].text2,
                    isIcon: profileItems[index].isIcon,
                    onPressed:profileItems[index].onPressed, iconColor: profileItems[index].colorIcon,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15.h,
                  );
                },
                itemCount: 5)
          ],
        ),
      ),
    );
  }
}
