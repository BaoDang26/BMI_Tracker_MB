import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/size_utils.dart';

class EntryField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextInputType textInputType;
  final TextEditingController controller;

  const EntryField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.fSize, color: Colors.black),
        ),
        TextField(
          controller: controller,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: placeholder,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 20.v),
      ],
    );
  }
}
