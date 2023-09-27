import 'package:flutter/material.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 5,
          child: Image(
            image: AssetImage('assets/images/sloth.png'),
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Good food at a cheap price",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  "You can eat at expensive restaurants with affordable price",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
