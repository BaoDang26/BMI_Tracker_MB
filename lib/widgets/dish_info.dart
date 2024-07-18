import 'package:flutter/material.dart';

class DishInfo extends StatelessWidget {
  final String time;

  final String servings;
  final String kcal;
  final bool isAllergy;

  const DishInfo({
    Key? key,
    required this.time,
    required this.servings,
    required this.kcal,
    this.isAllergy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.timelapse),
                ),
              ),
              TextSpan(
                text: time,
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.food_bank_outlined),
                ),
              ),
              TextSpan(
                text: servings,
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.local_fire_department_rounded),
                ),
              ),
              TextSpan(
                text: '$kcal kcal',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
