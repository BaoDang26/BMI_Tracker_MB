import 'dart:convert';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter_health_menu/models/menu_model.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';

List<ScheduleModel> scheduleFromJson(String str) => List<ScheduleModel>.from(
    json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel extends Equatable {
  final String? menuId;
  final String? userInfoId;
  final List<MenuModel> menus;
  final List<UserBodyMaxRequest> userBodyMaxs;

  const ScheduleModel({
    this.menuId,
    this.userInfoId,
    required this.menus,
    required this.userBodyMaxs,
  });

  @override
  List<Object?> get props {
    return [
      menuId,
      userInfoId,
      menus,
      userBodyMaxs,
      // age,
    ];
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        menuId: json["menuId"],
        userInfoId: json["userInfoId"],
        menus: List<MenuModel>.from(
            json["menus"].map((x) => MenuModel.fromJson(x))),
        userBodyMaxs: List<UserBodyMaxRequest>.from(
            json["comments"].map((x) => UserBodyMaxRequest.fromMap(x))),
        // createdBy: UserModel.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "userInfoId": userInfoId,
      };

  @override
  bool get stringify => true;
}
