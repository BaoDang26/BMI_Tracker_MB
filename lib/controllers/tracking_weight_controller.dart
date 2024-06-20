import 'dart:convert';

import 'package:flutter_health_menu/models/memberbodymass_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../repositories/memberbodymass_repository.dart';

class TrackingWeightController extends GetxController {
  RxBool isLoading = true.obs;
  String date = "";
  RxList<MemberBodyMassModel> bodyMassModels = RxList.empty();

  @override
  Future<void> onInit() async {
    // lấy  date từ home controller qua arguments 0
    // date = await Get.arguments[0];
    date = "2024-06-01";

    // Gọi api lấy data cho màn hình
    await fetchDataTrackingWeight();

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchDataTrackingWeight() async {
    // lấy tất cả bodymass của member trong 30 ngày
    await getAllBodyMassLast30Days();

    isLoading.value = false;
  }

  getAllBodyMassLast30Days() async {
    // gọi repository lấy danh sách Bodymass trong 30 ngày
    var response =
        await MemberBodyMassRepository.getAllBodyMassLast30Days(date);

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // thành công, chuyển dổi từ json sáng BodymassModel
      bodyMassModels.value = memberBodyMassModelFromJson(response.body);
      print('${bodyMassModels.toString()}');
    } else if (response.statusCode == 401) {
      Get.snackbar("Error", jsonDecode(response.body)["message"],
          duration: 3.seconds);
    }
  }
}
