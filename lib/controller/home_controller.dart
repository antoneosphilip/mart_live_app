import 'package:get/get.dart';
import 'package:live_app/data/repository/home_repo.dart';

import '../data/api/api_checker.dart';
import '../data/model/response/banner_model.dart';
import '../data/model/response/country_model.dart';
import '../data/model/response/room_model.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo repo = HomeRepo();
  bool isLoading = false;
  int page = 1;
  List<Banner>? mainBanners = [];
  List<Banner>? liftBanners = [];
  List<Banner>? rightBanners = [];
  List<RoomModel>? topRooms = [];
  List<RoomModel>? homeRooms = [];
  List<CountryModel> countries = [];
  bool dataFetched = false;
  bool hasMoreData=true;

  Future<void> getData() async {
    if (dataFetched == true) {
      hasMoreData=true;
      return;
    }
    isLoading = true;
    update();
    Response response = await repo.getData(page);
    if (response.statusCode == 200) {
      Map<String, dynamic> dataResponse = response.body['data'];
      // Parse main banners
      mainBanners = List<Banner>.from(
        dataResponse['main_banners'].map(
          (banner) => Banner.fromJson(banner),
        ),
      );
      // Parse lift banners
      liftBanners = List<Banner>.from(
        dataResponse['lift_banners'].map(
          (banner) => Banner.fromJson(banner),
        ),
      );
      // Parse right banners
      rightBanners = List<Banner>.from(
        dataResponse['right_banners'].map(
          (banner) => Banner.fromJson(banner),
        ),
      );
      // Parse top rooms
      topRooms = List<RoomModel>.from(
        dataResponse['top_rooms'].map(
          (room) => RoomModel.fromJson(room),
        ),
      );
      // Parse home rooms
      homeRooms = List<RoomModel>.from(
        dataResponse['home_rooms'].map(
          (room) => RoomModel.fromJson(room),
        ),
      );
      // Parse countries
      countries = List<CountryModel>.from(
        dataResponse['countries'].map(
          (country) => CountryModel.fromJson(country),
        ),
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    dataFetched = true;
    update();
  }
///////////////////////////////
  Future<void> paginate(int pagenom) async {
    Response response = await repo.getData(pagenom);
    if (response.statusCode == 200) {

      Map<String, dynamic> dataResponse = response.body['data'];

      // Parse home rooms
      List<RoomModel> rooms = List<RoomModel>.from(
        dataResponse['home_rooms'].map(
          (room) => RoomModel.fromJson(room),
        ),
      );
      homeRooms?.addAll(rooms);
      // print("rooms${rooms[0].name}");

      if (rooms.isNotEmpty) {
        page = pagenom;
      }
      else
      {
        hasMoreData=false;
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
