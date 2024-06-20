import 'dart:convert';

import 'package:flutter_health_menu/controllers/advisor_controller.dart';

import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:flutter_health_menu/repositories/blog_repository.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class BlogController extends GetxController {
  var isLoading = true.obs;
  var blogList = <BlogModel>[].obs;
  var blogModel = BlogModel().obs;
  final advisorController = Get.put(AdvisorController());

  @override
  Future<void> onInit() async {
    // Nhận advisor ID từ Argument từ Advisor screen
    int advisorID = Get.arguments;

    await getBlogByAdvisorID(advisorID);

    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> getBlogByAdvisorID(int advisorID) async {
    var response = await BlogRepository.getBlogByAdvisorId(advisorID);

    // log('response: ${response}');
    if (response.statusCode == 200) {
      // chuyển dổi từ json sang advisor model
      blogList.value = blogModelFromJson(response.body);
    } else if (response.statusCode == 204) {
      // Quay về màn hình trước đó khi advisor không tồn tại
      blogList.clear();
      Get.back();
      Get.snackbar(
          "Blogs does not exist!", 'This advisor has not created any blog yet');
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }
    isLoading.value = false;

    update();
  }

  void goToBlogDetails(int index) {
    Get.toNamed(AppRoutes.blogDetailsScreen, arguments: blogList[index].blogId);
  }

  void getBack() {
    Get.back();
  }
}
