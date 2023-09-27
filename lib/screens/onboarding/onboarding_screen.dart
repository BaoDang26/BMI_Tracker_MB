import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //controller to keep track of pages
    PageController _controller = PageController();
    int pageNum = 0;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.85),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
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
                      if (pageNum == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        _controller.animateToPage(
                          pageNum,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                        pageNum++;
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    color: const Color(0xff32b768),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
