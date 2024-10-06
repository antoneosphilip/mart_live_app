import 'package:live_app/data/model/response/user_model.dart';

import 'conversation_model.dart';
import 'country_model.dart';
import 'family_model.dart';

class RoomModel {
  int? id;
  String? name;
  String? intro;
  String? note;
  int? totalIncome;
  String? cover;
  String? background;
  String? frame;
  String? password;
  String? type_name;
  String? type_image;
  bool? hasPassword;
  bool? IsUserRoomBlocked;
  bool? IsUserRoomChatBlocked;
  bool? IsUserRoomMicBlocked;
  bool? isOwner;
  int? adminsCount;
  int? visitorsCount;
  Owner? owner;
  List<Chairs>? chairs;

  RoomModel({
    this.id,
    this.name,
    this.intro,
    this.note,
    this.totalIncome,
    this.cover,
    this.background,
    this.frame,
    this.password,
    this.type_name,
    this.type_image,
    this.hasPassword,
    this.IsUserRoomBlocked,
    this.IsUserRoomChatBlocked,
    this.IsUserRoomMicBlocked,
    this.isOwner,
    this.adminsCount,
    this.visitorsCount,
    this.owner,
    this.chairs,
  });

  RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    intro = json['intro'];
    note = json['note'];
    totalIncome = json['total_income'];
    cover = json['cover'];
    background = json['background'];
    frame = json['frame'];
    password = json['password'];
    type_name = json['type_name'];
    type_image = json['type_image'];
    hasPassword = json['has_password'];
    IsUserRoomBlocked = json['is_user_room_blocked'];
    IsUserRoomChatBlocked = json['is_user_room_chat_blocked'];
    IsUserRoomMicBlocked = json['is_user_room_mic_blocked'];
    isOwner = json['is_owner'];
    adminsCount = json['admins_count'];
    visitorsCount = json['visitors_count'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['chairs'] != null) {
      chairs = <Chairs>[];
      json['chairs'].forEach((v) {
        chairs!.add(new Chairs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['intro'] = this.intro;
    data['note'] = this.note;
    data['total_income'] = this.totalIncome;
    data['cover'] = this.cover;
    data['background'] = this.background;
    data['frame'] = this.frame;
    data['password'] = this.password;
    data['type_name'] = this.type_name;
    data['type_image'] = this.type_image;
    data['has_password'] = this.hasPassword;
    data['is_user_room_blocked'] = this.IsUserRoomBlocked;
    data['is_user_room_chat_blocked'] = this.IsUserRoomChatBlocked;
    data['is_user_room_mic_blocked'] = this.IsUserRoomMicBlocked;
    data['is_owner'] = this.isOwner;
    data['admins_count'] = this.adminsCount;
    data['visitors_count'] = this.visitorsCount;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.chairs != null) {
      data['chairs'] = this.chairs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  int? uuid;
  String? name;
  String? image;
  CountryModel? country;

  Owner({this.id, this.uuid, this.name, this.image, this.country});

  Owner.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    uuid = json?['uuid'];
    name = json?['name'];
    image = json?['image'];
    country = CountryModel.fromJson(json?['country']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['country'] = this.country?.toJson();
    return data;
  }
}

class Chairs {
  int? id;
  int? chairNo;
  String? icon;
  int? isLocked;
  int? isMuted;
  int? isFeatured;
  int? isForAdmin;
  int? teamNumber;
  User? user;

  Chairs(
      {this.id,
      this.chairNo,
      this.icon,
      this.isLocked,
      this.isMuted,
      this.isFeatured,
      this.isForAdmin,
      this.teamNumber,this.user});

  Chairs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chairNo = json['chair_no'];
    icon = json['icon'];
    isLocked = json['is_locked'];
    isMuted = json['is_muted'];
    isFeatured = json['is_featured'];
    isForAdmin = json['is_for_admin'];
    teamNumber = json['team_number'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chair_no'] = this.chairNo;
    data['icon'] = this.icon;
    data['is_locked'] = this.isLocked;
    data['is_muted'] = this.isMuted;
    data['is_featured'] = this.isFeatured;
    data['is_for_admin'] = this.isForAdmin;
    data['team_number'] = this.teamNumber;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    return data;
  }


}


class User {
  int? id;
  int? uuid;
  String? name;
  String? gender;
  String? pio;
  String ?image;
  CountryModel? country;
  double ?balance;
  int? friendsCount;
  int? friendRequestsCount;
  dynamic followersCount;
  dynamic followingsCount;
  dynamic visitorsCount;
  int? newVisitsCount;
  bool? isFollowed;
  bool? isFriend;
  bool? amISentFriendRequest;
  bool? isHeSentFriendRequest;
  RoomModel? ownRoom;
  RoomModel? inRoom;
  Wallet ?wallet;
  SenderLevel? senderLevel;
  SenderLevel? consigneeLevel;
  String? time;

  User(
      {this.id,
        this.uuid,
        this.name,
        this.gender,
        this.pio,
        this.image,
        this.country,
        this.balance,
        this.friendsCount,
        this.friendRequestsCount,
        this.followersCount,
        this.followingsCount,
        this.visitorsCount,
        this.newVisitsCount,
        this.isFollowed,
        this.isFriend,
        this.amISentFriendRequest,
        this.isHeSentFriendRequest,
        this.ownRoom,
        this.inRoom,
        this.wallet,
        this.senderLevel,
        this.consigneeLevel,
        this.time});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    gender = json['gender'];
    pio = json['pio'];
    image = json['image'];
    country =
    json['country'] != null ? new CountryModel.fromJson(json['country']) : null;
    balance = json['balance'];
    friendsCount = json['friends_count'];
    friendRequestsCount = json['friend_requests_count'];
    followersCount = json['followers_count'];
    followingsCount = json['followings_count'];
    visitorsCount = json['visitors_count'];
    newVisitsCount = json['new_visits_count'];
    isFollowed = json['is_followed'];
    isFriend = json['is_friend'];
    amISentFriendRequest = json['am_i_sent_friend_request'];
    isHeSentFriendRequest = json['is_he_sent_friend_request'];
    ownRoom = json['own_room'];
    inRoom =
    json['in_room'] != null ? new RoomModel.fromJson(json['in_room']) : null;
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    senderLevel = json['sender_level'] != null
        ? new SenderLevel.fromJson(json['sender_level'])
        : null;
    consigneeLevel = json['consignee_level'] != null
        ? new SenderLevel.fromJson(json['consignee_level'])
        : null;
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['pio'] = this.pio;
    data['image'] = this.image;
    if (this.country != null) {
      data['country'] = this.country?.toJson();
    }
    data['balance'] = this.balance;
    data['friends_count'] = this.friendsCount;
    data['friend_requests_count'] = this.friendRequestsCount;
    data['followers_count'] = this.followersCount;
    data['followings_count'] = this.followingsCount;
    data['visitors_count'] = this.visitorsCount;
    data['new_visits_count'] = this.newVisitsCount;
    data['is_followed'] = this.isFollowed;
    data['is_friend'] = this.isFriend;
    data['am_i_sent_friend_request'] = this.amISentFriendRequest;
    data['is_he_sent_friend_request'] = this.isHeSentFriendRequest;
    data['own_room'] = this.ownRoom;
    if (this.inRoom != null) {
      data['in_room'] = this.inRoom?.toJson();
    }
    if (this.wallet != null) {
      data['wallet'] = this.wallet?.toJson();
    }
    if (this.senderLevel != null) {
      data['sender_level'] = this.senderLevel?.toJson();
    }
    if (this.consigneeLevel != null) {
      data['consignee_level'] = this.consigneeLevel?.toJson();
    }
    data['time'] = this.time;
    return data;
  }
}

