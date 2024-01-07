// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_health_menu/models/meal_model.dart';

List<MenuModel> menuFromJson(String str) =>
    List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

class MenuModel extends Equatable {
  final String? menuId;
  final String? menuName;
  final String? menuDescription;
  final String? menuType;
  final String? menuPhoto;
  final String? categoryId;
  // final String? foodPhoto;
  // final int? foodTimeProcess;
  // final int? foodCalories;
  // final String? foodProcessingVideo;
  // final MealModel? meals;

  const MenuModel({
    this.menuId,
    this.menuName,
    this.menuDescription,
    this.menuType,
    this.menuPhoto,
    this.categoryId,
    // this.meals,
    // this.foodTimeProcess,
    // this.foodCalories,
    // this.foodProcessingVideo,
    // this.categoryId,
  });

  @override
  List<Object?> get props {
    return [
      menuId,
      menuName,
      menuDescription,
      menuType,
      menuPhoto,
      categoryId,
      // meals,
      // foodTimeProcess,
      // foodCalories,
      // foodProcessingVideo,
      // categoryId,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menuId': menuId,
      'menuName': menuName,
      'menuDescription': menuDescription,
      'menuType': menuType,
      'menuPhoto': menuPhoto,
      'categoryId': categoryId,
      // 'meals': meals!.toMap(),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      menuId: map['menuId'] != null ? map['menuId'] as String : null,
      menuName: map['menuName'] != null ? map['menuName'] as String : null,
      menuDescription: map['menuDescription'] != null
          ? map['menuDescription'] as String
          : null,
      menuType: map['menuType'] != null ? map['menuType'] as String : null,
      menuPhoto: map['menuPhoto'] != null ? map['menuPhoto'] as String : null,
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
      // meals: MealModel.fromMap(map['meals'] as Map<String, dynamic>),
    );
  }

  // String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
