// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';

import 'package:flutter_health_menu/util/app_export.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;

import '../../widgets/widgets.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
            const Expanded(
              flex: 6,
              child: Image(
                image: AssetImage('assets/images/m1.png'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "Before enjoying BMI Tracker services Please sign in first",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          text: 'Join us now!',
                          onPressed: () {
                            showCustomBottomSheet(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCustomBottomSheet(BuildContext context) {
    return mbs.showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return const LoginBottomScreen();
      },
    );
  }
}

class LoginBottomScreen extends GetWidget<LoginController> {
  const LoginBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 30.v,
          ),
          child: Form(
            key: controller.loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back!",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "Hello there, sign in to continue!",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Obx(
                                  () => Text(
                                    controller.errorString.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                  ),
                                ),
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
                              SizedBox(height: 15.h),
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
                              Obx(
                                () => CustomTextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: controller.passwordController,
                                  onSaved: (value) {
                                    controller.password = value!;
                                  },
                                  validator: (value) {
                                    return controller.validatePassword(value!);
                                  },
                                  hintTxt: 'Enter your password',
                                  isObscure: controller.passwordVisible.value,
                                  suffixIcon: IconButton(
                                    icon: controller.passwordVisible.value
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      // chuyển đổi trạng thái ẩn hiện mât khẩu
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              controller.goToForgetPasswordScreen();
                            },
                            child: Text(
                              'Forgot password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CustomElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            //! login comet chat
                            // await CometChatUIKit.login(loginedUser.userId!,
                            //     onSuccess: (User user) {
                            //   debugPrint(
                            //       "User logged in successfully  ${user.name}");
                            // }, onError: (CometChatException e) {
                            //   debugPrint(
                            //       "Login failed with exception: ${e.message}");
                            // });
                            await controller.login(context);
                            // Get.to(BottomNavScreen());
                          },
                          text: 'Log in'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text("Don't have an account?",
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 10),
                      CustomElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.goToRegisterScreen();
                        },
                        text: 'Register',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
