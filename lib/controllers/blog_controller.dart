import 'dart:developer';

import 'package:flutter_health_menu/controllers/advisor_controller.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/member_controller.dart';

import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:flutter_health_menu/repositories/blog_repository.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  var isLoading = true.obs;
  var errorString = ''.obs;
  // var currentUser = UserModel().obs;
  // var trainerList = <UserModel>[].obs;
  var currentBlog = <BlogModel>[].obs;

  final memberController = Get.put(MemberController());
  final advisorController = Get.put(AdvisorController());
  // late UserModel currentUser;

  @override
  void onInit() {
    super.onInit();

    getBlogByAdvisorId(
        advisorId: advisorController.advisorList[0].advisorID!.toString());


    // Timer.periodic(const Duration(seconds: 30), (timer) {
    //   log("Getting new food every 30s");
    //   fetchPosts();
    // });
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getBlogByAdvisorId({required String advisorId}) async {
// var data = await UserRepository.getListTrainer();

    var response = await BlogRepository.getBlogByAdvisorId(
        "blogs/getAllByAdvisorID/$advisorId");

    log('response: ${response}');
    if (response != null) {
      // var data = BlogModel.fromJson(jsonDecode(response));

      currentBlog.value = blogModelFromJson(response);
    }
    isLoading.value = false;
    update();
  }
}
