// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/package_controller.dart';
import 'package:flutter_health_menu/models/package_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class PlanPackageScreen extends GetView<PackageController> {
  const PlanPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Subscribe Advisor',
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 20.v),
          child: Obx(
            () => controller.packageModels.isNotEmpty
                ? CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      height: double.infinity,
                    ),
                    itemCount: controller.packageModels.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return ServicePlan(
                        benefitList: controller
                            .packageModels[index].description!
                            .split("\n")
                            .map((value) => value.trim())
                            .toList(),
                        planName:
                            '${controller.packageModels[index].packageName}',
                        price: controller.packageModels[index].price!,
                        duration:
                            controller.packageModels[index].packageDuration!,
                        isPopular: controller.packageModels[index].popular!,
                        onPressed: () {
                          controller.orderPlan(index);
                        },
                      );
                    },
                  )
                : const Center(
                    child:
                        // Hiển thị loading khi đang tải dữ liệu
                        CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }
}
