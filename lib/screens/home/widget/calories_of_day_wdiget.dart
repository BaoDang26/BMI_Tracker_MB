import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/screens/home/model/chart_data.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyChartWidget extends StatefulWidget {
  const DailyChartWidget({super.key});

  @override
  State<DailyChartWidget> createState() => _DailyChartWidgetState();
}

class _DailyChartWidgetState extends State<DailyChartWidget> {
  var controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Center(
      child: Row(
        children: [
          SizedBox(
            height: 200.v,
            width: (mediaQuery.size.width / 5).h - 20,
            // color: Colors.lightGreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                ),
                Obx(
                  () => Text(
                      "${controller.homePageModel.value.totalCaloriesOut} kcal",
                      style: TextStyle(
                        fontSize: 13.fSize,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Text("Burned",
                    style: TextStyle(
                      fontSize: 13.fSize,
                    )),
              ],
            ),
          ),
          Container(
            height: 200.v,
            width: (mediaQuery.size.width / 2).h,
            padding: EdgeInsets.zero,
            child: Obx(
              () => SfCircularChart(
                margin: EdgeInsets.zero,
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // Remaining bằng default + out - in
                          ' ${controller.homePageModel.value.remainingCalories}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.fSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Remaining',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.fSize,
                          ),
                        ),
                      ],
                    ),
                    // Adjust position if necessary
                    radius: '0%',
                    angle: 0,
                  ),
                ],
                series: <CircularSeries>[
                  // Configure doughnut series
                  DoughnutSeries<ChartData, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) => data.color,
                    // Configure doughnut series
                    // Độ dày của lượt đồ
                    innerRadius: '80%',
                    // điểm bắt dầu và kết thúc 230 độ và 130 độ (max 360 độ, 0 độ ở 12h và 180 dộ ở 6h)
                    startAngle: 230,
                    endAngle: 130,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200.v,
            width: (mediaQuery.size.width / 5).h - 20,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.set_meal_sharp,
                  color: Colors.green,
                ),
                Obx(
                  () => Text(
                      "${controller.homePageModel.value.totalCaloriesIn} kcal",
                      style: TextStyle(
                          fontSize: 13.fSize, fontWeight: FontWeight.bold)),
                ),
                Text("Eaten",
                    style: TextStyle(
                      fontSize: 13.fSize,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 