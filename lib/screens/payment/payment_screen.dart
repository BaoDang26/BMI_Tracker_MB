import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/payment_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../../widgets/custom_elevated_button.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Payment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            buildRow(
              'Plan name',
              Obx(() => Text(
                    "${controller.planModel.value.planName}",
                    style: TextStyle(fontSize: 15.fSize),
                  )),
            ),
            buildRow(
              'Order number',
              Obx(() => Text(
                    '${controller.orderRequest.value.orderNumber}',
                    style: TextStyle(fontSize: 15.fSize),
                  )),
            ),
            buildRow(
              'Advisor name',
              Obx(() => Text(
                    '${controller.advisorName}',
                    style: TextStyle(fontSize: 15.fSize),
                  )),
            ),
            buildRow(
              'Description',
              Obx(() => Flexible(
                    child: Text(
                      '${controller.orderRequest.value.description}',
                      style: TextStyle(fontSize: 15.fSize),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  )),
            ),
            buildRow(
                'Start date',
                Text(
                  DateTime.now().format(),
                  style: TextStyle(fontSize: 15.fSize),
                )),
            // Add your date formatting here
            buildRow(
              'End date',
              Obx(() => Text(
                    DateTime.now()
                        .add(Duration(
                            days: controller.orderRequest.value.planDuration ??
                                0))
                        .format(),
                    style: TextStyle(fontSize: 15.fSize),
                  )),
            ),
            const Divider(thickness: 3),
            buildRow(
              'Total',
              Obx(() => Text(
                    '${controller.orderRequest.value.amount?.toStringAsFixed(0)} VND',
                    style: TextStyle(
                        fontSize: 20.fSize, fontWeight: FontWeight.bold),
                  )),
              isLarge: true,
            ),
            SizedBox(height: 20.v),
            CustomElevatedButton(
                onPressed: () {
                  controller.planOrder();
                },
                text: 'Make Payment')
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, Widget value, {bool isLarge = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130.h,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isLarge ? 20.fSize : 15.fSize,
              ),
            ),
          ),
          value,
        ],
      ),
    );
  }
}
