import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/store_item_model.dart';

import '../data/api/api_checker.dart';
import '../data/model/response/type_model.dart';
import '../data/repository/my_bag_repo.dart';

class MyBagController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final MyBagRepo repo = MyBagRepo();
  late TabController tabController;
  bool loading = false;

  List<TypeModel> typesList = [];
  String? typeRelatedTo;
  List<StoreItemModel> itemsList = [];

  TypeModel? selectedType;
  StoreItemModel? selectedItem;
  int? currentPage = 1;
  bool isPreview = true;

  Future<void> getTypes() async {
    loading = true;
    update();
    Response response = await repo.getTypesList();
    if (response.statusCode == 200) {
      List<TypeModel> responseList = [];
      response.body['data'].forEach((item) {
        responseList.add(TypeModel.fromJson(item));
      });
      typesList = responseList;
      if (typesList.isNotEmpty) {
        selectedType = typesList[0];
      }
    } else {
      ApiChecker.checkApi(response);
    }
    tabController = TabController(length: typesList.length, vsync: this);
    tabController.addListener(_onTabChanged);
    loading = false;
    update();
  }

  void _onTabChanged() {
    selectedType = typesList[tabController.index];
    itemsList = selectedType!.items!;
  }

  Future<void> getItems(int? typeId) async {
    loading = true;
    update();
    Response response = await repo.getItemsList(selectedType?.id, currentPage);
    if (response.statusCode == 200) {
      List<StoreItemModel> responseList = [];
      response.body['data'].forEach((item) {
        responseList.add(StoreItemModel.fromJson(item));
      });
      itemsList = responseList;
    } else {
      ApiChecker.checkApi(response);
    }
    loading = false;
    update();
  }

  void setSelectedType(TypeModel typeModel) async {
    selectedType = typeModel;
    selectedItem = null;
    await getItems(selectedType?.id);
    update();
  }

  void setSelectedItem(StoreItemModel storeItemModel) {
    selectedItem = storeItemModel;
    isPreview = true;
    update();
  }

  void endPreview() {
    isPreview = false;
    update();
  }
}
