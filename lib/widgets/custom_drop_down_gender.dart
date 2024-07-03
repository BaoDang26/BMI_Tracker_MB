// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDropDownGender extends StatefulWidget {
  const CustomDropDownGender({
    Key? key,
    this.onChange,
    required this.textValue,
  }) : super(key: key);

  final void Function(dynamic)? onChange;
  final String textValue;

  @override
  State<CustomDropDownGender> createState() => _CustomDropDownGenderState();
}

class _CustomDropDownGenderState extends State<CustomDropDownGender> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      underline: const SizedBox(),
      value: widget.textValue,
      items: const <DropdownMenuItem>[
        DropdownMenuItem(
          value: 'Male',
          child: Text('Male'),
        ),
        DropdownMenuItem(
          value: 'Female',
          child: Text('Female'),
        )
      ],
      onChanged: widget.onChange,
    );
  }
}
