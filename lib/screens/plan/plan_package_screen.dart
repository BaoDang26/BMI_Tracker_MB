// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/plan_controller.dart';
import 'package:flutter_health_menu/models/plan_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class PlanPackageScreen extends GetView<PlanController> {
  const PlanPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> benefitList = [
      'Consult with a Trainer',
      'Trainer can customize menu \n for user',
      'Trainer can customize blog'
    ];

    // final paymentController = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Order Plan',
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 20.v),
          child: Obx(
            () => controller.planModels.isNotEmpty
                ? CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      height: double.infinity,
                    ),
                    itemCount: controller.planModels.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return ServicePlan(
                        benefitList: benefitList,
                        planName: '${controller.planModels[index].planName}',
                        price: controller.planModels[index].price!,
                        duration: controller.planModels[index].planDuration!,
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
                          controller.orderPlan(index);
                        },
                      );
                    },
                  )
                : const Center(
                    child:
                        CircularProgressIndicator(), // Hiển thị loading khi đang tải dữ liệu
                  ),
          ),
        ),
      ),
    );
  }
}
