// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// import 'user_model.dart';

// List<Feedback> feedbackFromJson(String str) =>
//     List<Feedback>.from(json.decode(str).map((x) => Feedback.fromJson(x)));

// String feedbackToJson(List<Feedback> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Feedback extends Equatable {
//   Feedback({
//     this.id,
//     this.sentBy,
//     this.type,
//     this.description,
//     this.status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     this.v,
//   })  : this.createdAt = createdAt ?? DateTime.now(),
//         this.updatedAt = updatedAt ?? DateTime.now();

//   final String? id;
//   final UserModel? sentBy;
//   final String? type;
//   final String? description;
//   final bool? status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int? v;

//   factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
//         id: json["_id"] == null ? null : json["_id"],
//         sentBy: json["sent_by"] == null
//             ? null
//             : UserModel.fromJson(json["sent_by"]),
//         type: json["type"] == null ? null : json["type"],
//         description: json["description"] == null ? null : json["description"],
//         status: json["status"] == null ? null : json["status"],
//         v: json["__v"] == null ? null : json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "sent_by": sentBy == null ? null : sentBy!.toJson(),
//         "type": type == null ? null : type,
//       };

//   @override
//   List<Object?> get props {
//     return [
//       id,
//       sentBy,
//       type,
//       description,
//       status,
//       v,
//     ];
//   }

//   @override
//   bool get stringify => true;
// }
