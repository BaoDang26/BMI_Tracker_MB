// To parse this JSON data, do
//
//     final userBodyMaxRequest = userBodyMaxRequestFromMap(jsonString);

import 'dart:convert';

UserBodyMaxRequest userBodyMaxRequestFromMap(String str) =>
    UserBodyMaxRequest.fromMap(json.decode(str));

String userBodyMaxRequestToMap(UserBodyMaxRequest data) =>
    json.encode(data.toMap());

class UserBodyMaxRequest {
  int heght;
  int weight;
  int age;
  int sex;
  String userId;
  List<UserBodyMaxMenu> userBodyMaxMenus;

  UserBodyMaxRequest({
    required this.heght,
    required this.weight,
    required this.age,
    required this.sex,
    required this.userId,
    required this.userBodyMaxMenus,
  });

  factory UserBodyMaxRequest.fromMap(Map<String, dynamic> json) =>
      UserBodyMaxRequest(
        heght: json["heght"],
        weight: json["weight"],
        age: json["age"],
        sex: json["sex"],
        userId: json["userId"],
        userBodyMaxMenus: List<UserBodyMaxMenu>.from(
            json["userBodyMaxMenus"].map((x) => UserBodyMaxMenu.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "heght": heght,
        "weight": weight,
        "age": age,
        "sex": sex,
        "userId": userId,
        "userBodyMaxMenus":
            List<dynamic>.from(userBodyMaxMenus.map((x) => x.toMap())),
      };
}

class UserBodyMaxMenu {
  String menuId;

  UserBodyMaxMenu({
    required this.menuId,
  });

  factory UserBodyMaxMenu.fromMap(Map<String, dynamic> json) => UserBodyMaxMenu(
        menuId: json["menuId"],
      );

  Map<String, dynamic> toMap() => {
        "menuId": menuId,
      };
}
