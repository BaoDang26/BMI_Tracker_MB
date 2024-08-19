import 'package:flutter/material.dart';

import 'theme_helper.dart';

class CustomTextFormFieldStyles {
  // Filled button style
  static InputDecoration get weightTextFieldStyle => InputDecoration(
        filled: true,
        fillColor: appTheme.grey100,
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 221, 24, 17),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 221, 24, 17),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        hintText: 'Enter your weight',
      );
  static InputDecoration get heightTextFieldStyle => InputDecoration(
    filled: true,
    fillColor: appTheme.grey100,
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 221, 24, 17),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 221, 24, 17),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    hintText: 'Enter your height',
  );

}
