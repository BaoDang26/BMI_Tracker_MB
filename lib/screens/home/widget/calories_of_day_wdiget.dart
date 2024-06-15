import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCircularChart(
        series: <CircularSeries>[
          // Configure doughnut series
          DoughnutSeries<Data, String>(
            dataSource: <Data>[
              Data('Category A', 90),
              Data('Category B', 10),
            ],
            xValueMapper: (Data data, _) => data.category,
            yValueMapper: (Data data, _) => data.value,
            // Configure doughnut series
            dataLabelSettings: DataLabelSettings(isVisible: true),
            startAngle: 270,
            endAngle: 90,
            legendIconType: LegendIconType.diamond,
          ),
        ],
      ),
    );
  }
}

// Model class for data
class Data {
  final String category;
  final double value;

  Data(this.category, this.value);
}
