import 'package:flutter/material.dart';
// import 'package:flutter_health_menu/screens/forget_password/change_new_password_screen.dart';
import '../../screens/forget_password/forget_password_verify_screen.dart';
// import 'package:flutter_health_menu/screens/login/login_screen.dart';
// import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';

import '../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          'Forgot Password',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Enter your registered email below!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email address',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          CustomTextFormField(
                            hintTxt: 'Enter your email',
                          ),
                        ],
                      )
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetPasswordVerifyScreen(),
                  ),
                );
              },
              text: 'Continue'),
        ),
      ),
    );
  }
}
