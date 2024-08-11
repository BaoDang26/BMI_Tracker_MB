import '../../../util/app_export.dart';
import '../controllers/create_request_controller.dart';

class CreateRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateRequestController());
  }
}
