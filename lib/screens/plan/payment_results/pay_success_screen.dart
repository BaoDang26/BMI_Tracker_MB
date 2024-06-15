import 'package:flutter/material.dart';
import 'package:flutter_health_menu/routes/app_routes.dart';
import 'package:flutter_health_menu/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Success',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/148/148767.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Payment is completed! Continue to use app.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.amber,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              CustomElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.bottomNavScreen);
                  },
                  text: 'Back to Home'),
            ],
          ),
        ),
      ),
    );
  }
}
