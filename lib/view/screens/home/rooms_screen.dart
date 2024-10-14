import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/view/screens/home/widget/banner_view.dart';

import '../../../controller/country_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/notification_controller.dart';
import '../../../controller/splash_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../data/model/response/room_model.dart';
import '../../../util/app_constants.dart';
import '../../base/custom_image.dart';
import '../../base/room/room_list_item.dart';
import '../../base/room/top_rooms/top_three_container.dart';
import '../../widgets/arrow_btn.dart';
import '../../widgets/loading_idicator.dart';
import '../../widgets/paginated_list_widget.dart';
import '../countries/country_list.dart';
import '../rooms/room_list_screen.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  static Future<void> loadData(bool reload) async {
    Get.find<HomeController>().getData();
  }

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isEndOfScreen = false;

  bool isLoading = false;
  int page = 1;
  List<RoomModel> roomList = [];
  List<RoomModel> topThree = [];

  @override
  void initState() {
    RoomsScreen.loadData(false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Container(
        child: RefreshIndicator(onRefresh: () async {
          splashController.setRefreshing(true);
          await Get.find<UserController>().getUserInfo();
          await Get.find<HomeController>().getData();
          await Get.find<NotificationController>().getNotificationList(true);
          splashController.setRefreshing(false);
        }, child: GetBuilder<HomeController>(builder: (homeController) {
          print("hasss more dataa ${homeController.hasMoreData}");

          return homeController.isLoading
              ? const LoadingIndicator()
              : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        Center(
                          child: SizedBox(
                            width: Get.width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CarouselView(
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      imageIndexName: 'image',
                                      baseUrl:
                                          "${AppConstants.mediaUrl}/banner",
                                      itemList: homeController.mainBanners,
                                      onPageChanged: (int index,
                                          CarouselPageChangedReason
                                              carouselPageChangedReason) {},
                                      onTap: (int index) async {},
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CarouselView(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30) *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          imageIndexName: 'image',
                                          baseUrl:
                                              "${AppConstants.mediaUrl}/banner",
                                          itemList: homeController.liftBanners,
                                          onPageChanged: (int,
                                              CarouselPageChangedReason) {},
                                          onTap: (int index) {},
                                          // scrollDirection: Axis.vertical,
                                          // duration: 4,
                                        ),
                                        CarouselView(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30) *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          imageIndexName: 'image',
                                          baseUrl:
                                              "${AppConstants.mediaUrl}/banner",
                                          itemList: homeController.rightBanners,
                                          onPageChanged: (int,
                                              CarouselPageChangedReason) {},
                                          onTap: (int index) {},
                                          // scrollDirection: Axis.vertical,
                                          // duration: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: TopThreeContainer(
                                      homeController: homeController,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                ...homeController.countries
                                                    .map((country) {
                                                  return TextButton(
                                                    onPressed: () {
                                                      Get.find<
                                                              CountryController>()
                                                          .selectCountry(
                                                              country.id);
                                                      Get.to(
                                                        RoomLisScreen(
                                                          title:
                                                              "${country.name}",
                                                          filter:
                                                              'country_id=${country.id}',
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color:
                                                              Colors.black12),
                                                      child: CustomImage(
                                                        height: 20,
                                                        width: 30,
                                                        image: AppConstants
                                                            .getMedia(
                                                          'country',
                                                          "${country.flag}",
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                              ],
                                            ),
                                          ),
                                        ),
                                        ArrowBtn(
                                          onTap: () {
                                            Get.to(
                                                () => const CountriesScreen());
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: PaginatedListWidget(
                                      scrollController: _scrollController,
                                      page: homeController.page,
                                      isLoading: homeController.isLoading,
                                      enabledPagination: true,
                                      onPaginate: (int? page) {
                                        homeController
                                            .paginate(homeController.page + 1);
                                      },
                                      itemView: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            ...?homeController.homeRooms?.map(
                                              (e) => Container(
                                                height: 120,
                                                child: RoomListItem(
                                                  userModel: Get.find<UserController>().userModel,
                                                  room: e,
                                                ),
                                              ),
                                            ),
                                            !homeController.hasMoreData?  Text("No more data".tr):const SizedBox()
                                          ],
                                        ),
                                      ),
                                    )
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        })),
      );
    });
  }
}
