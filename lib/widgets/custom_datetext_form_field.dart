// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/register_controller.dart';

// ignore: must_be_immutable
class CustomDateTextFormField extends StatelessWidget {
  String? hintTxt;
  TextInputType? keyboardType;
  // List<TextInputFormatter> inputFormatters;  
  DateTime? dateTime;
  String? labelText;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  TextEditingController? controller;
  Widget? suffixIcon;
  Widget? prefixicon;
  bool? enable;
  double? borderRadius;

  Color fillColor;

  bool isObscure;

  CustomDateTextFormField({
    Key? key,
    this.hintTxt,
    this.dateTime,
    // this.keyboardType,
    // this.inputFormatters,
    this.labelText,
    this.onSaved,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.prefixicon,
    this.isObscure = false,
    this.enable = true,
    this.borderRadius = 15,
    this.fillColor = const Color(0xfff5f5f5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    return TextFormField(
      enableInteractiveSelection: enable,
      obscureText: isObscure,
      // keyboardType: TextInputType.number,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      onSaved: onSaved,
      validator: validator,
      controller: controller,
      onTap: () async {
          DateTime? pickeddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), 
            firstDate: DateTime(2000), 
            lastDate: DateTime(2101));

            if (pickeddate != null) {
             registerController.birthdayController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
            }
      },
      decoration: InputDecoration(
          prefixIcon: prefixicon,
          filled: true,
          fillColor: fillColor,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 221, 24, 17),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 221, 24, 17),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          prefixIconColor: Theme.of(context).primaryColor,
          focusColor: Theme.of(context).primaryColor,
          suffixIcon: suffixIcon,
          hintText: hintTxt,
          labelText: labelText,
          suffixIconColor: Theme.of(context).primaryColor),

          
    );
  }
}
