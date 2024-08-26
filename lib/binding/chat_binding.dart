import '../controllers/chat_controller.dart';
import '../util/app_export.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
