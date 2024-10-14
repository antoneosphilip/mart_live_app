import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_app/controller/auth_controller.dart';
import 'package:live_app/data/api/api_checker.dart';
import 'package:live_app/data/model/response/conversation_model.dart';
import 'package:live_app/data/model/response/response_model.dart';
import 'package:live_app/data/model/response/user_details_model.dart';
import 'package:live_app/data/model/response/user_model.dart';
import 'package:live_app/data/model/response/userinfo_model.dart';
import 'package:live_app/data/repository/user_repo.dart';
import 'package:live_app/helper/network_info.dart';
import 'package:live_app/helper/route_helper.dart';
import 'package:live_app/view/base/custom_snackbar.dart';
import 'package:live_app/view/widgets/flutter_Show_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/update_profile_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  UserInfoModel? _userInfoModel;
  UserModel? userModel;
  UserDetailsModel? userDetailsModel;
  int? userDetailsId;
  XFile? _pickedFile;
  Uint8List? _rawFile;
  bool _isLoading = false;
  final TextEditingController pioController = TextEditingController();

  UserInfoModel? get userInfoModel => _userInfoModel;
  XFile? get pickedFile => _pickedFile;
  Uint8List? get rawFile => _rawFile;
  bool get isLoading => _isLoading;
  var nameController=TextEditingController();

  Future<Map<String, dynamic>> follow(int user_id) async {
    Map<String, dynamic> data = {};
    Response response = await userRepo.follow(user_id);
    if (response.statusCode == 200) {
      data = response.body['data'];
    } else {
      ApiChecker.checkApi(response);
    }
    return data;
  }

  Future<Map<String, dynamic>> unfollow(int user_id) async {
    Map<String, dynamic> data = {};
    Response response = await userRepo.unfollow(user_id);
    if (response.statusCode == 200) {
      data = response.body['data'];
    } else {
      ApiChecker.checkApi(response);
    }
    return data;
  }

  void setUserDetailsModel(String key, dynamic value) {
    switch (key) {
      case 'isFollowed':
        userDetailsModel?.isFollowed = value;
        break;
      case 'isFriend':
        userDetailsModel?.isFriend = value;
        break;
      default:
        break;
    }
    update();
  }

  Future<ResponseModel> getUserInfo() async {
    print("infooooooooo");
    _pickedFile = null;
    _rawFile = null;
    ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.body);
      responseModel = ResponseModel(true, 'successful');
    } else {
      responseModel = ResponseModel(false, response.statusText);
      ApiChecker.checkApi(response,isList: false);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> getUserData() async {
    print("getttttttttttttt");

    ResponseModel responseModel;
    Response response = await userRepo.getUserData();
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(response.body['data']);
      responseModel = ResponseModel(true, 'successful');
    } else {
      responseModel = ResponseModel(false, response.statusText);
      ApiChecker.checkApi(response,isList: false);
    }
    update();
    return responseModel;
  }

  Future<void> getUserDetails(int user_id) async {
    print("datttttttttttttta");
    if (userDetailsModel != null && userDetailsId == user_id) {
      return;
    }
    _isLoading = true;
    update();
    Response response = await userRepo.getUserDetails(user_id);

    if (response.statusCode == 200) {
      userDetailsModel = UserDetailsModel.fromJson(response.body['data']);
      print('nammmmmmmmmmme ${userDetailsModel?.name}');
    } else {
      print("errrrrrrrrrrrr");
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    userDetailsId = user_id;
    update();
  }

  void setForceFullyUserEmpty() {
    _userInfoModel = null;
  }
  Future<void> updateUserInfo(
      UpdateProfileModel updateProfileModel,{bool? isBack}) async {
    if(isBack??true){
      Get.back();
    }
    userDetailsModel=null;
    _isLoading = true;
    update();
    Response response =
        await userRepo.updateProfile(updateProfileModel,_pickedFile);
    _isLoading = false;
    if (response.statusCode == 200) {
      print("succcccccccesss");
      // _userInfoModel = updateProfileModel;
      // _pickedFile = null;
      // _rawFile = null;
      getUserInfo();
      getUserDetails(userModel!.id!);
      nameController.clear();
      flutterShowToast(message:'updated Successfully', toastCase: ToastCase.success);
    } else {
      print("erooooooooooooor");
      // responseModel = ResponseModel(false, response.statusText);
      ApiChecker.checkApi(response,isList: false);
    }
    update();
  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      String? message = response.body["message"];
      responseModel = ResponseModel(true, message);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    update();
    return responseModel;
  }

  void updateUserWithNewData(User? user) {
    _userInfoModel!.userInfo = user;
  }
  XFile? image;

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source:ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = await NetworkInfo.compressImage(_pickedFile!);
      _rawFile = await _pickedFile!.readAsBytes();
    }
    image=pickedFile;
    update();
  }
  void pickImageUpdateProfile(ImageSource?imageSource) async {
    _pickedFile = await ImagePicker().pickImage(source:imageSource??ImageSource.gallery);
    if (_pickedFile != null) {
      Get.back();
      updateUserInfo(UpdateProfileModel(),isBack: false);
      _pickedFile = await NetworkInfo.compressImage(_pickedFile!);
      _rawFile = await _pickedFile!.readAsBytes();
    }
    image=pickedFile;
    update();
  }

  void initData({bool isUpdate = false}) {
    _pickedFile = null;
    _rawFile = null;
    if (isUpdate) {
      update();
    }
  }

  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteUser();
    _isLoading = false;
    if (response.statusCode == 200) {
      showCustomSnackBar('your_account_remove_successfully'.tr);
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
  }



  void clearUserInfo() {
    _userInfoModel = null;
    userModel = null;
    update();
  }
}
