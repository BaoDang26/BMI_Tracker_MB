import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_health_menu/theme/custom_text_form_field_style.dart';
import 'package:flutter_health_menu/theme/theme_helper.dart';
import 'package:flutter_health_menu/widgets/custom_drop_down_activity.dart';
import 'package:flutter_health_menu/widgets/custom_drop_down_dietary.dart';
import 'package:get/get.dart';

import '../../controllers/register_member_controller.dart';
import '../../widgets/widgets.dart';

class RegisterInFoScreen extends GetView<RegisterMemberController> {
  const RegisterInFoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(appTheme.green500),
            ),
          ),
        );
      }
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Member Information',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'We need more information about you!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 35),
                    child: Form(
                      key: controller.registerFormKey,
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
                              //! Dietary Preference field
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                //! type
                                child: CustomDropDownDietary(
                                  textValue: controller
                                      .dietaryPreferenceController
                                      .toString(),
                                  onChange: (value) {
                                    controller.dietaryPreferenceController =
                                        value.toString();
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
                              TextFormField(
                                controller: controller.heightController,
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                  controller.heightEditingComplete();
                                },
                                inputFormatters: [
                                  // Giới hạn 3 ký tự
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  return controller.validateHeight(value!);
                                },
                                decoration: CustomTextFormFieldStyles
                                    .heightTextFieldStyle,
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
                              TextFormField(
                                controller: controller.weightController,
                                validator: (value) {
                                  return controller.validateWeight(value!);
                                },
                                inputFormatters: [
                                  // Giới hạn 3 ký tự
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: CustomTextFormFieldStyles
                                    .weightTextFieldStyle,
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
                              TextFormField(
                                controller: controller.targetWeightController,
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                  controller.targetWeightChange();
                                },
                                validator: (value) {
                                  return controller
                                      .validateTargetWeight(value!);
                                },
                                inputFormatters: [
                                  // Giới hạn 3 ký tự
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixIcon: Obx(() {
                                    return Tooltip(
                                      message: controller.warningMessage.value,
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: controller.icon.value,
                                    );
                                  }),
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
                                  hintText: 'Enter your target weight',
                                ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                //! type
                                child: CustomDropDownActivity(
                                  textValue:
                                      controller.activityLevelID.toString(),
                                  onChange: (value) {
                                    controller.activityLevelID =
                                        value.toString();
                                  },
                                ), // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    await controller.registerMember();
                  },
                  text: 'Continue'),
            ),
          ),
        ),
      );
    });
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
