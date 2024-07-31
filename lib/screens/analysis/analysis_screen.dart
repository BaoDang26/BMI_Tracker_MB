import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/analysis/controller/analysis_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class AnalysisScreen extends GetView<AnalysisController> {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              // now button
              FilledButton(
                onPressed: () {
                  controller.goToWeightStatistics();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: appTheme.blueA100,
                  fixedSize: Size(150.h, 100.v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Image(
                  image: const AssetImage('assets/images/weight-scale.png'),
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                ),
              ),
              Text(
                'Weight Statistics'.tr,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              // now button
              FilledButton(
                onPressed: () {
                  controller.goToCaloriesStatistics();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: appTheme.yellow500,
                  fixedSize: Size(150.h, 100.v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Image(
                  image: const AssetImage('assets/images/calories.png'),
                  width: 60.adaptSize,
                  height: 60.adaptSize,
                ),
              ),
              Text(
                'Calories statistics',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
