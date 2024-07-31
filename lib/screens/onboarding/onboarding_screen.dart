import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/onboarding_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';
import 'intro/intro_screen_1.dart';
import 'intro/intro_screen_2.dart';
import 'intro/intro_screen_3.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //controller to keep track of pages
    PageController _controller = PageController();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            // onPageChanged: (int page) {
            //   controller.currentPage.value = page;
            // },
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.85),
              margin: EdgeInsets.symmetric(horizontal: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.goToLoginScreen();
                    },
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Color(0xff32b768),
                          ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      type: WormType.thin,
                      dotColor: Color(0xffe6e6e6),
                      activeDotColor: Color(0xff32b768),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.currentPage.value == 3) {
                        controller.goToLoginScreen();
                      } else {
                        _controller.animateToPage(
                          controller.currentPage.value,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                        controller.currentPage.value++;
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    color: const Color(0xff32b768),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
