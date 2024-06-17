import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/memberbodymass_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/tracking_weight_controller.dart';

class TrackingWeightScreen extends GetView<TrackingWeightController> {
  late final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  TrackingWeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Check the loading state
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.transparent),
          );
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50.v,
            title: Text("Dietary Energy",
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.v,
                    child:
                        // Obx(
                        //   () =>
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last 30 Days",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text("Start weight: 100",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("Goal weight: 80",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("Current: 90 kg: ",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    // ),
                  ),
                  // biểu đồ calories in, out
                  SizedBox(
                    height: context.mediaQuerySize.height / 3,
                    child: Container(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        //Enables the tooltip for all the series
                        tooltipBehavior: _tooltipBehavior,
                        series: <CartesianSeries>[
                          LineSeries<MemberBodyMassModel, String>(
                            dataSource: controller.bodyMassModels,
                            xValueMapper: (MemberBodyMassModel data, _) =>
                                data.dateInput!.format(),
                            yValueMapper: (MemberBodyMassModel data, _) =>
                                data.weight,
                            enableTooltip: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("History: ",
                      style: Theme.of(context).textTheme.headlineMedium),
                  // danh sách cân nặng thay đổi
                  SizedBox(
                    height: context.mediaQuerySize.height -
                        230.v -
                        context.mediaQuerySize.height / 3,
                    child: Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.bodyMassModels.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  child: HistoryItem(
                                      date: controller
                                          .bodyMassModels[index].dateInput!
                                          .format(),
                                      weight: controller
                                          .bodyMassModels[index].weight!),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
            Text(date, style: TextStyle(fontSize: 15.fSize)),
            const Spacer(),
            Column(
              children: [
                Text("$weight kg", style: TextStyle(fontSize: 15.fSize)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
