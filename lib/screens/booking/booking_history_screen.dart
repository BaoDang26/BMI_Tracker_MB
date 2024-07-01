import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/booking_history_controller.dart';
import 'package:flutter_health_menu/screens/booking/widget/booking_item_widget.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class BookingHistoryScreen extends GetView<BookingHistoryController> {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(1),
          body: const Center(
            child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.lightGreenAccent),
          ),
        );
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Booking History',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.only(
                left: 15.h, top: 10.v, right: 15.h, bottom: 20.v),
            child: Obx(
              () => ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10.v);
                },
                itemCount: controller.bookingModels.length,
                itemBuilder: (context, index) {
                  return BookingItemWidget(index);
                },
              ),
            ),
          ));
    });
  }
}
