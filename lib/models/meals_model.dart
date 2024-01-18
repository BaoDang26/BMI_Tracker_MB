// // To parse this JSON data, do
// //
// //     final meals = mealsFromJson(jsonString);

// import 'package:flutter_health_menu/models/models.dart';
// import 'package:meta/meta.dart';
// import 'dart:convert';

// Meals mealsFromJson(String str) => Meals.fromJson(json.decode(str));

// String mealsToJson(Meals data) => json.encode(data.toJson());

// class Meals {
//   final String? menuId;
//   final String? menuName;
//   final String? menuDescription;
//   final String? menuType;
//   final String? menuPhoto;
//   final String? categoryId;
//   final Categorys? categorys;
//   final String? status;
//   final String? userId;
//   final Users? users;
//   final List<Schedule>? schedules;
//   final List<Meal>? meals;

//   Meals({
//     this.menuId,
//     this.menuName,
//     this.menuDescription,
//     this.menuType,
//     this.menuPhoto,
//     this.categoryId,
//     this.categorys,
//     this.status,
//     this.userId,
//     this.users,
//     this.schedules,
//     this.meals,
//   });

//   factory Meals.fromJson(Map<String, dynamic> json) => Meals(
//         menuId: json["menuId"],
//         menuName: json["menuName"],
//         menuDescription: json["menuDescription"],
//         menuType: json["menuType"],
//         menuPhoto: json["menuPhoto"],
//         categoryId: json["categoryId"],
//         categorys: Categorys.fromJson(json["categorys"]),
//         status: json["status"],
//         userId: json["userId"],
//         users: Users.fromJson(json["users"]),
//         schedules: List<Schedule>.from(
//             json["schedules"].map((x) => Schedule.fromJson(x))),
//         meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "menuId": menuId,
//         "menuName": menuName,
//         "menuDescription": menuDescription,
//         "menuType": menuType,
//         "menuPhoto": menuPhoto,
//         "categoryId": categoryId,
//         "categorys": categorys?.toJson(),
//         "status": status,
//         "userId": userId,
//         "users": users?.toJson(),
//         "schedules": List<dynamic>.from(schedules!.map((x) => x.toJson())),
//         "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
//       };
// }

// class Categorys {
//   final String categoryId;
//   final String categoryName;
//   final String status;

//   Categorys({
//     required this.categoryId,
//     required this.categoryName,
//     required this.status,
//   });

//   factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
//         categoryId: json["categoryId"],
//         categoryName: json["categoryName"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "categoryId": categoryId,
//         "categoryName": categoryName,
//         "status": status,
//       };
// }

// class Meal {
//   final String menuId;
//   final String foodId;
//   final List<FoodModel> foods;
//   final String menus;

//   Meal({
//     required this.menuId,
//     required this.foodId,
//     required this.foods,
//     required this.menus,
//   });

//   factory Meal.fromJson(Map<String, dynamic> json) => Meal(
//         menuId: json["menuId"],
//         foodId: json["foodId"],
//         foods: List<FoodModel>.from(
//             json["schedules"].map((x) => Schedule.fromJson(x))),
//         menus: json["menus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "menuId": menuId,
//         "foodId": foodId,
//         "foods": foods.toJson(),
//         "menus": menus,
//       };
// }

// class Foods {
//   final String foodId;
//   final String foodName;
//   final String foodTag;
//   final String foodNutrition;
//   final String foodNotes;
//   final String foodDesciption;
//   final String foodPhoto;
//   final int foodtimeProcess;
//   final int foodCalorios;
//   final String foodProcessingVideo;
//   final String status;
//   final String categoryId;
//   final Categorys categorys;
//   final List<Recipe> recipes;
//   final List<String> meals;

//   Foods({
//     required this.foodId,
//     required this.foodName,
//     required this.foodTag,
//     required this.foodNutrition,
//     required this.foodNotes,
//     required this.foodDesciption,
//     required this.foodPhoto,
//     required this.foodtimeProcess,
//     required this.foodCalorios,
//     required this.foodProcessingVideo,
//     required this.status,
//     required this.categoryId,
//     required this.categorys,
//     required this.recipes,
//     required this.meals,
//   });

