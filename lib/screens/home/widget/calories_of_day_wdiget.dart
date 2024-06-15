import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChartWidget extends StatelessWidget {
  const DoughnutChartWidget({super.key});

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
                Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                ),
                Text("200 kcal",
                    style: TextStyle(
                      fontSize: 13.fSize,
                      fontWeight: FontWeight.bold,
                    )),
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
            child: SfCircularChart(
              margin: EdgeInsets.zero,
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1800',
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
                DoughnutSeries<Data, String>(
                  dataSource: <Data>[
                    Data('Category A', 200, Colors.lightGreen),
                    Data('Category B', 1800, Colors.black26),
                  ],
                  xValueMapper: (Data data, _) => data.category,
                  yValueMapper: (Data data, _) => data.value,
                  pointColorMapper: (Data data, _) => data.color,
                  // Configure doughnut series
                  // Độ dày của lượt đồ
                  innerRadius: '80%',
                  // điểm bắt dầu và kết thúc
                  startAngle: 230,
                  endAngle: 130,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200.v,
            width: (mediaQuery.size.width / 5).h - 20,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.set_meal_sharp,
                  color: Colors.green,
                ),
                Text("400 kcal",
                    style: TextStyle(
                        fontSize: 13.fSize, fontWeight: FontWeight.bold)),
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

// Model class for data
class Data {
  final String category;
  final double value;
  final Color color;

  Data(this.category, this.value, this.color);
}
