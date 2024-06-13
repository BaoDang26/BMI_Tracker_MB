import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String name;
  final String duration;
  final String kcal;

  const ActivityItem({
    Key? key,
    this.icon,
    this.emoji,
    required this.name,
    required this.duration,
    required this.kcal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, size: 30)
          : Text(
              emoji ?? '',
              style: const TextStyle(fontSize: 30),
            ),
      title: Text(name),
      subtitle: Text(duration),
      trailing: Text(kcal),
      onTap: () {
        // Add tile tap functionality here
      },
    );
  }
}
