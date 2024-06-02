import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class EmpTyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late List<_ChartData> data;
    late List<_ChartData> data2;
    late TooltipBehavior _tooltip;
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    data2 = [
      _ChartData('CHN', 15),
      _ChartData('GER', 12),
      _ChartData('RUS', 54),
      _ChartData('BRZ', 6.1),
      _ChartData('IND', 12)
    ];
    _tooltip = TooltipBehavior(enable: true);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1)),
              ColumnSeries<_ChartData, String>(
                  dataSource: data2,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(50, 255, 255, 50)),
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
