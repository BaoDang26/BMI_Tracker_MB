import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;

  const EntryField(
      {super.key,
      required this.label,
      required this.placeholder,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
