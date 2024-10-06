import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/auth_controller.dart';
import 'package:live_app/controller/splash_controller.dart';
import 'package:live_app/data/model/body/notification_body.dart';
import 'package:live_app/helper/route_helper.dart';
import 'package:live_app/util/app_constants.dart';
import 'package:live_app/util/dimensions.dart';
import 'package:live_app/util/images.dart';
import 'package:live_app/view/base/no_internet_screen.dart';
import 'package:svgaplayer_flutter/player.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({Key? key, required this.body}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 3 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        Timer(const Duration(seconds: 30), () async {
          if (widget.body != null) {
            if (widget.body!.notificationType == NotificationType.order) {
            } else if (widget.body!.notificationType ==
                NotificationType.general) {
              Get.offNamed(
                  RouteHelper.getNotificationRoute(fromNotification: true));
            } else {
              Get.offNamed(RouteHelper.getChatRoute(
                  notificationBody: widget.body,
                  conversationID: widget.body!.conversationId,
                  fromNotification: true));
            }
          } else {
            if (Get.find<AuthController>().isLoggedIn()) {
              Get.find<AuthController>().updateToken();
              Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();

    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.fill),
              ),
              child: SVGASimpleImage(
                assetsName: "assets/svg/frasha.svga",
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.4,
              child: Center(
                child: splashController.hasConnection
                    ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(Images.logo),
                          ),
                          SizedBox(height: Dimensions.paddingSizeSmall),
                          Text(
                            AppConstants.appName,
                            style: TextStyle(color: Colors.cyan),
                          )
                        ],
                      )
                    : NoInternetScreen(child: SplashScreen(body: widget.body)),
              ),
            ),
          ],
        );
      }),
    );
  }
}
