import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/feedback_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    Key? key,
    required this.mealName,
    // required this.calories,
    this.isChecked = false,
  }) : super(key: key);
  bool isChecked;
  final String mealName;
  // final String calories;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  final fController = Get.put(FeedbackController());
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Theme.of(context).primaryColor;
    }

    return CheckboxListTile(
      title: Text(
        widget.mealName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          _isChecked = value!;
          log(_isChecked.toString());
        });

        if (_isChecked) {
          fController.meals.add(widget.mealName);
        } else {
          int index = fController.meals
              .indexWhere((element) => element == widget.mealName);
          if (index >= 0) {
            fController.meals
                .removeWhere((element) => element == widget.mealName);
          }
        }
      },
      fillColor: MaterialStateProperty.resolveWith(getColor),
      // subtitle: Text(
      //   'Calories: ${widget.calories}',
      //   style: Theme.of(context).textTheme.labelLarge,
      // ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
