// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

List<MenuModel> menuModelFromJson(String str) =>
    List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

String menuModelToJson(List<MenuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuModel {
  String? menuId;
  String? menuName;
  String? menuDescription;
  String? menuType;
  String? menuPhoto;
  String? categoryId;
  dynamic categorys;
  String? status;
  // List<Schedule>? schedules;
  // List<Meal>? meals;

  MenuModel({
    this.menuId,
    this.menuName,
    this.menuDescription,
    this.menuType,
    this.menuPhoto,
    this.categoryId,
    this.categorys,
    this.status,
    // this.schedules,
    // this.meals,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        menuId: json["menuId"],
        menuName: json["menuName"],
        menuDescription: json["menuDescription"],
        menuType: json["menuType"],
        menuPhoto: json["menuPhoto"],
        categoryId: json["categoryId"],
        categorys: json["categorys"],
        status: json["status"],
        // schedules: json["schedules"] == null ? [] : List<Schedule>.from(json["schedules"]!.map((x) => Schedule.fromJson(x))),
        // meals: json["meals"] == null ? [] : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuName": menuName,
        "menuDescription": menuDescription,
        "menuType": menuType,
        "menuPhoto": menuPhoto,
        "categoryId": categoryId,
        "categorys": categorys,
        "status": status,
        // "schedules": schedules == null ? [] : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        // "meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}
