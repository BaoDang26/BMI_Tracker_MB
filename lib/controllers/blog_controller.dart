import 'dart:convert';

import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:flutter_health_menu/models/models.dart';
import 'package:flutter_health_menu/repositories/blog_repository.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  var isLoading = true.obs;
  var errorString = ''.obs;
  // var currentUser = UserModel().obs;
  var currentBlog = BlogModel().obs;
  final loginController = Get.put(LoginController());
  late UserModel currentUser;

  @override
  void onInit() {
    super.onInit();
    currentUser = loginController.loginedUser.value;
    // getUserBodyMaxById(userInfoId: currentUser.userbodymaxs!.userInfoId!);
    getBlogByUserId(userId: currentUser.userId!);

    // Timer.periodic(const Duration(seconds: 30), (timer) {
    //   log("Getting new food every 30s");
    //   fetchPosts();
    // });
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getBlogByUserId({required String userId}) async {
    var response = await BlogRepository.getBlogByUserId("blog/$userId");
    if (response != null) {
      // var data = BlogModel.fromJson(jsonDecode(response));
      currentBlog.value = blogModelFromJson(response);
    }
  }
}
