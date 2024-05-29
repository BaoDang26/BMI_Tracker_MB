// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/register_controller.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/screens/register/register_complete.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:flutter_health_menu/widgets/custom_datetext_form_field.dart';
import 'package:flutter_health_menu/widgets/custom_textnumber_form_field.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class RegisterInScreen extends StatelessWidget {
  const RegisterInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());

    // final registerController = Get.put(RegisterController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Get.offAll(LoginScreen());
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register Account',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Let create your account',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: Form(
                    key: registerController.registerFormKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              'Fullname',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! password field
                            CustomTextFormField(
                              controller: registerController.fullnameController,
                              onSaved: (value) {
                                registerController.fullname = value!;
                              },
                              validator: (value) {
                                return registerController
                                    .validateFullname(value!);
                              },
                              hintTxt: 'Enter fullname',
                              // suffixIcon: const Icon(Icons.email_outlined),
                            ),
                            Text(
                              'Your email',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! email field
                            CustomTextFormField(
                              controller: registerController.emailController,
                              onSaved: (value) {
                                registerController.email = value!;
                              },
                              validator: (value) {
                                return registerController.validateEmail(value!);
                              },
                              hintTxt: 'Enter your email',
                              suffixIcon: const Icon(Icons.email_outlined),
                            ),
                            const SizedBox(height: 15),

                            Text(
                              'Phone Number',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            // ! phonenumber field
                            CustomTextNumberFormField(
                              controller: registerController.phoneNumberController,
                              onSaved: (value) {
                                registerController.phonenumber = value!;
                              },
                              validator: (value) {
                                return registerController
                                    .validatePhoneNumber(value!);
                              },
                              hintTxt: 'Enter Phone number',
                              // suffixIcon: const Icon(Icons.email_outlined),
                            ),

                            Text(
                              'Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! password field
                            CustomTextFormField(
                              controller: registerController.passwordController,
                              onSaved: (value) {
                                registerController.password = value!;
                              },
                              validator: (value) {
                                return registerController
                                    .validatePassword(value!);
                              },
                              hintTxt: 'Enter your password',
                              isObscure: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),

                            const SizedBox(height: 15),
                            Text(
                              'Confirm password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! password field
                            CustomTextFormField(
                              controller:
                                  registerController.rePasswordController,
                              onSaved: (value) {
                                registerController.rePassword = value!;
                              },
                              validator: (value) {
                                return registerController
                                    .validateRePassword(value!);
                              },
                              hintTxt: 'Enter Confirm password',
                              isObscure: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                            
                            
                        Text(
                              'Your Birthday',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! birthday field
                            CustomDateTextFormField(
                              controller: registerController.birthdayController,
                              onSaved: (value) {
                                registerController.birthday = value!;
                              },
                              validator: (value) {
                                return registerController.validateEmail(value!);
                              },
                              hintTxt: 'Enter your birthday',
                              suffixIcon: const Icon(Icons.calendar_today_rounded),
                            ),
                            const SizedBox(height: 15),
                            
                          ],
                        )
                      ],
                    ),
                  ),

                  //     ListView(
                  //   shrinkWrap: true,
                  //   children: const [
                  //     SizedBox(
                  //       height: 550,
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           TextFieldWithLabel(
                  //             labelText: 'Email',
                  //             hintText: 'Enter your email',
                  //           ),
                  //           TextFieldWithLabel(
                  //             labelText: 'Password',
                  //             hintText: 'Enter your password',
                  //           ),
                  //           TextFieldWithLabel(
                  //             labelText: 'Confirm password',
                  //             hintText: 'Confirm your password',
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomElevatedButton(
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const RegisterComplete(),
              //     ),
              //   );
              // },
              onPressed: () async {
                FocusScope.of(context).unfocus();

                await registerController.registerEmail(context);

                if (registerController.isLoading.value == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterComplete(),
                    ),
                    (route) => false,
                  );
                }
              },
              text: 'Continue'),
        ),
      ),
    );
  }
}

class TextFieldWithLabel extends StatelessWidget {
  final String labelText;
  final String hintText;
  // String? Function(String?)? validator;
  // TextEditingController? controller;

  const TextFieldWithLabel({
    Key? key,
    required this.labelText,
    required this.hintText,
    // this.validator,
    // this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        CustomTextFormField(
          hintTxt: hintText,
        ),
      ],
    );
  }
}
