import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class EmpTyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late List<_ChartData> data;
    late List<_ChartData> data2;
    late TooltipBehavior _tooltip;
    data = [
      _ChartData('02-01', 1200),
      _ChartData('03-01', 2000),
      _ChartData('04-01', 2200),
      _ChartData('05-01', 1800),
      _ChartData('06-01', 1800),
      _ChartData('07-01', 1800),
      _ChartData('08-01', 1800),
      _ChartData('09-01', 1800),
      _ChartData('10-01', 1950)
    ];
    data2 = [
      _ChartData('02-01', 60),
      _ChartData('03-01', 200),
      _ChartData('04-01', 100),
      _ChartData('05-01', 700),
      _ChartData('05-01', 700),
      _ChartData('05-01', 700),
      _ChartData('05-01', 700),
      _ChartData('06-01', 500)
    ];
    _tooltip = TooltipBehavior(enable: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: Container(
        height: context.mediaQuerySize.height /2,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 5000, interval: 200),
          tooltipBehavior: _tooltip,
          series: <CartesianSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Calories',
                color: Color.fromRGBO(8, 142, 255, 1)),
            ColumnSeries<_ChartData, String>(
              dataSource: data2,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Calories burned',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
