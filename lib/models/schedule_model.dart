// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_health_menu/models/menu_model.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';

ScheduleModel scheduleModelFromMap(String str) =>
    ScheduleModel.fromMap(json.decode(str));

String scheduleModelToMap(ScheduleModel data) => json.encode(data.toMap());

class ScheduleModel {
  String? menuId;
  String? userInfoId;
  MenuModel? menus;
  UserBodyMaxModel? userBodyMaxs;

  ScheduleModel({
    this.menuId,
    this.userInfoId,
    this.menus,
    this.userBodyMaxs,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> json) => ScheduleModel(
        menuId: json["menuId"],
        userInfoId: json["userInfoId"],
        // menus: MenuModel.fromMap(json["users"]),
        // userBodyMaxs: UserBodyMaxModel.fromMap(json["users"]),
      );

  Map<String, dynamic> toMap() => {
        "menuId": menuId,
        "userInfoId": userInfoId,
      };
}
