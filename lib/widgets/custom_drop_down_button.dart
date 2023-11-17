import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    Key? key,
    required this.menuItems,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> menuItems;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String selectedValue = 'Item 1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: const SizedBox(),
      value: selectedValue,
      items: widget.menuItems,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
    );
  }
}
