import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/subscription_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/num_utils.dart';

class SubscriptionDetailsScreen extends GetView<SubscriptionDetailsController> {
  const SubscriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subscription Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubscriptionDetailItem(
                  label: 'Subscription Date',
                  value:
                      controller.subscriptionModel.value.getSubscriptionDate()),
              SubscriptionDetailItem(
                  label: 'Amount',
                  value:
                      '${controller.subscriptionModel.value.amount?.round().formatWithThousandSeparator()} VND'),

              const Divider(
                color: Color.fromARGB(255, 112, 105, 105),
              ),
              SubscriptionDetailItem(
                  label: 'Subscription Number',
                  value: controller.subscriptionModel.value.subscriptionNumber),
              SubscriptionDetailItem(
                  label: 'Description',
                  value: controller
                      .subscriptionModel.value.subscriptionDescription),
              // BookingDetailItem(
              //     label: 'Amount',
              //     value:
              //         '${controller.bookingModel.value.amount.toString()} VND'),
              // BookingDetailItem(
              //     label: 'Booking Date',
              //     value: controller.bookingModel.value.getBookingDate()),
              SubscriptionDetailItem(
                  label: 'Start Date',
                  value: controller.subscriptionModel.value.getStartDate()),
              SubscriptionDetailItem(
                  label: 'End Date',
                  value: controller.subscriptionModel.value.getEndDate()),

              SubscriptionDetailItem(
                  label: 'Advisor Name',
                  value: controller.subscriptionModel.value.advisorName
                      .toString()),
              SubscriptionDetailItem(
                  label: 'Status',
                  value: controller.subscriptionModel.value.subscriptionStatus
                      .toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionDetailItem extends StatelessWidget {
  final String? label;
  final String? value;

  const SubscriptionDetailItem({super.key, this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130.h,
            child: Text(
              label!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              value!,
              style: TextStyle(fontSize: 15.fSize),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
