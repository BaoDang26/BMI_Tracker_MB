import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/request_model.dart';
import '../repositories/request_repository.dart';
import '../util/app_export.dart';
import 'request_controller.dart';

class CreateRequestController extends GetxController {
  final GlobalKey<FormState> createRequestFormKey = GlobalKey<FormState>();
  // late TextEditingController txtTypeController;
  late TextEditingController txtPurposeController;

  late String requestType;

  // var type = '';
  var purpose = '';
  var errorString = ''.obs;
  var isLoading = false.obs;

  Rx<RequestModel> requestModel = RequestModel().obs;

  @override
  void onInit() {
    // txtTypeController = TextEditingController();
    requestType = 'Menu';
    txtPurposeController = TextEditingController();
    errorString.obs;
    super.onInit();
  }

  @override
  void onClose() {
    // dispose controller
    txtPurposeController.dispose();

    super.onClose();
  }

  String? validatePurpose(String value) {
    if (value.isEmpty) {
      return "Purpose is can't be empty";
    } else if (value.length < 5 || value.length > 255) {
      return "Purpose must be between 5 and 255 characters";
    }
    return null;
  }

  Future<void> createRequest() async {
    isLoading = true.obs;
    final isValid = createRequestFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    createRequestFormKey.currentState!.save();

    RequestModel createRequest = RequestModel(
      type: requestType,
      purpose: txtPurposeController.text,
    );

    var response = await RequestRepository.createNewRequest(createRequest);

    //kiểm tra kết quả
    if (response.statusCode == 200) {
      // convert list exercises from json
      var requestController = Get.find<RequestController>();
      await requestController.fetchRequest();

      Get.back();
      Get.snackbar('Success', 'Create request successful');
      log(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      // thông báo lỗi
      Get.snackbar("Create failed!", jsonDecode(response.body)["purpose"]);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }

    isLoading = false.obs;
  }
}
