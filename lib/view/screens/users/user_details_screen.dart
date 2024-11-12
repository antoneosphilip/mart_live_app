import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/user_controller.dart';
import 'package:live_app/data/model/response/conversation_model.dart';
import 'package:live_app/data/model/response/user_model.dart';
import 'package:live_app/util/dimensions.dart';
import 'package:live_app/util/styles.dart';
import 'package:live_app/view/widgets/loading_idicator.dart';
import 'package:live_app/view/widgets/section_container.dart';

import '../../../data/model/body/notification_body.dart';
import '../../../helper/route_helper.dart';
import '../../../util/app_constants.dart';
import '../../../util/images.dart';
import '../../base/custom_image.dart';
import '../../widgets/custom_bg_btn.dart';
import '../../widgets/top_3.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserModel? user;

  const UserDetailsScreen({super.key, this.user});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userController.isLoading
                ? const LoadingIndicator()
                : Stack(

                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${AppConstants.mediaUrl}/profile/${userController.userDetailsModel?.image}"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 25.h,),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: const Icon(
                                          Icons.arrow_back_ios, color: Colors.white
                                      ),
                                      onTap: () {
                                        print("ssss");
                                      },
                                    ),
                                    InkWell(
                                      child: const Icon(
                                          Icons.edit, color: Colors.white
                                      ),
                                      onTap: () {
                                        Get.toNamed(RouteHelper.editProfile,arguments: {
                                          'userModel':userController.userModel!
                                        });
                                      },
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          userController.userDetailsModel
                                                      ?.country !=
                                                  null
                                              ? Container(
                                                  width: 30,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          "${AppConstants.mediaUrl}/country/${userController.userDetailsModel?.country?.flag}",
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 30,
                                                ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ClipOval(
                                            child: CustomImage(
                                              placeholder: Images.guestIcon,
                                              image:
                                                  '${AppConstants.mediaUrl}/profile/${userController.userDetailsModel?.image}',
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          userController.userDetailsModel
                                                      ?.country !=
                                                  null
                                              ? Container(
                                                  width: 30,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          "${AppConstants.mediaUrl}/country/${userController.userDetailsModel?.country?.flag}",
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 30,
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${userController.userDetailsModel?.name}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black54,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 10),
                                            child: Text(
                                              '${'id'.tr}:${userController.userDetailsModel?.uuid}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                        text:
                                                            "${userController.userDetailsModel?.uuid}"))
                                                    .then((_) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Copied_to_your_clipboard'
                                                                  .tr)));
                                                });
                                              },
                                              child: const Icon(
                                                Icons.copy,
                                                size: 15,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            matchTextDirection: true,
                                            image: AssetImage(
                                                'assets/images/detail_bg.png'),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 10, left: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 25.h,),
                                          userController.userDetailsModel?.id ==
                                                  userController.userModel?.id
                                              ? SizedBox()
                                              : Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      CustomBgBtn(
                                                          text: userController
                                                                      .userDetailsModel
                                                                      ?.isFollowed ==
                                                                  true
                                                              ? 'unfollow'.tr
                                                              : 'follow'.tr,
                                                          img:
                                                              'assets/images/btn.webp',
                                                          onTab: () async {
                                                            Map<String, dynamic>
                                                                data = {};
                                                            if (userController
                                                                    .userDetailsModel
                                                                    ?.isFollowed ==
                                                                true) {
                                                              data = await userController
                                                                  .unfollow(
                                                                      userController
                                                                          .userDetailsModel!
                                                                          .id!);
                                                            } else {
                                                              data = await userController.follow(
                                                                  userController
                                                                      .userDetailsModel!
                                                                      .id!);
                                                            }
                                                            userController
                                                                .setUserDetailsModel(
                                                                    'isFollowed',
                                                                    data[
                                                                        'isFollowed']);
                                                            userController
                                                                .getUserData();
                                                          }),
                                                      CustomBgBtn(
                                                          text: userController
                                                                      .userDetailsModel
                                                                      ?.isFriend ==
                                                                  true
                                                              ? 'remove_friend'
                                                                  .tr
                                                              : 'add_friend'.tr,
                                                          img:
                                                              'assets/images/btn.webp',
                                                          onTab: () {}),
                                                    ],
                                                  ),
                                                ),

                                          Container(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  userController
                                                              .userDetailsModel
                                                              ?.gender ==
                                                          'male'
                                                      ? 'assets/images/male.webp'
                                                      : 'assets/images/female.webp',
                                                  width: 15,
                                                  height: 15,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CustomImage(
                                                  image:
                                                      "${AppConstants.baseUrl}/${userController.userDetailsModel?.consigneeLevel?.currentImage}",
                                                  width: 50,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CustomImage(
                                                  image:
                                                      "${AppConstants.baseUrl}/${userController.userDetailsModel?.senderLevel?.currentImage}",
                                                  width: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                                "${userController.userDetailsModel?.pio}"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  matchTextDirection: true,
                                                  image: AssetImage(
                                                      'assets/images/counts_bg.webp'),
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${userController.userDetailsModel?.wealth}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                    Text(
                                                      'Wealth'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Image(
                                                    width: 3,
                                                    image: AssetImage(
                                                        'assets/images/v_line.png'),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${userController.userDetailsModel?.charm}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                    Text(
                                                      'Charm'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Image(
                                                    width: 3,
                                                    image: AssetImage(
                                                        'assets/images/v_line.png'),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${userController.userDetailsModel?.followersCount}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                    Text(
                                                      'followers'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Image(
                                                    width: 3,
                                                    image: AssetImage(
                                                        'assets/images/v_line.png'),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${userController.userDetailsModel?.visitorsCount}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                    ),
                                                    Text(
                                                      'visitors'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SectionContainer(
                                            icon: 'assets/images/cup.png',
                                            title: 'top_supporters'.tr,
                                            color: Colors.orangeAccent
                                                .withOpacity(0.1),
                                            padding: EdgeInsets.only(top: 15),
                                            body: TopThree(
                                              users: userController
                                                  .userDetailsModel
                                                  ?.topSupporters,
                                            ),
                                          ),
                                          SectionContainer(
                                            icon: 'assets/images/medal.png',
                                            title: 'medals'.tr,
                                            color:
                                                Colors.yellow.withOpacity(0.1),
                                            padding: EdgeInsets.only(top: 15),
                                          ),
                                          SectionContainer(
                                            icon: 'assets/images/car.png',
                                            title: 'entrance_effect'.tr,
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            padding: EdgeInsets.only(top: 15),
                                          ),
                                          SectionContainer(
                                              icon:
                                                  'assets/images/gift_fill.png',
                                              title: 'gift_wall'.tr,
                                              color:
                                                  Colors.pink.withOpacity(0.1),
                                              padding: EdgeInsets.all(15),
                                              body: Wrap(
                                                children: [
                                                  ...?userController
                                                      .userDetailsModel
                                                      ?.receivedGifts
                                                      ?.map((e) => Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Column(
                                                              children: [
                                                                CustomImage(
                                                                  width: 50,
                                                                  height: 50,
                                                                  image:
                                                                      "${AppConstants.mediaUrl}/gift/${e.thumbnail}",
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                    "x ${e.totalQty}")
                                                              ],
                                                            ),
                                                          ))
                                                ],
                                              )),
                                          SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 193.h),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 100.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                                color: Colors.red,
                              image: const DecorationImage(image: AssetImage('assets/images/details_back_ground.webp'),fit: BoxFit.cover)
                            ),
                            child: Center(
                              child: Text("Details",style: robotoWhiteMedium.copyWith(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ),

                      userController.userDetailsModel?.id ==
                              userController.userModel?.id
                          ? SizedBox()
                          : Positioned(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          RouteHelper.getChatRoute(
                                            user: User(
                                                id: userController
                                                    .userDetailsModel?.id,
                                                image: userController
                                                    .userDetailsModel?.image,
                                                fName: userController
                                                    .userDetailsModel?.name,
                                                lName: ''),
                                            notificationBody: NotificationBody(
                                              notificationType:
                                                  NotificationType.message,
                                              receiverId: userController
                                                  .userDetailsModel?.id,
                                              receiverType:
                                                  AppConstants.customer,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.50,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 25),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/send_msg_bg.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/msg.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'send_message'.tr,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.50,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 25),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/send_gift_bg.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/gift.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'send_gift'.tr,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              bottom: 20,
                            )
                    ],
                  );
          },
        ),
      ),
    );
  }

  getData() {
    Get.find<UserController>().getUserDetails(widget.user!.id!);
  }
}
