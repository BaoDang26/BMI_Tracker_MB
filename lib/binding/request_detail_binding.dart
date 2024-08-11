import '../controllers/request_detail_controller.dart';
import '../util/app_export.dart';

class RequestDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestDetailsController());
  }
}
