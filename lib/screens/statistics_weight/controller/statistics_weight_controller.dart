import 'dart:convert';

import 'package:flutter_health_menu/models/member_model.dart';

import '../../../models/statistics_bodymass_model.dart';
import '../../../repositories/statistics_repository.dart';
import '../../../util/app_export.dart';

class StatisticsWeightController extends GetxController {
  RxList<StatisticsMemberBodyMassModel> statisticsBodyMassModels =
      RxList.empty();

  RxString goalWeight = "0".obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchStatisticsWeightData();
    super.onInit();
  }

  Future<void> fetchStatisticsWeightData() async {
    isLoading.value = true;
    MemberModel currentMember = MemberModel();

    currentMember =
        MemberModel.fromJson(jsonDecode(PrefUtils.getString("logged_member")!));
    goalWeight.value = currentMember.targetWeight.toString();
    DateTime date = DateTime.parse("2024-05-31");
    await getStatisticBodyMass(date.format());
    isLoading.value = false;
  }

  Future<void> getStatisticBodyMass(String date) async {
    // gọi API deactivate workout
    var response = await StatisticsRepository.getStatisticBodyMass(date);
    // kiểm tra kết quả
    print('response:${response.statusCode}');
    if (response.statusCode == 200) {
      print('response.body:${response.body}');
      statisticsBodyMassModels.value =
          statisticsMemberBodyMassFromJson(response.body);
    } else if (response.statusCode == 204) {
      statisticsBodyMassModels.clear();
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
  }
}