//   factory Foods.fromJson(Map<String, dynamic> json) => Foods(
//         foodId: json["foodId"],
//         foodName: json["foodName"],
//         foodTag: json["foodTag"],
//         foodNutrition: json["foodNutrition"],
//         foodNotes: json["foodNotes"],
//         foodDesciption: json["foodDesciption"],
//         foodPhoto: json["foodPhoto"],
//         foodtimeProcess: json["foodtimeProcess"],
//         foodCalorios: json["foodCalorios"],
//         foodProcessingVideo: json["foodProcessingVideo"],
//         status: json["status"],
//         categoryId: json["categoryId"],
//         categorys: Categorys.fromJson(json["categorys"]),
//         recipes:
//             List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
//         meals: List<String>.from(json["meals"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "foodId": foodId,
//         "foodName": foodName,
//         "foodTag": foodTag,
//         "foodNutrition": foodNutrition,
//         "foodNotes": foodNotes,
//         "foodDesciption": foodDesciption,
//         "foodPhoto": foodPhoto,
//         "foodtimeProcess": foodtimeProcess,
//         "foodCalorios": foodCalorios,
//         "foodProcessingVideo": foodProcessingVideo,
//         "status": status,
//         "categoryId": categoryId,
//         "categorys": categorys.toJson(),
//         "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
//         "meals": List<dynamic>.from(meals.map((x) => x)),
//       };
// }

// class Recipe {
//   final String ingredientId;
//   final String foodId;
//   final String foods;
//   final Ingredients ingredients;

//   Recipe({
//     required this.ingredientId,
//     required this.foodId,
//     required this.foods,
//     required this.ingredients,
//   });

//   factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
//         ingredientId: json["ingredientId"],
//         foodId: json["foodId"],
//         foods: json["foods"],
//         ingredients: Ingredients.fromJson(json["ingredients"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "ingredientId": ingredientId,
//         "foodId": foodId,
//         "foods": foods,
//         "ingredients": ingredients.toJson(),
//       };
// }

// class Ingredients {
//   final String ingredientId;
//   final String ingredientName;
//   final String ingredientPhoto;
//   final String status;
//   final List<String> recipes;
//   final String categoryId;
//   final Categorys categorys;

//   Ingredients({
//     required this.ingredientId,
//     required this.ingredientName,
//     required this.ingredientPhoto,
//     required this.status,
//     required this.recipes,
//     required this.categoryId,
//     required this.categorys,
//   });

//   factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
//         ingredientId: json["ingredientId"],
//         ingredientName: json["ingredientName"],
//         ingredientPhoto: json["ingredientPhoto"],
//         status: json["status"],
//         recipes: List<String>.from(json["recipes"].map((x) => x)),
//         categoryId: json["categoryId"],
//         categorys: Categorys.fromJson(json["categorys"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "ingredientId": ingredientId,
//         "ingredientName": ingredientName,
//         "ingredientPhoto": ingredientPhoto,
//         "status": status,
//         "recipes": List<dynamic>.from(recipes.map((x) => x)),
//         "categoryId": categoryId,
//         "categorys": categorys.toJson(),
//       };
// }

// class Schedule {
//   final String menuId;
//   final String userInfoId;

//   Schedule({
//     required this.menuId,
//     required this.userInfoId,
//   });

//   factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
//         menuId: json["menuId"],
//         userInfoId: json["userInfoId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "menuId": menuId,
//         "userInfoId": userInfoId,
//       };
// }

// class Users {
//   final String userId;
//   final String email;
//   final String fullName;
//   final String password;
//   final String phoneNumber;
//   final String certificateId;
//   final String certificateName;
//   final String status;
//   final String roleId;
//   final Roles roles;
//   final UserBodyMaxs userBodyMaxs;

//   Users({
//     required this.userId,
//     required this.email,
//     required this.fullName,
//     required this.password,
//     required this.phoneNumber,
//     required this.certificateId,
//     required this.certificateName,
//     required this.status,
//     required this.roleId,
//     required this.roles,
//     required this.userBodyMaxs,
//   });

//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//         userId: json["userId"],
//         email: json["email"],
//         fullName: json["fullName"],
//         password: json["password"],
//         phoneNumber: json["phoneNumber"],
//         certificateId: json["certificateId"],
//         certificateName: json["certificateName"],
//         status: json["status"],
//         roleId: json["roleId"],
//         roles: Roles.fromJson(json["roles"]),
//         userBodyMaxs: UserBodyMaxs.fromJson(json["userBodyMaxs"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "email": email,
//         "fullName": fullName,
//         "password": password,
//         "phoneNumber": phoneNumber,
//         "certificateId": certificateId,
//         "certificateName": certificateName,
//         "status": status,
//         "roleId": roleId,
//         "roles": roles.toJson(),
//         "userBodyMaxs": userBodyMaxs.toJson(),
//       };
// }

