import 'dart:convert';

List<PlanModel> planModelsFromJson(String str) =>
    List<PlanModel>.from(json.decode(str).map((x) => PlanModel.fromJson(x)));

String planModelToJson(List<PlanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanModel {
  int? planID;
  String? planName;
  double? price;
  String? description;
  int? planDuration;
  int? advisorID;
  bool? popular = false;
  int? numberOfUses;

  PlanModel({
    this.planID,
    this.planName,
    this.price,
    this.description,
    this.planDuration,
    this.advisorID,
    this.numberOfUses,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
        planID: json['planID'],
        planName: json['planName'],
        price: json['price'],
        description: json['description'],
        planDuration: json['planDuration'],
        advisorID: json['advisorID'],
        numberOfUses: json['numberOfUses']);
  }

  Map<String, dynamic> toJson() {
    return {
      'planID': planID,
      'planName': planName,
      'price': price,
      'description': description,
      'planDuration': planDuration,
      'advisorID': advisorID,
      'numberOfUses': numberOfUses,
    };
  }
}
