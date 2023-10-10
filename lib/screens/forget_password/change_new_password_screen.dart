// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
// import 'package:flutter_health_menu/screens/forget_password/change_password_complete.dart';
import '../../screens/forget_password/change_password_complete.dart';

import '../../widgets/widgets.dart';

class ChangeNewPasswordScreen extends StatelessWidget {
  const ChangeNewPasswordScreen({super.key});

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
                          'Change new password',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Enter a different password with the previous',
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New password',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              CustomTextFormField(
                                hintTxt: 'Enter new password',
                                // suffixIcon: const Icon(Icons.email_outlined),
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
                              CustomTextFormField(
                                hintTxt: 'Enter confirm password',
                                isObscure: true,
                                // suffixIcon: IconButton(
                                //   onPressed: () {},
                                //   icon:
                                //       const Icon(Icons.remove_red_eye_outlined),
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
                    builder: (context) => const ChangePasswordComplete(),
                  ),
                );
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
  const TextFieldWithLabel({
    Key? key,
    required this.labelText,
    required this.hintText,
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
