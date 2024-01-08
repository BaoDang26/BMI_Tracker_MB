import 'dart:convert';
import 'dart:developer';

import 'package:flutter_health_menu/models/menu_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController extends GetxController {
  var menuid = '';
  var userInfoId = '';
  var errorString = ''.obs;
  var isLoading = true.obs;
  var menuDefault = MenuModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Future<void> fetchMenuById() async {
  //   var data = await
  // }
}
