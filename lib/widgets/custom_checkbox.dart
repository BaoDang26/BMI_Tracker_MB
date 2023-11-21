import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    Key? key,
    required this.mealName,
    required this.calories,
    this.isChecked = false,
  }) : super(key: key);
  bool isChecked;
  final String mealName;
  final String calories;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
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
      value: widget.isChecked,
      onChanged: (value) {
        setState(() {
          widget.isChecked = value!;
        });
      },
      fillColor: MaterialStateProperty.resolveWith(getColor),
      subtitle: Text(
        'Calories: ${widget.calories}',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
