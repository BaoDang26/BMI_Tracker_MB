// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/register_controller.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/screens/register/register_complete.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:flutter_health_menu/widgets/custom_datetext_form_field.dart';
import 'package:flutter_health_menu/widgets/custom_drop_down_activity.dart';
import 'package:flutter_health_menu/widgets/custom_drop_down_dietary.dart';
import 'package:flutter_health_menu/widgets/custom_textnumber_form_field.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/register_member_controller.dart';
import '../../models/member_model.dart';
import '../../widgets/widgets.dart';

class RegisterInFoScreen extends StatelessWidget {
  const RegisterInFoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerMemberController = Get.put(RegisterMemberController());
    final loginController = Get.put(LoginController());
    MemberModel currentMember = loginController.loginedMember.value;

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
                          'User Information',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'We need more information about you!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: Form(
                    key: registerMemberController.registerFormKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              'Dietary Preference',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! height field
                            Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  //! type
                  child: CustomDropDownDietary(
                    textValue: registerMemberController.dietaryPreferenceIDController.toString(),
                    onChange: (value) {
                      registerMemberController.activityLevelID = value.toString();
                    },
                  ), // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
                ),
                            Text(
                              'Height (cm)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! height field
                            CustomTextNumberFormField(
                              controller: registerMemberController.heightController,
                              onSaved: (value) {
                                registerMemberController.heightController.text = value!;
                              },
                              // validator: (value) {
                              //   return registerMemberController
                              //       .validateFullname(value!);
                              // },
                              hintTxt: 'Enter your height',
                              // suffixIcon: const Icon(Icons.email_outlined),
                            ),
                            Text(
                              'Weight (kg)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! weight field
                            CustomTextNumberFormField(
                              controller: registerMemberController.weightController,
                              onSaved: (value) {
                                registerMemberController.weightController.text = value!;
                              },
                              // validator: (value) {
                              //   return registerMemberController
                              //       .validateFullname(value!);
                              // },
                              hintTxt: 'Enter your height',
                              // suffixIcon: const Icon(Icons.email_outlined),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Target Weight (kg)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            //! weight field
                            CustomTextNumberFormField(
                              controller: registerMemberController.targetWeightController,
                              onSaved: (value) {
                                registerMemberController.targetWeightController.text = value!;
                              },
                              // validator: (value) {
                              //   return registerMemberController
                              //       .validateFullname(value!);
                              // },
                              hintTxt: 'Enter your target weight',
                              // suffixIcon: const Icon(Icons.email_outlined),
                            ),
                            
                            Text(
                              'Activity Level',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  //! type
                  child: CustomDropDownActivity(
                    textValue: registerMemberController.activityLevelID.toString(),
                    onChange: (value) {
                      registerMemberController.activityLevelID = value.toString();
                    },
                  ), // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
                ),

                            

                            
                            
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

                await registerMemberController.registerMember(context);

                if (registerMemberController.isLoading.value == true) {
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
