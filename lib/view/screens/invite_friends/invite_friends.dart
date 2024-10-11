import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_app/util/styles.dart';
import 'package:live_app/view/screens/invite_friends/widget/invite_container.dart';
import 'package:live_app/view/screens/invite_friends/widget/invittion_code_container.dart';
import 'package:live_app/view/screens/invite_friends/widget/list_invite_item.dart';
import 'package:live_app/view/screens/invite_friends/widget/ranking_container.dart';
import 'package:live_app/view/screens/invite_friends/widget/top_three.dart';

import '../../../helper/responsive_helper.dart';
import '../../widgets/custom_clooval_image.dart';
import '../family/widget/custom_netwok_image.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/back_ground.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 120.h,),
                  const Center(
                    child:InvitationCodeContainer(),
                  ),
                  SizedBox(height: 5.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        const RankingContainer(text: 'Rewards Ranking',),
                        SizedBox(width: 16.w,),
                        const RankingContainer(text: 'Ranking',),
                        SizedBox(width: 16.w,),
                        const RankingContainer(text: 'My invitation',),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  const InviteContainer(),
                ],
              ),
            ),
            // Positioned(
            //     bottom: ResponsiveHelper.ofHeight(context, 0.05),
            //     child: SizedBox(
            //       width: ResponsiveHelper.ofWidth(context, 1),
            //       child: Center(
            //         child: InkWell(
            //           child: Container(
            //             height: 50,
            //             width: ResponsiveHelper.ofWidth(context, 0.6),
            //             decoration: const BoxDecoration(
            //               image: DecorationImage(
            //                 image: AssetImage(
            //                   'assets/images/family_btn_bg.webp',
            //                 ),
            //                 fit: BoxFit.fill,
            //               ),
            //             ),
            //             child: Center(
            //               child: Text(
            //                 'Bind',
            //                 style: const TextStyle(
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white60),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}
