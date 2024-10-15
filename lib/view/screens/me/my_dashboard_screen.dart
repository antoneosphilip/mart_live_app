import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/auth_controller.dart';
import 'package:live_app/controller/user_controller.dart';
import 'package:live_app/util/app_constants.dart';
import 'package:live_app/util/dimensions.dart';
import 'package:live_app/util/images.dart';
import 'package:live_app/util/styles.dart';
import 'package:live_app/view/base/custom_image.dart';
import 'package:live_app/view/screens/level/level_screen.dart';
import 'package:live_app/view/screens/me/my_bage.dart';
import 'package:live_app/view/screens/users/followers_screen.dart';
import 'package:live_app/view/screens/users/followings_screen.dart';
import 'package:live_app/view/screens/users/visitors_screen.dart';
import 'package:live_app/view/screens/vip/vip_screen.dart';
import 'package:live_app/view/screens/wallet/wallet_screen.dart';
import 'package:live_app/view/widgets/custom_card.dart';
import 'package:live_app/view/widgets/image_button.dart';

import '../../../controller/reltionship_controller.dart';
import '../../../data/model/body/notification_body.dart';
import '../../../helper/route_helper.dart';
import '../../base/confirmation_dialog.dart';
import '../../widgets/loading_idicator.dart';
import '../create_family/create_family.dart';
import '../users/friends_screen.dart';
import '../users/user_details_screen.dart';

