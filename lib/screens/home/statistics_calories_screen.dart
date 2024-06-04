import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/daily_record_model.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/dietary_energy_controller.dart';

class StatisticsCaloriesScreen extends StatelessWidget {
  StatisticsCaloriesScreen({super.key});

  final dietaryController = Get.put(DietaryEnergyController());

  @override
  Widget build(BuildContext context) {
    TooltipBehavior tooltip = TooltipBehavior(enable: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("Dietary Energy",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Week: ",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text("Daily Average: ${dietaryController.dailyAverage}",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text("Goal: ${dietaryController.goalCalories}",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            // biểu đồ calories in, out
            SizedBox(
              height: context.mediaQuerySize.height / 3,
              child: Obx(
                () => SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: dietaryController.goalCalories.value + 500,
                      interval: 200,
                      // đường kẻ ngang default calories
                      plotBands: <PlotBand>[
                        PlotBand(
                            verticalTextPadding: '5%',
                            horizontalTextPadding: '5%',
                            text: 'Default calories',
                            textAngle: 0,
                            start: dietaryController.goalCalories.value,
                            end: dietaryController.goalCalories.value,
                            textStyle: TextStyle(
                                color: Colors.deepOrange, fontSize: 16),
                            borderColor: Colors.red,
                            borderWidth: 2)
                      ]),
                  tooltipBehavior: tooltip,
                  series: <CartesianSeries<DailyRecordModel, String>>[
                    ColumnSeries<DailyRecordModel, String>(
                        dataSource: dietaryController.dailyRecordModels,
                        xValueMapper: (DailyRecordModel data, _) => data.date,
                        yValueMapper: (DailyRecordModel data, _) =>
                            data.totalCaloriesIn,
                        name: 'CaloriesIn',
                        color: const Color.fromRGBO(8, 142, 255, 1)),
                    ColumnSeries<DailyRecordModel, String>(
                      dataSource: dietaryController.dailyRecordModels,
                      xValueMapper: (DailyRecordModel data, _) => data.date,
                      yValueMapper: (DailyRecordModel data, _) =>
                          data.totalCaloriesOut,
                      name: 'Calories burned',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            Text("History: ",
                style: Theme.of(context).textTheme.headlineMedium),
            // danh sách calories in, out
            SizedBox(
              height: context.mediaQuerySize.height -
                  230 -
                  context.mediaQuerySize.height / 3,
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: dietaryController.dailyRecordModels.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            child: HistoryItem(
                                date: dietaryController
                                    .dailyRecordModels[index].date!,
                                caloriesIn: dietaryController
                                    .dailyRecordModels[index].totalCaloriesIn!,
                                caloriesOut: dietaryController
                                    .dailyRecordModels[index]
                                    .totalCaloriesOut!),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String date;
  final int caloriesIn;
  final int caloriesOut;

  const HistoryItem(
      {super.key,
      required this.date,
      required this.caloriesIn,
      required this.caloriesOut});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuerySize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(date),
          const Spacer(),
          Column(
            children: [
              Text("+ $caloriesIn kcal"),
              Text("- $caloriesOut kcal"),
            ],
          )
        ],
      ),
    );
  }
}
