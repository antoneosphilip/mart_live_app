import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live_app/data/model/response/get_all_families.dart';

import '../data/api/api_checker.dart';
import '../data/model/response/family_model.dart';
import '../data/repository/family_repo.dart';

class FamilyController extends GetxController implements GetxService {
  final FamilyRepo familyRepo;
  FamilyResponse? familyResponse;
  String errorMessage='';
  GetAllFamilies? getAllFamilies;
  bool isLoading = false;
  FamilyController({required this.familyRepo});
  Future<void> getFamilyData({int id=0}) async {
    Response response;
    isLoading = true;
    print("yessssss");

    if(id==0) {
      response = await familyRepo.getFamily();
    }
    else{
      response=await familyRepo.getFamilies(id: id);
    }

    if (response.statusCode == 200) {
      if (response.body != null && response.body.containsKey('data') && response.body['data'] != null) {
        Map<String, dynamic> familyResponseModel = response.body;
        familyResponse = FamilyResponse.fromJson(familyResponseModel);
        errorMessage = '';
      } else {
        print("errooooooor");
        ApiChecker.checkApi(response,isList: false);
      }
    } else {
      ApiChecker.checkApi(response,isList: false);
    }

    isLoading = false;
    update();
  }

  Future<void> getAllFamilyData() async {
    isLoading = true;

    Response response = await familyRepo.getAllFamilies();

    if (response.statusCode == 200) {
      print("yessssssss");
      if (response.body != null && response.body.containsKey('data') && response.body['data'] != null) {
        Map<String, dynamic> familyResponseModel = response.body;
        getAllFamilies = GetAllFamilies.fromJson(familyResponseModel);
        errorMessage = '';
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      ApiChecker.checkApi(response);
    }

    isLoading = false;
    update();
  }

  Future<void> joinFamily({required familyId}) async {
    isLoading = true;

    Response response = await familyRepo.joinFamily(familyId: familyId);

    if (response.statusCode == 200) {
      errorMessage="join Successflly";
    }
    else
    {
      ApiChecker.checkApi(response,isList: false);
    }
    isLoading = false;
    update();
  }

  Future<void> leaveFamily() async {
    isLoading = true;

    Response response = await familyRepo.leaveFamily();

    if (response.statusCode == 200) {
      errorMessage="Leave Successflly";
    }
    else
    {
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
  }


}