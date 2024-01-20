// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

List<RoleModel> roleModelFromJson(String str) =>
    List<RoleModel>.from(json.decode(str).map((x) => RoleModel.fromJson(x)));

String roleModelToJson(List<RoleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoleModel {
  String? roleId;
  String? roleName;
  String? status;

  RoleModel({
    this.roleId,
    this.roleName,
    this.status,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        roleId: json["roleId"],
        roleName: json["roleName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
        "status": status,
      };
}
