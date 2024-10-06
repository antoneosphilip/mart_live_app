import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/vip_controller.dart';
import 'package:live_app/util/app_constants.dart';
import 'package:live_app/view/base/custom_image.dart';
import 'package:live_app/view/widgets/arrow_back.dart';
import 'package:live_app/view/widgets/svg/svg_with_png_and_texy.dart';
import 'package:svgaplayer_flutter/player.dart';

import '../../widgets/loading_idicator.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  @override
  void initState() {
    Get.put(VipController());
    Get.find<VipController>().getVipList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0,
          centerTitle: true,
          title: Text('Nobel Center'.tr),
          leading: ArrowBack(),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/vip_bg.webp',
              ),
            )),
            child: GetBuilder<VipController>(
              builder: (vipController) {
                return vipController.isLoading == true
                    ? Center(
                        child: LoadingIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: TabBar(
                              isScrollable: true,
                              controller: vipController.tabController,
                              indicatorColor: Colors.white,
                              indicatorWeight: 3,
                              indicatorPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              labelColor: Colors.white,
                              unselectedLabelColor:
                                  Theme.of(context).disabledColor,
                              tabs: [
                                ...vipController.vipList.map((e) => Tab(
                                      text: 'vip${e.no}',
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: TabBarView(
                              controller: vipController.tabController,
                              children: [
                                ...vipController.vipList.map(
                                  (e) => Center(
                                    child: Container(
                                      child: SvgWithPngAndText(
                                        width: 200,
                                        height: 200,
                                        svgPath:
                                            "${AppConstants.baseUrl}/${e.thumbnail}",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/vip_big_bg.webp'),
                                      fit: BoxFit.fill)),
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      child: Text(
                                        '${'Privileges'.tr} ${vipController.selectedVip?.activePrivilegesCount}/${vipController.selectedVip?.allPrivilegesCount}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 30),
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(50),
                                          bottomLeft: Radius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: GridView.builder(
                                          itemCount:
                                              vipController.selectedVip != null
                                                  ? vipController.selectedVip!
                                                      .privileges?.length
                                                  : 0,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                          ),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                if (vipController
                                                        .selectedVip!
                                                        .privileges![index]
                                                        .isActive ==
                                                    true) {
                                                  Widget? content;
                                                  if (vipController
                                                          .selectedVip!
                                                          .privileges![index]
                                                          .image !=
                                                      null) {
                                                    if (vipController
                                                            .selectedVip!
                                                            .privileges![index]
                                                            .imageType ==
                                                        'animated') {
                                                      content = SVGASimpleImage(
                                                        resUrl:
                                                            "${AppConstants.baseUrl}/${vipController.selectedVip!.privileges![index].image}",
                                                      );
                                                    } else {
                                                      content = CustomImage(
                                                          image:
                                                              "${AppConstants.baseUrl}/${vipController.selectedVip!.privileges![index].image}");
                                                    }
                                                  } else {
                                                    String? color =
                                                        vipController
                                                            .selectedVip!
                                                            .privileges![index]
                                                            .color;
                                                    int colorInt =
                                                        int.parse("0xFF$color");
                                                    content = Text(
                                                      '${vipController.selectedVip!.privileges![index].title}',
                                                      style: TextStyle(
                                                        color: Color(colorInt),
                                                      ),
                                                    );
                                                  }
                                                  Get.defaultDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      title:
                                                          "${vipController.selectedVip!.privileges![index].title}",
                                                      content: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        child: Center(
                                                          child: content,
                                                        ),
                                                      ));
                                                }
                                              },
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomImage(
                                                      height: 30,
                                                      width: 30,
                                                      image:
                                                          "${AppConstants.baseUrl}/${vipController.selectedVip!.privileges![index].thumbnail}",
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${vipController.selectedVip!.privileges![index].title}",
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: vipController
                                                                      .selectedVip!
                                                                      .privileges?[
                                                                          index]
                                                                      .isActive ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.white54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 20, top: 10, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${'open'.tr} vip${vipController.selectedVip?.no} : ${vipController.selectedVip?.price} ${'for'.tr} ${vipController.selectedVip?.duration} ${'days'.tr}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                ElevatedButton(
                                    onPressed: () {}, child: Text('buy'.tr))
                              ],
                            ),
                          )
                        ],
                      );
              },
            )),
      ),
    );
  }
}
