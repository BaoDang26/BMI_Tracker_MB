import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/booking_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class BookingDetailsScreen extends GetView<BookingDetailsController> {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingDetailItem(
                  label: 'Booking ID',
                  value: controller.bookingModel.value.bookingID.toString()),
              BookingDetailItem(
                  label: 'Booking Number',
                  value: controller.bookingModel.value.bookingNumber),
              BookingDetailItem(
                  label: 'Description',
                  value: controller.bookingModel.value.bookingDescription),
              BookingDetailItem(
                  label: 'Amount',
                  value: '${controller.bookingModel.value.amount.toString()} VND'),
              BookingDetailItem(
                  label: 'Booking Date',
                  value: controller.bookingModel.value.getBookingDate()),
              BookingDetailItem(
                  label: 'Start Date',
                  value: controller.bookingModel.value.getStartDate()),
              BookingDetailItem(
                  label: 'End Date',
                  value: controller.bookingModel.value.getEndDate()),
              BookingDetailItem(
                  label: 'Member ID',
                  value: controller.bookingModel.value.memberID.toString()),
              BookingDetailItem(
                  label: 'Advisor ID',
                  value: controller.bookingModel.value.advisorID.toString()),
              BookingDetailItem(
                  label: 'Status',
                  value: controller.bookingModel.value.bookingStatus),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingDetailItem extends StatelessWidget {
  final String? label;
  final String? value;

  BookingDetailItem({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value ?? ''),
        ],
      ),
    );
  }
}