// class Roles {
//   final String roleId;
//   final String roleName;
//   final String status;

//   Roles({
//     required this.roleId,
//     required this.roleName,
//     required this.status,
//   });

//   factory Roles.fromJson(Map<String, dynamic> json) => Roles(
//         roleId: json["roleId"],
//         roleName: json["roleName"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "roleName": roleName,
//         "status": status,
//       };
// }

// class UserBodyMaxs {
//   final String userInfoId;
//   final int heght;
//   final int weight;
//   final int age;
//   final int bmiPerson;
//   final int bmr;
//   final int tdee;
//   final int sex;
//   final String status;
//   final DateTime dateInput;
//   final String userId;
//   final String users;
//   final List<Schedule> schedules;
//   final List<Order> orders;

//   UserBodyMaxs({
//     required this.userInfoId,
//     required this.heght,
//     required this.weight,
//     required this.age,
//     required this.bmiPerson,
//     required this.bmr,
//     required this.tdee,
//     required this.sex,
//     required this.status,
//     required this.dateInput,
//     required this.userId,
//     required this.users,
//     required this.schedules,
//     required this.orders,
//   });

//   factory UserBodyMaxs.fromJson(Map<String, dynamic> json) => UserBodyMaxs(
//         userInfoId: json["userInfoId"],
//         heght: json["heght"],
//         weight: json["weight"],
//         age: json["age"],
//         bmiPerson: json["bmiPerson"],
//         bmr: json["bmr"],
//         tdee: json["tdee"],
//         sex: json["sex"],
//         status: json["status"],
//         dateInput: DateTime.parse(json["dateInput"]),
//         userId: json["userId"],
//         users: json["users"],
//         schedules: List<Schedule>.from(
//             json["schedules"].map((x) => Schedule.fromJson(x))),
//         orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "userInfoId": userInfoId,
//         "heght": heght,
//         "weight": weight,
//         "age": age,
//         "bmiPerson": bmiPerson,
//         "bmr": bmr,
//         "tdee": tdee,
//         "sex": sex,
//         "status": status,
//         "dateInput": dateInput.toIso8601String(),
//         "userId": userId,
//         "users": users,
//         "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
//         "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
//       };
// }

// class Order {
//   final String orderId;
//   final String orderName;
//   final String orderDescription;
//   final String orderStatus;
//   final int orderPrice;
//   final DateTime orderDate;
//   final String userInfoId;
//   final String userBodyMaxs;
//   final String serviceId;
//   final Services services;

//   Order({
//     required this.orderId,
//     required this.orderName,
//     required this.orderDescription,
//     required this.orderStatus,
//     required this.orderPrice,
//     required this.orderDate,
//     required this.userInfoId,
//     required this.userBodyMaxs,
//     required this.serviceId,
//     required this.services,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         orderId: json["orderId"],
//         orderName: json["orderName"],
//         orderDescription: json["orderDescription"],
//         orderStatus: json["orderStatus"],
//         orderPrice: json["orderPrice"],
//         orderDate: DateTime.parse(json["orderDate"]),
//         userInfoId: json["userInfoId"],
//         userBodyMaxs: json["userBodyMaxs"],
//         serviceId: json["serviceId"],
//         services: Services.fromJson(json["services"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "orderId": orderId,
//         "orderName": orderName,
//         "orderDescription": orderDescription,
//         "orderStatus": orderStatus,
//         "orderPrice": orderPrice,
//         "orderDate": orderDate.toIso8601String(),
//         "userInfoId": userInfoId,
//         "userBodyMaxs": userBodyMaxs,
//         "serviceId": serviceId,
//         "services": services.toJson(),
//       };
// }

// class Services {
//   final String serviceId;
//   final String nameService;
//   final String descriptionService;
//   final String status;
//   final String userId;
//   final String users;

//   Services({
//     required this.serviceId,
//     required this.nameService,
//     required this.descriptionService,
//     required this.status,
//     required this.userId,
//     required this.users,
//   });

//   factory Services.fromJson(Map<String, dynamic> json) => Services(
//         serviceId: json["serviceId"],
//         nameService: json["nameService"],
//         descriptionService: json["descriptionService"],
//         status: json["status"],
//         userId: json["userId"],
//         users: json["users"],
//       );

//   Map<String, dynamic> toJson() => {
//         "serviceId": serviceId,
//         "nameService": nameService,
//         "descriptionService": descriptionService,
//         "status": status,
//         "userId": userId,
//         "users": users,
//       };
// }
