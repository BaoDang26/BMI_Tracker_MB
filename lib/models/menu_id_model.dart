// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final menuId = menuIdFromJson(jsonString);

import 'dart:convert';

List<MenuId> menuIdFromJson(String str) =>
    List<MenuId>.from(json.decode(str).map((x) => MenuId.fromJson(x)));

String menuIdToJson(List<MenuId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuId {
  final String? menuId;
  final String? menuName;
  final String? menuDescription;
  final String? menuType;
  final String? menuPhoto;
  final String? categoryId;
  final dynamic categorys;
  final String? status;
  final String? userId;

  MenuId({
    this.menuId,
    this.menuName,
    this.menuDescription,
    this.menuType,
    this.menuPhoto,
    this.categoryId,
    this.categorys,
    this.status,
    this.userId,
  });

  factory MenuId.fromJson(Map<String, dynamic> json) => MenuId(
        menuId: json["menuId"],
        menuName: json["menuName"],
        menuDescription: json["menuDescription"],
        menuType: json["menuType"],
        menuPhoto: json["menuPhoto"],
        categoryId: json["categoryId"],
        categorys: json["categorys"],
        status: json["status"],
        userId: json["userId"],
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
        "userId": userId,
      };

  @override
  String toString() {
    return 'MenuId(menuId: $menuId, menuName: $menuName, menuDescription: $menuDescription, menuType: $menuType, menuPhoto: $menuPhoto, categoryId: $categoryId, categorys: $categorys, status: $status, userId: $userId)';
  }
}
