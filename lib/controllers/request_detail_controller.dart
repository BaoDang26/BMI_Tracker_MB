import '../models/request_model.dart';
import '../util/app_export.dart';

class RequestDetailsController extends GetxController {
  var isLoading = true.obs;
  Rx<RequestModel> requestModel = RequestModel().obs;

  @override
  Future<void> onInit() async {
    requestModel.value = Get.arguments;

    print('SubscriptionModel:${requestModel.toString()}');
    // TODO: implement onInit
    super.onInit();
  }
}
