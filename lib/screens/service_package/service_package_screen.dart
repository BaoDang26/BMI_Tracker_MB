// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/payment_controller.dart';
import 'package:flutter_health_menu/screens/service_package/payment_results/fail_screen.dart';
import 'package:flutter_health_menu/screens/service_package/payment_results/success_screen.dart';
import 'package:flutter_health_menu/screens/service_package/payment_results/user_cancel_screen.dart';
import 'package:flutter_health_menu/screens/service_package/test_payment_screen.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class ServicePackageScreen extends StatelessWidget {
  const ServicePackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> benefitList = [
      'Consult with a Trainer',
      'Trainer can customize menu \n for user',
      'Trainer can customize blog'
    ];

    final paymentController = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Upgrade Plan',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              height: double.infinity,
            ),
            items: [
              ServicePlan(
                benefitList: benefitList,
                planName: 'Standard',
                price: 3.99,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  );
                  paymentController.planOrder(3.99);
                },
              ),
              ServicePlan(
                benefitList: benefitList,
                planName: 'Pro',
                price: 6.99,
                isPopular: true,
                isPromoted: true,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  );
                  paymentController.planOrder(6.99);
                },
              ),
              ServicePlan(
                benefitList: benefitList,
                planName: 'Business',
                price: 12.99,
                isPromoted: true,
                promotedPrice: 18,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  );
                  paymentController.planOrder(12.99);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
