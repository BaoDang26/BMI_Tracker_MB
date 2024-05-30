import 'package:flutter_health_menu/models/menu_model.dart';
import 'package:get/get.dart';

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
