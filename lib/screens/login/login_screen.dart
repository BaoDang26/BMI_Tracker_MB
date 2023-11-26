// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
// <<<<<<< HEAD;
import 'package:flutter_health_menu/screens/forget_password/forget_password_screen.dart';
// =======
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
// >>>>>>> 25d496309ba3b4d36900025afe90e879b7f5700d
import 'package:flutter_health_menu/screens/register/register_screen.dart';
import 'package:flutter_health_menu/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;

import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
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
                        const SizedBox(height: 15),
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

class LoginBottomScreen extends StatefulWidget {
  const LoginBottomScreen({
    super.key,
  });

  @override
  State<LoginBottomScreen> createState() => _LoginBottomScreenState();
}

class _LoginBottomScreenState extends State<LoginBottomScreen> {
  final loginController = Get.put(LoginController());

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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Form(
            key: loginController.loginFormKey,
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                controller: loginController.emailController,
                                onSaved: (value) {
                                  loginController.email = value!;
                                },
                                validator: (value) {
                                  return loginController.validateEmail(value!);
                                },
                                hintTxt: 'Enter your email',
                                suffixIcon: const Icon(Icons.email_outlined),
                              ),
                              const SizedBox(height: 15),
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
                                controller: loginController.passwordController,
                                onSaved: (value) {
                                  loginController.password = value!;
                                },
                                validator: (value) {
                                  return loginController
                                      .validatePasword(value!);
                                },
                                hintTxt: 'Enter your password',
                                isObscure: true,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen(),
                                ),
                              );
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
                  flex: 2,
                  child: Column(
                    children: [
                      CustomElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            // //! login comet chat
                            // await CometChatUIKit.login("u140747",
                            //     onSuccess: (User user) {
                            //   debugPrint(
                            //       "User logged in successfully  ${user.name}");
                            // }, onError: (CometChatException e) {
                            //   debugPrint(
                            //       "Login failed with exception: ${e.message}");
                            // });

                            await loginController.login();

                            //!push to next screen and remove the screen stacks
                            if (loginController.isLoading.value == true) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomNavScreen(),
                                ),
                                (route) => false,
                              );
                            }
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
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
