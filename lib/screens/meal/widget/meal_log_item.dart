import 'package:flutter/material.dart';

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
      title: Text(name),
      // subtitle: Text(description),
      trailing: Text(kcal),
      onTap: () {
        
       },
    );
  }
}
