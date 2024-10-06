import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/vip_model.dart';
import 'package:live_app/data/repository/vip_repo.dart';

import '../data/api/api_checker.dart';

class VipController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final VipRepo repo = VipRepo();
  late TabController tabController;
  bool isLoading = false;
  List<VipModel> vipList = [];
  VipModel? selectedVip;
  Future<void> getVipList({int? type = 1}) async {
    isLoading = true;
    Response response = await repo.getVipList();
    if (response.statusCode == 200) {
      List<VipModel> newList = [];
      List vipListResponse = response.body['data'];
      for (var item in vipListResponse) {
        var country = VipModel.fromJson(item);
        newList.add(country);
      }
      vipList = newList;
      selectedVip = vipList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    tabController = TabController(length: vipList.length, vsync: this);
    tabController.addListener(_onTabChanged);
    update();
  }

  void _onTabChanged() {
    selectedVip = vipList[tabController.index];
    update();
  }

  void selectVip(VipModel vip) {
    selectedVip = vip;
    update();
  }
}
