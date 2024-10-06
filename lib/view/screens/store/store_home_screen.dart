import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/store_controller.dart';
import 'package:live_app/controller/user_controller.dart';
import 'package:live_app/util/app_constants.dart';
import 'package:svgaplayer_flutter/player.dart';

import '../../../util/images.dart';
import '../../widgets/loading_idicator.dart';

class StoreHomeScreen extends StatefulWidget {
  const StoreHomeScreen({super.key});

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  @override
  void initState() {
    super.initState();
    if (Get.find<StoreController>().typesList.isEmpty) {
      Get.find<StoreController>().getTypes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: GetBuilder<StoreController>(
        builder: (storeController) {
          return storeController.loading
              ? const LoadingIndicator()
              : Container(
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/main/app_bg.jpeg'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: Get.height * 0.3,
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          "${AppConstants.mediaUrl}/profile/${Get.find<UserController>().userInfoModel?.image}"),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 120,
                                      child: Center(
                                          child:
                                              (storeController.selectedType !=
                                                          null &&
                                                      storeController
                                                              .selectedItem !=
                                                          null &&
                                                      storeController
                                                              .selectedType
                                                              ?.relatedTo ==
                                                          'user_avatar' &&
                                                      storeController
                                                              .selectedItem
                                                              ?.type ==
                                                          'svg')
                                                  ? SVGASimpleImage(
                                                      resUrl:
                                                          "${AppConstants.baseUrl}/${storeController.selectedItem?.svg}",
                                                    )
                                                  : SizedBox()),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white70,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.black12,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: TabBar(
                                          isScrollable: true,
                                          indicator: BoxDecoration(
                                              color: Colors.black38,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          controller:
                                              storeController.tabController,
                                          tabs: [
                                            ...storeController.typesList
                                                .map((e) => Container(
                                                      child: Row(
                                                        children: [
                                                          e.image != null
                                                              ? Image(
                                                                  image: NetworkImage(
                                                                      "${AppConstants.baseUrl}/${e.image}"),
                                                                  width: 20,
                                                                  height: 20,
                                                                )
                                                              : SizedBox(),
                                                          Text(
                                                            '${e.name}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      // Use Expanded instead of Flexible
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: storeController.loading
                                            ? const LoadingIndicator()
                                            : TabBarView(
                                                controller: storeController
                                                    .tabController,
                                                children: [
                                                  ...storeController.typesList
                                                      .map(
                                                          (e) =>
                                                              GridView.builder(
                                                                itemCount: e
                                                                    .items
                                                                    ?.length,
                                                                gridDelegate:
                                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      4,
                                                                  crossAxisSpacing:
                                                                      10,
                                                                  mainAxisSpacing:
                                                                      10,
                                                                ),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Stack(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          storeController
                                                                              .setSelectedItem(e.items![index]);
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(2),
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border.all(
                                                                                color: storeController.selectedItem?.id == e.items?[index].id ? Colors.yellow : Colors.blueGrey,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Center(
                                                                                  child: Text(
                                                                                    "${e.items?[index].duration}",
                                                                                    style: TextStyle(color: Colors.teal, fontSize: 10),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 35,
                                                                                  height: 35,
                                                                                  decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                      image: NetworkImage("${AppConstants.baseUrl}/${e.items?[index].thumbnail}"),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Text(
                                                                                        '${e.items?[index].price}',
                                                                                        style: TextStyle(color: Colors.blue, fontSize: 10),
                                                                                      ),
                                                                                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                                                                                    ),
                                                                                    Image(
                                                                                      image: AssetImage(Images.smallRoomDiamondIcon),
                                                                                      width: 15,
                                                                                      height: 15,
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ))
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration:
                                  BoxDecoration(color: Colors.purpleAccent),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/diamond_icon.webp',
                                          width: 25,
                                          height: 25,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '${Get.find<UserController>().userModel?.wallet?.diamond}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 20,
                                              weight: 2000,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Buy'.tr),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                      Center(
                        child: (storeController.selectedType != null &&
                                storeController.selectedItem != null &&
                                storeController.selectedType?.relatedTo ==
                                    'entry_effect' &&
                                storeController.selectedItem?.type == 'svg' &&
                                storeController.isPreview == true)
                            ? InkWell(
                                onTap: () {
                                  storeController.endPreview();
                                },
                                child: SVGASimpleImage(
                                  resUrl:
                                      "${AppConstants.baseUrl}/${storeController.selectedItem?.svg}",
                                ),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                );
        },
      )),
    );
  }
}
