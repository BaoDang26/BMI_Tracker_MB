// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/register_controller.dart';
import 'package:flutter_health_menu/screens/register/register_complete.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/widgets/custom_datetext_form_field.dart';
import 'package:flutter_health_menu/widgets/custom_drop_down_gender.dart';
import 'package:flutter_health_menu/widgets/custom_text_form_password_field.dart';
import 'package:flutter_health_menu/widgets/custom_textnumber_form_field.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class RegisterInScreen extends GetView<RegisterController> {
  const RegisterInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    // final controller = Get.put(controller());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register Account',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Expanded(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       IconButton(
              //         onPressed: () {
              //           // Get.offAll(LoginScreen());
              //           Get.back();
              //         },
              //         icon: Icon(
              //           Icons.arrow_back,
              //           color: Theme
              //               .of(context)
              //               .primaryColor,
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //
              //           Text(
              //             'Let create your account',
              //             style: Theme
              //                 .of(context)
              //                 .textTheme
              //                 .bodyLarge,
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              Container(
                height: mediaQueryData.size.height - 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.registerFormKey,
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
                              controller: controller.fullnameController,
                              onSaved: (value) {
                                controller.fullname = value!;
                              },
                              validator: (value) {
                                return controller.validateFullname(value!);
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
                              controller: controller.emailController,
                              onSaved: (value) {
                                controller.email = value!;
                              },
                              validator: (value) {
                                return controller.validateEmail(value!);
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
                              controller: controller.phoneNumberController,
                              onSaved: (value) {
                                controller.phonenumber = value!;
                              },
                              validator: (value) {
                                return controller.validatePhoneNumber(value!);
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
                            CustomTextPasswordField(
                              controller: controller.passwordController,
                              onSaved: (value) {
                                controller.password = value!;
                              },
                              validator: (value) {
                                return controller.validatePassword(value!);
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
                            CustomTextPasswordField(
                              controller: controller.rePasswordController,
                              onSaved: (value) {
                                controller.rePassword = value!;
                              },
                              validator: (value) {
                                return controller.validateRePassword(value!);
                              },
                              hintTxt: 'Enter Confirm password',
                              isObscure: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Gender',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! gender field
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              //! type
                              child: CustomDropDownGender(
                                textValue: controller.genderValue.toString(),
                                onChange: (value) {
                                  controller.genderValue = value.toString();
                                },
                              ), // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
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
                              controller: controller.birthdayController,
                              onSaved: (value) {
                                controller.birthday = value!;
                              },
                              hintTxt: 'Enter your birthday',
                              suffixIcon:
                                  const Icon(Icons.calendar_today_rounded),
                            ),
                            const SizedBox(height: 15),
                          ],
                        )
                      ],
                    ),
                  ),
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

                await controller.registerEmail(context);

                if (controller.isLoading.value == true) {
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
