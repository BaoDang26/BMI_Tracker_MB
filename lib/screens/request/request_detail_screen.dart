import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/request_model.dart';

import '../../controllers/request_detail_controller.dart';
import '../../util/app_export.dart';

class RequestDetailsScreen extends GetView<RequestDetailsController> {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 230, 250, 208),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequestDetailItem(
              label: 'Request Type',
              value: controller.requestModel.value.type!,
            ),
            RequestDetailItem(
              label: 'Purpose',
              value: controller.requestModel.value.purpose!,
            ),
            RequestDetailItem(
              label: 'Creation Date',
              value: controller.requestModel.value.getCreationDate(),
            ),
            RequestDetailItem(
              label: 'Process Note',
              value: controller.requestModel.value.processNote,
            ),
            RequestDetailItem(
              label: 'Status',
              value: controller.requestModel.value.status,
            ),
            RequestDetailItem(
              label: 'Proccess Date',
              value: controller.requestModel.value.getProcessingDate(),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestDetailItem extends StatelessWidget {
  final String? label;
  final String? value;

  const RequestDetailItem({super.key, this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100.h,
            child: Text(
              label!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              value ?? '',
              style: TextStyle(fontSize: 15.fSize),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          )
        ],
      ),
    );
  }
}