class MyDashboardScreen extends StatefulWidget {
  const MyDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MyDashboardScreen> createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen> {
  @override
  void initState() {
    Get.put(RelationshipController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        final bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
        return  userController.userInfoModel!=null?
        Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          body:  SingleChildScrollView(
            child: Ink(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeExtremeLarge,
                        right: Dimensions.paddingSizeExtremeLarge,
                        top: 50,
                        bottom: Dimensions.paddingSizeExtremeLarge,
                      ),
                      child: Row(children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(1),
                          child: InkWell(
                            onTap: () {
                              Get.find<UserController>().getUserDetails( Get.find<UserController>().userModel!.id!);
                              Get.to(UserDetailsScreen());
                            },
                            child: ClipOval(
                              child: CustomImage(
                                placeholder: Images.guestIconLight,
                                image: '${AppConstants.mediaUrl}/profile'
                                    '/${(userController.userInfoModel != null && isLoggedIn) ? userController.userInfoModel!.image : ''}',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeDefault),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${userController.userInfoModel?.fName} ${userController.userInfoModel?.lName}',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Theme.of(context).cardColor),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                Text(
                                  "${'id'.tr} : ${userController.userModel?.uuid}",
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).cardColor),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomImage(
                                      image:
                                      '${AppConstants.baseUrl}/${userController.userModel?.senderLevel?.currentImage}',
                                      width: 40,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    CustomImage(
                                      image:
                                      '${AppConstants.baseUrl}/${userController.userModel?.consigneeLevel?.currentImage}',
                                      width: 40,
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    padding: EdgeInsets.only(top: 10),
                    child: Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimensions.paddingSizeDefault,
                                  right: Dimensions.paddingSizeDefault),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.find<RelationshipController>()
                                          .getFriendList();
                                      Get.to(() => FriendsScreen());
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'friends'.tr,
                                          style: TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            '${userController.userModel?.friendsCount}'),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.find<RelationshipController>()
                                          .getFollowingsList();
                                      Get.to(() => FollowingsScreen());
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'followings'.tr,
                                          style: TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            '${userController.userModel?.followingsCount}'),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.find<RelationshipController>()
                                          .getFollowersList();
                                      Get.to(() => FollowersScreen());
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'followers'.tr,
                                          style: TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            '${userController.userModel?.followersCount}'),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.find<RelationshipController>()
                                          .getVisitorsList();
                                      Get.to(() => VisitorsScreen());
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'visitors'.tr,
                                          style: TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                            '${userController.userModel?.visitorsCount}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomCard(
                              backgroundImage:
                              'assets/images/wallet_card_bg.webp',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ImageButton(
                                    text: 'vip'.tr,
                                    image: 'assets/images/vip.webp',
                                    onTap: () {
                                      Get.to(VipScreen());
                                    },
                                  ),
                                  // ImageButton(
                                  //   text: 'pro'.tr,
                                  //   image: 'assets/images/pro.webp',
                                  //   onTap: () {},
                                  // ),
                                  ImageButton(
                                    text: 'shop'.tr,
                                    image: 'assets/images/'
                                        'shop.webp',
                                    onTap: () {
                                      Get.toNamed(RouteHelper.store);
                                    },
                                  ),
                                  ImageButton(
                                    text: 'my_bag'.tr,
                                    image: 'assets/images/bag.webp',
                                    onTap: () {
                                      Get.to(() => MyBagScreen());
                                    },
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => WalletScreen());
                              },
                              child: CustomCard(
                                // backgroundImage: 'assets/images/one_bg.png',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('my_wallet'.tr),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                        MediaQuery.of(context).size.height * 0.15,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          'assets/images/wallet_bg.webp'),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        Image(
                                                          width: 30,
                                                          height: 30,
                                                          image: AssetImage(
                                                            'assets/images/diamond_icon.webp',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${userController.userModel?.wallet?.diamond}',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets.all(5),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  'assets/images/gold_bg.webp'),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Image(
                                                                width: 25,
                                                                height: 25,
                                                                image: AssetImage(
                                                                  'assets/images/gold_icon.webp',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${userController.userModel?.wallet?.gold}',
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color:
                                                                    Colors.white),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets.all(5),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  'assets/images/game_bg.webp'),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Image(
                                                                width: 25,
                                                                height: 25,
                                                                image: AssetImage(
                                                                  'assets/images/game_icon.webp',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${userController.userModel?.wallet?.gameCoins}',
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color:
                                                                    Colors.white),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            CustomCard(
                              // backgroundImage: 'assets/images/one_bg.png',
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('other'.tr),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ImageButton(
                                              text: 'invite_friends'.tr,
                                              image: 'assets/icon/invite.webp',
                                              onTap: () {
                                                Get.toNamed(RouteHelper.inviteFriends);
                                              },
                                            ),
                                            ImageButton(
                                              text: 'level'.tr,
                                              image: 'assets/icon/level.webp',
                                              onTap: () {
                                                Get.to(const LevelScreen());
                                              },
                                            ),
                                            // ImageButton(
                                            //   text: 'my_family'.tr,
                                            //   image: 'assets/icon/my_family.webp',
                                            //   onTap: () {
                                            //     Get.to(
                                            //         () => const UserFamilyScreen(
                                            //               id: 0,
                                            //             ));
                                            //   },
                                            // ),
                                            ImageButton(
                                              text: 'my family'.tr,
                                              image: 'assets/icon/my_family.webp',
                                              onTap: () {
                                                Get.to(() => CreateFamily(
                                                  image: userController
                                                      .userModel?.image ??
                                                      "",
                                                  hasFamily: userController
                                                      .userModel!
                                                      .hasFamily!,
                                                  gold: userController
                                                      .userModel!
                                                      .wallet!
                                                      .gold!,
                                                  id:0,
                                                ));
                                              },
                                            ),
                                            // ImageButton(
                                            //   text: 'medals'.tr,
                                            //   image: 'assets/icon/medal.webp',
                                            //   onTap: () {},
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ImageButton(
                                              text: 'language'.tr,
                                              image: 'assets/icon/launage.webp',
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.getLanguageRoute(
                                                        'menu'));
                                              },
                                            ),
                                            ImageButton(
                                              text: 'contact_us'.tr,
                                              image: 'assets/icon/chat.webp',
                                              onTap: () {
                                                Get.toNamed(
                                                  RouteHelper.getChatRoute(
                                                    notificationBody:
                                                    NotificationBody(
                                                      notificationType:
                                                      NotificationType
                                                          .message,
                                                      receiverId: 0,
                                                      receiverType:
                                                      AppConstants.admin,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            ImageButton(
                                              text: 'settings'.tr,
                                              image: 'assets/icon/setting.webp',
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.settingScreen);
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ImageButton(
                                              text: 'network_test'.tr,
                                              image: 'assets/icon/net_test.webp',
                                              onTap: () {
                                                Get.toNamed(RouteHelper.networkTest);
                                              },
                                            ),
                                            ImageButton(
                                              text: 'our_policy'.tr,
                                              image: 'assets/icon/policy.webp',
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.getHtmlRoute(
                                                        'privacy-policy'));
                                              },
                                            ),
                                            ImageButton(
                                              text: 'log_out'.tr,
                                              image: 'assets/icon/logout.webp',
                                              onTap: () {
                                                if (Get.find<AuthController>()
                                                    .isLoggedIn()) {
                                                  Get.dialog(
                                                      ConfirmationDialog(
                                                          icon: Images.support,
                                                          description:
                                                          'are_you_sure_to_logout'
                                                              .tr,
                                                          isLogOut: true,
                                                          onYesPressed: () {
                                                            Get.find<
                                                                UserController>()
                                                                .clearUserInfo();
                                                            Get.find<
                                                                AuthController>()
                                                                .clearSharedData();
                                                            Get.find<
                                                                AuthController>()
                                                                .socialLogout();

                                                            Get.offAllNamed(RouteHelper
                                                                .getSignInRoute(
                                                                RouteHelper
                                                                    .splash));
                                                          }),
                                                      useSafeArea: false);
                                                } else {
                                                  Get.toNamed(
                                                      RouteHelper.getSignInRoute(
                                                          Get.currentRoute));
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 100,
                      )
                    ]),
                  ),
                ],
              ),
            ),
          )
        ):
        const LoadingIndicator();
      },
    );
  }
}
