// import 'package:flutter/material.dart';
// import 'package:flutter_health_menu/models/sales_model.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class HomeScreen2 extends StatelessWidget {
//   const HomeScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Row(
//           children: [
//             Container(
//               height: 45,
//               width: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 image: const DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(
//                     'https://res.cloudinary.com/dh2srrs6l/image/upload/v1696748077/msab7kdm9zpuzqew12jq.jpg',
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Hi, AnNPP',
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelLarge!
//                         .copyWith(color: Colors.white)),
//                 Text(
//                   'Tuesday, 10 October',
//                   style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           WeeklyProgress(),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             height: 150,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: CustomChart(),
//           )
//         ],
//       ),
//     );
//   }
// }

// class CustomChart extends StatelessWidget {
//   const CustomChart({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//       primaryXAxis: CategoryAxis(),
//       primaryYAxis: NumericAxis(),
//       enableAxisAnimation: true,
//       title: ChartTitle(text: 'Activity'),
//       series: [
//         ColumnSeries<SalesData, String>(
//           isVisibleInLegend: false,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(5),
//             topRight: Radius.circular(5),
//           ),
//           color: Theme.of(context).primaryColor,
//           dataLabelSettings: DataLabelSettings(
//             isVisible: true,
//             labelPosition: ChartDataLabelPosition.outside,
//           ),
//           markerSettings: MarkerSettings(
//               isVisible: true,
//               height: 4,
//               width: 4,
//               shape: DataMarkerType.circle,
//               borderWidth: 3,
//               borderColor: Colors.red),
//           dataSource: SalesData.salesList,
//           xValueMapper: (SalesData sales, _) => sales.x,
//           yValueMapper: (SalesData sales, _) => sales.y,
//         )
//       ],
//     );
//   }
// }

// class WeeklyProgress extends StatelessWidget {
//   const WeeklyProgress({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 70,
//           width: double.infinity,
//           color: Theme.of(context).primaryColor,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Container(
//             height: 100,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: Card(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Weekly Proress',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall!
//                               .copyWith(
//                                 color: const Color(0xffed5e02),
//                               ),
//                         ),
//                         Text(
//                           'View report',
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                       ],
//                     ),
//                     CircularPercentIndicator(
//                       radius: 30.0,
//                       lineWidth: 7.0,
//                       animation: true,
//                       percent: 0.68,
//                       center: Text(
//                         "68%",
//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                               color: const Color(0xffed5e02),
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       progressColor: const Color(0xffed5e02),
//                       backgroundColor: Colors.transparent,
//                       animationDuration: 1500,
//                       circularStrokeCap: CircularStrokeCap.round,
//                       rotateLinearGradient: true,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
