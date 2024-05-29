// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter_health_menu/controllers/login_controller.dart';
// import 'package:flutter_health_menu/controllers/member_controller.dart';
// import 'package:flutter_health_menu/models/blog_model.dart';
// import 'package:flutter_health_menu/models/models.dart';
// import 'package:flutter_health_menu/repositories/blog_repository.dart';
// import 'package:get/get.dart';

// class BlogController extends GetxController {
//   var isLoading = true.obs;
//   var errorString = ''.obs;
//   // var currentUser = UserModel().obs;
//   // var trainerList = <UserModel>[].obs;
//   var currentBlog = <BlogModel>[].obs;

//   final userController = Get.put(UserController());
//   // late UserModel currentUser;

//   @override
//   void onInit() {
//     super.onInit();

//     getBlogByUserId(userId: userController.trainerList[0].userId!.toString());

//     // Timer.periodic(const Duration(seconds: 30), (timer) {
//     //   log("Getting new food every 30s");
//     //   fetchPosts();
//     // });
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   Future<void> getBlogByUserId({required String userId}) async {
// // var data = await UserRepository.getListTrainer();

//     var response =
//         await BlogRepository.getBlogByUserId("blog/userId?userId=$userId");

//     log('response: ${response}');
//     if (response != null) {
//       // var data = BlogModel.fromJson(jsonDecode(response));

//       currentBlog.value = blogModelFromJson(response);
//     }
//     isLoading.value = false;
//     update();
//   }
// }
