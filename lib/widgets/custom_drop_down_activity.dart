// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDropDownActivity extends StatefulWidget {
  const CustomDropDownActivity({
    Key? key,
    this.onChange,
    required this.textValue,
  }) : super(key: key);

  final void Function(dynamic)? onChange;
  final String textValue;

  @override
  State<CustomDropDownActivity> createState() => _CustomDropDownActivityState();
}

class _CustomDropDownActivityState extends State<CustomDropDownActivity> {
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
          child: Text('Little to no exercise'),
          value: '1',
        ),
        DropdownMenuItem(
          child: Text('Light exercise 1-3 days per week'),
          value: '2',
        ),
        DropdownMenuItem(
          child: Text('Moderate exercise 3-5 days per week'),
          value: '3',
        ),
        DropdownMenuItem(
          child: Text('Hard exercise 6-7 days per week'),
          value: '4',
        ),
        DropdownMenuItem(
          child: Text('Very hard exercise'),
          value: '5',
        )
      ],
      onChanged: widget.onChange,
    );
  }
}
