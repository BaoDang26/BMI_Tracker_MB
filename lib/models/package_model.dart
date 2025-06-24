// import 'dart:convert';

// List<PlanModel> planModelsFromJson(String str) =>
//     List<PlanModel>.from(json.decode(str).map((x) => PlanModel.fromJson(x)));

// String planModelToJson(List<PlanModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PlanModel {
//   int? planID;
//   String? planName;
//   double? price;
//   String? planCode;
//   String? description;
//   int? planDuration;
//   int? advisorID;
//   bool? popular = false;
//   int? numberOfUses;

//   PlanModel({
//     this.planID,
//     this.planCode,
//     this.planName,
//     this.price,
//     this.description,
//     this.planDuration,
//     this.advisorID,
//     this.numberOfUses,
//   });

//   factory PlanModel.fromJson(Map<String, dynamic> json) {
//     return PlanModel(
//         planID: json['planID'],
//         planName: json['planName'],
//         planCode: json['planCode'],
//         price: json['price'],
//         description: json['description'],
//         planDuration: json['planDuration'],
//         advisorID: json['advisorID'],
//         numberOfUses: json['numberOfUses']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'planID': planID,
//       'planName': planName,
//       'planCode': planCode,
//       'price': price,
//       'description': description,
//       'planDuration': planDuration,
//       'advisorID': advisorID,
//       'numberOfUses': numberOfUses,
//     };
//   }
// }

// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'dart:convert';

List<PackageModel> packageModelFromJson(String str) => List<PackageModel>.from(
    json.decode(str).map((x) => PackageModel.fromJson(x)));

String packageModelToJson(List<PackageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageModel {
  int? packageId;
  String? packageCode;
  String? packageName;
  double? price;
  String? description;
  int? packageDuration;
  int? advisorId;
  String? fullName;
  int? numberOfUses;
  bool? popular = false;
  String? packageStatus;
  bool? isActive;

  PackageModel({
    this.packageId,
    this.packageCode,
    this.packageName,
    this.price,
    this.description,
    this.packageDuration,
    this.advisorId,
    this.fullName,
    this.numberOfUses,
    this.packageStatus,
    this.isActive,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        packageId: json["packageID"],
        packageCode: json["packageCode"],
        packageName: json["packageName"],
        price: json["price"],
        description: json["description"],
        packageDuration: json["packageDuration"],
        advisorId: json["advisorID"],
        fullName: json["fullName"],
        numberOfUses: json["numberOfUses"],
        packageStatus: json["packageStatus"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "packageID": packageId,
        "packageCode": packageCode,
        "packageName": packageName,
        "price": price,
        "description": description,
        "packageDuration": packageDuration,
        "advisorID": advisorId,
        "fullName": fullName,
        "numberOfUses": numberOfUses,
        "packageStatus": packageStatus,
        "isActive": isActive,
      };
}
