import 'dart:convert';
import 'dart:developer';

import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/member_controller.dart';
import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:flutter_health_menu/models/models.dart';
import 'package:flutter_health_menu/repositories/blog_repository.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  var isLoading = true.obs;
  var errorString = ''.obs;
  // var currentUser = UserModel().obs;
  // var trainerList = <UserModel>[].obs;
  var currentBlog = <BlogModel>[].obs;

  final memberController = Get.put(MemberController());
  // late UserModel currentUser;

  @override
  void onInit() {
    super.onInit();

    getBlogByMemberId(memberId: memberController.advisorList[0].memberID!.toString());

    // Timer.periodic(const Duration(seconds: 30), (timer) {
    //   log("Getting new food every 30s");
    //   fetchPosts();
    // });
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getBlogByMemberId({required String memberId}) async {
// var data = await UserRepository.getListTrainer();

    var response =
        await BlogRepository.getBlogByMemberId("blog/userId?userId=$memberId");

    log('response: ${response}');
    if (response != null) {
      // var data = BlogModel.fromJson(jsonDecode(response));

      currentBlog.value = blogModelFromJson(response);
    }
    isLoading.value = false;
    update();
  }
}
