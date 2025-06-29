// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    Key? key,
    this.onChange,
    required this.textValue,
  }) : super(key: key);

  final void Function(dynamic)? onChange;
  final String textValue;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  final List<String> menuItems = [
    "Item 1",
    "2",
    "3",
  ];
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
          child: Text('Subscription history'),
          value: 'Subscription history',
        ),
        DropdownMenuItem(
          child: Text('Advisor'),
          value: 'Advisor',
        ),
        DropdownMenuItem(
          child: Text('Other'),
          value: 'Other',
        )
      ],
      onChanged: widget.onChange,
    );
  }
}
