import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/my_bag_controller.dart';
import 'package:live_app/controller/user_controller.dart';
import 'package:live_app/util/app_constants.dart';
import 'package:live_app/view/widgets/loading_idicator.dart';
import 'package:svgaplayer_flutter/player.dart';

import '../../../util/images.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    if (Get.find<MyBagController>().typesList.isEmpty) {
      Get.find<MyBagController>().getTypes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<MyBagController>(
          builder: (controller) {
            return controller.loading
                ? LoadingIndicator()
                : Container(
                    height: Get.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/main/app_bg.jpeg'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: [
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
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
                                                (controller.selectedType !=
                                                            null &&
                                                        controller
                                                                .selectedItem !=
                                                            null &&
                                                        controller.selectedType
                                                                ?.relatedTo ==
                                                            'user_avatar' &&
                                                        controller.selectedItem
                                                                ?.type ==
                                                            'svg')
                                                    ? SVGASimpleImage(
                                                        resUrl:
                                                            "${AppConstants.baseUrl}/${controller.selectedItem?.svg}",
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
                                                controller.tabController,
                                            tabs: [
                                              ...controller.typesList
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
                                          child: controller.loading
                                              ? const LoadingIndicator()
                                              : TabBarView(
                                                  controller:
                                                      controller.tabController,
                                                  children: [
                                                    ...controller.typesList
                                                        .map(
                                                            (e) => GridView
                                                                    .builder(
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
                                                                            controller.setSelectedItem(e.items![index]);
                                                                          },
                                                                          child: Container(
                                                                              padding: EdgeInsets.all(2),
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(
                                                                                  color: controller.selectedItem?.id == e.items?[index].id ? Colors.yellow : Colors.blueGrey,
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
                            ]),
                        Center(
                            child: (controller.selectedType != null &&
                                    controller.selectedItem != null &&
                                    controller.selectedType?.relatedTo ==
                                        'entry_effect' &&
                                    controller.selectedItem?.type == 'svg' &&
                                    controller.isPreview == true)
                                ? InkWell(
                                    onTap: () {
                                      controller.endPreview();
                                    },
                                    child: SVGASimpleImage(
                                      resUrl:
                                          "${AppConstants.baseUrl}/${controller.selectedItem?.svg}",
                                    ),
                                  )
                                : SizedBox()),
                      ],
                    ));
          },
        ),
      ),
    );
  }
}
