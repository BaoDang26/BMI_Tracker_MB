import 'package:get/get.dart';

class FeedbackController extends GetxController {
  late String feedbackType;
  var meals = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    feedbackType = 'Menu';
  }
}
