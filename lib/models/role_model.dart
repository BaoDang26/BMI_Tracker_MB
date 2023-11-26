// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

Role ROleFromJson(String str) => Role.fromJson(json.decode(str));

class Role extends Equatable {
  final String roleId;
  final String roleName;
  final String status;
  const Role({
    required this.roleId,
    required this.roleName,
    required this.status,
  });

  @override
  List<Object> get props => [roleId, roleName, status];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roleId': roleId,
      'roleName': roleName,
      'status': status,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      roleId: map['roleId'] as String,
      roleName: map['roleName'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);
}
