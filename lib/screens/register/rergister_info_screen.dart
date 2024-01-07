// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/userbodymax_controller.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/screens/register/register_complete.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class RegisterInfoScreen extends StatelessWidget {
  const RegisterInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userbodymaxController = Get.put(UserBodyMaxController());
    final loginController = Get.put(LoginController());
    UserModel currentUser = loginController.loginedUser.value;
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
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // TextFieldWithLabel(
                            //   labelText: 'Fullname',
                            //   hintText: 'Enter your name',
                            // ),

                            CustomTextFormField(
                              controller: userbodymaxController.ageController,
                              onSaved: (value) {
                                userbodymaxController.age = value!;
                              },
                              validator: (value) {
                                return userbodymaxController
                                    .validateAge(value!);
                              },
                              hintTxt: 'Enter your age',
                            ),

                            CustomTextFormField(
                              controller:
                                  userbodymaxController.heightController,
                              onSaved: (value) {
                                userbodymaxController.height = value!;
                              },
                              validator: (value) {
                                return userbodymaxController
                                    .validateHeight(value!);
                              },
                              hintTxt: 'Enter your height',
                            ),

                            CustomTextFormField(
                              controller:
                                  userbodymaxController.weightController,
                              onSaved: (value) {
                                userbodymaxController.weight = value!;
                              },
                              validator: (value) {
                                return userbodymaxController
                                    .validateWeight(value!);
                              },
                              hintTxt: 'Enter your weight',
                            ),
                          ],
                        ),
                      ),
                    ],
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

                await userbodymaxController.registUserBodyMax(
                    createdBy: currentUser);

                if (userbodymaxController.isLoading.value == true) {
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
  // final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  const TextFieldWithLabel({
    Key? key,
    required this.labelText,
    // required this.hintText,
    required this.keyboardType,
    required this.inputFormatters,
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
        // CustomTextFormField(
        //   hintTxt: hintText,
        // ),
      ],
    );
  }
}
