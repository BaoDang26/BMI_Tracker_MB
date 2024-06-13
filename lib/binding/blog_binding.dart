import 'package:flutter_health_menu/controllers/blog_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogController());
  }
}
