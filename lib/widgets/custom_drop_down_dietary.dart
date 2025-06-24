// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDropDownDietary extends StatefulWidget {
  const CustomDropDownDietary({
    Key? key,
    this.onChange,
    required this.textValue,
  }) : super(key: key);

  final void Function(dynamic)? onChange;
  final String textValue;

  @override
  State<CustomDropDownDietary> createState() => _CustomDropDownDietaryState();
}

class _CustomDropDownDietaryState extends State<CustomDropDownDietary> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      underline: const SizedBox(),
      value: widget.textValue,
      // items: menuItems.map<DropdownMenuItem<String>>(
      //   (e) {
      //     return DropdownMenuItem(
      //       child: Text(e),
      //       value: e,
      //     );
      //   },
      // ).toList(),
      items: const <DropdownMenuItem>[
        DropdownMenuItem(
          child: Text('Standard (with meat)'),
          value: 'Standard',
        ),
        DropdownMenuItem(
          child: Text('Pescatarian'),
          value: 'Pescatarian',
        ),
        DropdownMenuItem(
          child: Text('Vegetarian'),
          value: 'Vegetarian',
        ),
        DropdownMenuItem(
          child: Text('Vegan'),
          value: 'Vegan',
        )
      ],
      onChanged: widget.onChange,
    );
  }
}
