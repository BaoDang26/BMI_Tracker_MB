import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/payment_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/num_utils.dart';

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
              'Package name',
              Obx(() => Flexible(
                    child: Text(
                      '${controller.packageModel.value.packageName}',
                      style: TextStyle(fontSize: 15.fSize),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )),
            ),
            buildRow(
              'Order number',
              Obx(() => Text(
                    '${controller.subscriptionRequest.value.subscriptionNumber}',
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
                      '${controller.subscriptionRequest.value.description}',
                      style: TextStyle(fontSize: 15.fSize),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  )),
            ),
            buildRow(
                'Start date',
                Obx(
                  () => Text(
                    controller.startDate.value,
                    style: TextStyle(fontSize: 15.fSize),
                  ),
                )),
            // Add your date formatting here
            buildRow(
              'End date',
              Obx(() => Text(
                    controller.endDate.value,
                    style: TextStyle(fontSize: 15.fSize),
                  )),
            ),
            const Divider(thickness: 3),
            buildRow(
              'Total',
              Obx(() => Text(
                    '${controller.subscriptionRequest.value.amount?.formatWithThousandSeparator()} VND',
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
