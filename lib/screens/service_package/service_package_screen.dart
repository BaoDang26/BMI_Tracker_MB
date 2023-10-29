// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';

import '../../widgets/widgets.dart';

class ServicePackageScreen extends StatelessWidget {
  const ServicePackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> benefitList = [
      '50 images/day',
      'Limit of 500 images / month',
      'Background remove option',
      'Batch background remove'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Upgrade Plan',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              height: double.infinity,
            ),
            items: [
              ServicePlan(
                  benefitList: benefitList, planName: 'Standard', price: 3.99),
              ServicePlan(
                benefitList: benefitList,
                planName: 'Pro',
                price: 6.99,
                isPopular: true,
                isPromoted: true,
              ),
              ServicePlan(
                benefitList: benefitList,
                planName: 'Business',
                price: 12.99,
                isPromoted: true,
                promotedPrice: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
