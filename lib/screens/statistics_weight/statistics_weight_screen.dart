import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/statistics_bodymass_model.dart';
import '../../util/app_export.dart';
import 'controller/statistics_weight_controller.dart';

class StatisticsWeightScreen extends GetView<StatisticsWeightController> {
  const StatisticsWeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(appTheme.green500),
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
            // title: Text("Statistics weight", style: theme.textTheme.titleLarge),
            leading: IconButton(
              onPressed: () {
                controller.getBack();
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text("Statistics weight",
                style: theme.textTheme.titleLarge),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.showUpdateBodyMass();
                  },
                  // {controller.goToUpdateProfileScreen()}
                  icon: const Icon(LineAwesomeIcons.alternate_pencil)),
            ]),
        body: Obx(() {
          if (controller.statisticsBodyMassModels.isEmpty) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/not_found.png",
                      width: 128.adaptSize),
                  Text("Not Enough data available yet.",
                      style: CustomTextStyles.titleMedium16Black),
                  // Text("body_no_results".tr, style: theme.textTheme.bodyMedium,)
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Last 30 days",
                          //   style: theme.textTheme.titleLarge,
                          // ),
                          RichText(
                            text: TextSpan(
                                text: "Starting weight: ",
                                style: CustomTextStyles.bodyMedium16,
                                children: [
                                  TextSpan(
                                      text:
                                          "${controller.statisticsBodyMassModels.first.weight} kg",
                                      style: CustomTextStyles.bodyMedium16Red)
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Goal weight: ",
                                style: CustomTextStyles.bodyMedium16,
                                children: [
                                  TextSpan(
                                      text: "${controller.goalWeight.value} kg",
                                      style:
                                          CustomTextStyles.bodyMedium16Green500)
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Current: ",
                                style: CustomTextStyles.bodyMedium16,
                                children: [
                                  TextSpan(
                                      text:
                                          "${controller.statisticsBodyMassModels.last.weight} kg",
                                      style:
                                          CustomTextStyles.bodyMedium16Grey500)
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // biểu đồ calories in, out
                  Expanded(
                    flex: 7,
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      // Điều chỉnh khoảng cách giữa các giá trị trên trục y
                      primaryYAxis: const NumericAxis(interval: 2),
                      //Enables the tooltip for all the series
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        LineSeries<StatisticsMemberBodyMassModel, String>(
                          dataSource: controller.statisticsBodyMassModels,
                          xValueMapper:
                              (StatisticsMemberBodyMassModel data, _) =>
                                  data.dateInput!.format("MM-dd"),
                          yValueMapper:
                              (StatisticsMemberBodyMassModel data, _) =>
                                  data.weight,
                          enableTooltip: true,
                        )
                      ],
                    ),
                  ),
                  Text("${"History"}: ", style: theme.textTheme.titleLarge),
                  // danh sách cân nặng thay đổi
                  Expanded(
                    flex: 5,
                    child: Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.statisticsBodyMassModels.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                HistoryItem(
                                    date: controller
                                        .statisticsBodyMassModels[index]
                                        .dateInput!
                                        .format(),
                                    weight: controller
                                        .statisticsBodyMassModels[index]
                                        .weight!),
                                Divider()
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      );
    });
  }
}

class HistoryItem extends StatelessWidget {
  final String date;
  final int weight;

  const HistoryItem({
    super.key,
    required this.date,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuerySize.width,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(date, style: CustomTextStyles.bodyMedium16),
            const Spacer(),
            Column(
              children: [
                Text("$weight kg", style: CustomTextStyles.bodyMedium16Grey500),
              ],
            )
          ],
        ),
      ),
    );
  }
}
