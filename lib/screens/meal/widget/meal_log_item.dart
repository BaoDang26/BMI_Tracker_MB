import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class MealLogItem extends StatelessWidget {
  final String name;

  // final String description;
  final String kcal;

  const MealLogItem(
      {super.key,
      required this.name,
      // required this.description,
      required this.kcal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name, style: TextStyle(fontSize: 15.fSize)),
      // subtitle: Text(description),
      trailing: Text('$kcal kcal', style: TextStyle(fontSize: 15.fSize)),
      onTap: () {},
    );
  }
}
