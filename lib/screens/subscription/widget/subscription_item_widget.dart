import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/subscription_history_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/util/num_utils.dart';

// ignore: must_be_immutable
class SubscriptionItemWidget extends StatelessWidget {
  SubscriptionItemWidget(
    this.index, {
    Key? key,
  }) : super(
          key: key,
        );

  int index;

  var controller = Get.find<SubscriptionHistoryController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.goToSubscriptionsDetails(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.v),
        decoration: ShapeDecoration(
          color: Color.fromARGB(255, 230, 250, 208),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: const CircleAvatar(
                child: Image(
                  image: AssetImage('assets/images/subscription_history.png'),
                ),
                radius: 20,
                // backgroundColor: Colors.green,
              ),
              // radius: 20,
              // backgroundColor: Theme.of(context).primaryColor,
              // Text(
              //   "${controller.bookingModels[index].bookingNumber}",
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              //   Icon(20 Icons.account_balance_sharp,
              //   color: Colors.green,
              //   ),
              //   radius: 20,
              // backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 3.v),
            Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Obx(
                  () => Text(
                    controller.subscriptionModels[index].getSubscriptionDate(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 112, 105, 105),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Text(
                        "Advisor name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.subscriptionModels[index].advisorName}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Text(
                      "Amount",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.subscriptionModels[index].amount?.round().formatWithThousandSeparator()} VND",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Text(
                      "Start date",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.subscriptionModels[index].getStartDate()}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Text(
                      "End date",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.subscriptionModels[index].getEndDate()}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Text(
                      "Subscription status",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.subscriptionModels[index].subscriptionStatus}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
