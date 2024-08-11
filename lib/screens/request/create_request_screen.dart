import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../controllers/create_request_controller.dart';
import '../../theme/custom_button_style.dart';
import '../../util/app_export.dart';
import '../../widgets/custom_drop_down_button.dart';

class CreateRequestScreen extends GetView<CreateRequestController> {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'title_appbar_crete_workout'.tr,
                    'Create Request',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0.v),
          child: Container(
            margin: EdgeInsets.only(bottom: 80.v),
            child: Form(
              key: controller.createRequestFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 230, 250, 208),
                          radius: 50,
                          child: Image(
                            image:
                                const AssetImage('assets/images/request.png'),
                            width: 50.adaptSize,
                            height: 50.adaptSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'Type',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.v),
                  Container(
                    width: 170.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //! type
                    child: CustomDropDownButton(
                      textValue: controller.requestType,
                      onChange: (value) {
                        // controller.currentMember.value.gender = value;
                        controller.requestType = value;
                      },
                    ),
                    // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
                  ),
                  SizedBox(height: 10.v),
                  Text(
                    // 'txt_standard_weight'.tr,
                    'Purpose',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.v),
                  TextFormField(
                    maxLines: 5,
                    controller: controller.txtPurposeController,
                    onSaved: (value) {
                      controller.purpose = value!;
                    },
                    validator: (value) {
                      return controller.validatePurpose(value!);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your purpose'.tr,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10.v),
                ],
              ),
            ),
          ),
        ),
        // save request button
        floatingActionButton: SizedBox(
          height: 50.v,
          width: 200.h,
          child: ElevatedButton(
            style: CustomButtonStyles.outlineButtonGreen500,
            onPressed: () {
              // controller.createNewWorkout();
              controller.createRequest();
            },
            child: Text(
              "Save".tr,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
