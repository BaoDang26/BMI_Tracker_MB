import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../controllers/home_page_controller.dart';
import '../../../models/enums/EMealType.dart';
import '../../../util/app_export.dart';

class MealItem extends StatefulWidget {
  final EMealType title;
  final int calories;
  final int goalCalories;

  const MealItem(
      {super.key,
      required this.title,
      required this.calories,
      required this.goalCalories});

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  var controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: _buildCircularChart(),
        title: Text(widget.title.name, style: const TextStyle(fontSize: 18)),
        subtitle: Text('${widget.calories} / ${widget.goalCalories} kcal'),
        // trailing: Icon(Icons.add, color: Colors.teal),
        trailing: IconButton(
          onPressed: () {
            controller.goToMealDetails(widget.title);
          },
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 15,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _buildCircularChart() {
    int remainingCalories = widget.goalCalories - widget.calories;
    Color remainingColor = remainingCalories >= 0 ? Colors.black26 : Colors.red;
    return SizedBox(
      width: 60.v,
      height: 60.h,
      child: SfCircularChart(
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: [
              ChartData('Consumed', widget.calories.toDouble(), Colors.green),
              ChartData(
                  'Remaining', remainingCalories.toDouble(), remainingColor),
            ],
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.color,
            innerRadius: '75%',
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, this.color);

  final String category;
  final double value;
  final Color color;
}
