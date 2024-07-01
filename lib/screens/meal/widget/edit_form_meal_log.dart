import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/meal_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:numberpicker/numberpicker.dart';

class EditFormMealLog extends StatefulWidget {
  @override
  _EditFormMealLogState createState() => _EditFormMealLogState();
}

class _EditFormMealLogState extends State<EditFormMealLog> {
  int _currentValue = 1;
  String _selectedUnit = 'Serving (30 g)';
  List<String> _units = [
    'Serving (30 g)',
    'Cup (150 g)',
    'Package (150 g)',
    'Gram'
  ];

  var controller = Get.find<MealDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Custom Entry'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // Container(
                //   height: 200,
                //   width: 150,
                //   child: ListWheelScrollView(
                //     diameterRatio: 1.5,
                //     itemExtent: 50,
                //     physics: FixedExtentScrollPhysics(),
                //     onSelectedItemChanged: (index) {
                //       controller.setSelectedIndex(index);
                //     },
                //     children: List<Widget>.generate(20, (index) {
                //       return Obx(() {
                //         bool isSelected =
                //             controller.selectedIndex.value == index;
                //         double scale = isSelected ? 1.5 : 1.0;
                //         double opacity = isSelected ? 1.0 : 0.2;
                //         return Transform.scale(
                //           scale: scale,
                //           child: Opacity(
                //             opacity: opacity,
                //             child: Center(
                //               child: Text(
                //                 index == 0 ? '-' : '$index',
                //                 style: TextStyle(fontSize: 24),
                //               ),
                //             ),
                //           ),
                //         );
                //       });
                //     }),
                //   ),
                // ),
                // Container(
                //   height: 200,
                //   width: 150,
                //   child: ListWheelScrollView.useDelegate(
                //     itemExtent: 50,
                //     diameterRatio: 1.5,
                //     physics: FixedExtentScrollPhysics(),
                //     onSelectedItemChanged: (index) {
                //       controller.setSelectedIndex(index);
                //     },
                //     childDelegate: ListWheelChildBuilderDelegate(
                //       builder: (context, index) {
                //         if (index < 0 || index >= 10) {
                //           return null;
                //         }
                //         return Obx(() {
                //           double opacity =
                //               controller.selectedIndex.value == index
                //                   ? 1.0
                //                   : 0.3;
                //           return Opacity(
                //             opacity: opacity,
                //             child: Center(
                //               child: Text(
                //                 index == 0 ? '-' : '$index',
                //                 style: TextStyle(fontSize: 24),
                //               ),
                //             ),
                //           );
                //         });
                //       },
                //       childCount: 10,
                //     ),
                //   ),
                // ),
                Container(
                  height: 100,
                  width: 110,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(height: 20),
            // Obx(() {
            //   return Text(
            //     'Selected Value: ${controller.getSelectedValue()}',
            //     style: TextStyle(fontSize: 24),
            //   );
            // }),
          ],
        ));
  }
}
