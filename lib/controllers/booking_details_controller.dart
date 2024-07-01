import 'package:flutter_health_menu/models/booking_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class BookingDetailsController extends GetxController {
  var isLoading = true.obs;
  Rx<BookingModel> bookingModel = BookingModel().obs;

  @override
  Future<void> onInit() async {
    bookingModel.value = Get.arguments;

    print('bookingModel:${bookingModel.toString()}');
    // TODO: implement onInit
    super.onInit();
  }
}
