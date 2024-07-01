import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/booking_history_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

// ignore: must_be_immutable
class BookingItemWidget extends StatelessWidget {
  BookingItemWidget(
    this.index, {
    Key? key,
  }) : super(
          key: key,
        );

  int index;

  var controller = Get.find<BookingHistoryController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.goToOrderDetails(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.v),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black26,
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(
            5.h,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: Obx(
                () => Text(
                  "${controller.bookingModels[index].bookingNumber}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SizedBox(height: 3.v),
            Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Obx(
                  () => Text(
                    controller.bookingModels[index].getBookingDate(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Text(
                        "Booking status",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.bookingModels[index].bookingStatus}",
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
                    opacity: 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Text(
                        "Plan duration",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.bookingModels[index].advisorID}",
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
                    opacity: 0.5,
                    child: Text(
                      "Amount",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.bookingModels[index].amount}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.v),
          ],
        ),
      ),
    );
  }
}
