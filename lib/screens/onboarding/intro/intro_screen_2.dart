import 'package:flutter/material.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 5,
          child: Image(
            image: AssetImage('assets/images/panda.png'),
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Select the Favorites Menu",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  "Now eat well, don't leave the house,You can choose your favorite food only with one click",
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
