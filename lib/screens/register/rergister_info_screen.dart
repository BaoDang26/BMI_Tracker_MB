// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/register/register_complete.dart';

import '../../widgets/widgets.dart';

class RegisterInfoScreen extends StatelessWidget {
  const RegisterInfoScreen({super.key});

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
                    children: const [
                      SizedBox(
                        height: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFieldWithLabel(
                              labelText: 'Fullname',
                              hintText: 'Enter your name',
                            ),
                            TextFieldWithLabel(
                              labelText: 'Age',
                              hintText: 'Enter your age',
                            ),
                            TextFieldWithLabel(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                            ),
                            TextFieldWithLabel(
                              labelText: 'Height',
                              hintText: 'Enter your height',
                            ),
                            TextFieldWithLabel(
                              labelText: 'Weight',
                              hintText: 'Enter your weight',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterComplete(),
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
