// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_health_menu/controllers/login_controller.dart';
// import 'package:flutter_health_menu/controllers/schedule_controller.dart';
// import 'package:flutter_health_menu/models/login_model.dart';
// import 'package:flutter_health_menu/models/member_model.dart';
// import 'package:flutter_health_menu/models/memberbodymass_model.dart';
// import 'package:flutter_health_menu/models/register_member_model.dart';
// import 'package:flutter_health_menu/models/schedule_model.dart';
// import 'package:flutter_health_menu/repositories/member_repository.dart';
// import 'package:flutter_health_menu/repositories/memberbodymass_repository.dart';
// import 'package:get/get.dart';

// class UserBodyMaxController extends GetxController {
//   final GlobalKey<FormState> memberbodymassFormKey = GlobalKey<FormState>();
//   late TextEditingController heightController;
//   late TextEditingController weightController;
//   late TextEditingController targetWeightController;
//   // late TextEditingController sexController;
//   var statusIsBlank = false.obs;
//   // late String sexValue;
//   var isLoading = true.obs;
//   var errorString = ''.obs;
//   var memberbodymass = <MemberBodyMassModel>[].obs;
//   final loginController = Get.put(LoginController());
//   // final scheduleController = Get.put(ScheduleController());
//   // final memberbodymass = MemberBodyMassModel(
//   //   age: 0,
//   //   height: 0,
//   //   // sex: 0,
//   //   weight: 0,
//   //   // userId: '',
//   // ).obs;
//   late MemberModel currentMember;
//   // late ScheduleModel menuDefault;

//   @override
//   void onInit() {
//     super.onInit();
//     heightController = TextEditingController();
//     weightController = TextEditingController();
//     targetWeightController = TextEditingController();
//     // sexController = TextEditingController();
//     // sexValue = '0';
//     currentMember = loginController.loginedMember.value;

//     // menuDefault = scheduleController.menuDefault.value;
//     // menuDefault =

//     // Timer.periodic(const Duration(seconds: 30), (timer) {
//     //   log("Getting new food every 30s");
//     //   fetchPosts();
//     // });
//   }

//   @override
//   void onClose() {
//     heightController.dispose();
//     weightController.dispose();
//     targetWeightController.dispose();
//     // sexController.dispose();
//     super.onClose();
//   }

//   String? validateAge(String value) {
//     if (value.isEmpty || value.isNumericOnly) {
//       return "age is invalid";
//     }

//     return null;
//   }

//   String? validateHeight(String value) {
//     if (value.isEmpty) {
//       return "height is invalid";
//     }
//     return null;
//   }

//   String? validateWeight(String value) {
//     if (value.isEmpty) {
//       return "weight is invalid";
//     }
//     // userbodymaxRequest.value.weight ?? 0;
//     return null;
//   }

//   // Future<void> fetchUserBodyMaxs() async {
//   //   var data = await UserBodyMaxRepository.getUserBodyMax();
//   //   if (data != null) {
//   //     userbodymax.value = userBodyMaxModelFromJson(data);
//   //   }
//   //   isLoading.value = false;
//   //   update();
//   // }

//   Future<String?> registUserBodyMax(BuildContext context) async {
//     // {required List<String> menus}) async {
//     MemberBodyMassModel memberBodyMass2 = MemberBodyMassModel(
//       age: int.parse(targetWeightController.text),
//       height: int.parse(heightController.text),
//       weight: int.parse(weightController.text),
//       // sex: 0,
//       // userId: currentMember.userId ?? '',

//       // menuDefault: ScheduleModel(menuId: ''),
//       // userBodyMaxMenus: menus.isEmpty
//       //     ? List.empty()
//       //     : menus.map((e) => UserBodyMaxMenu(menuId: e)).toList(),
//     );

//     // sex: sexController.text);

//     var response = await MemberRepository.registerMember(
//         registerMemberModelToJson(memberBodyMass2), 'userBodyMax');

//     log('userbodymax controller response: ${response.toString()}');
//     // print('userbodymax: ${userBodyMax2}');
//     // Navigator.of(context).pop();
//     // ScaffoldMessenger.of(context)
//     //     .showSnackBar(SnackBar(content: Text('Complete information!')));
//     // Navigator.of(context).pop();

//     // var data = json.decode(response.toString());

//     // userBodyMax1.value = UserBodyMaxModel.fromMap(data);
//     // errorString.value = '';

//     // emailController = TextEditingController();
//     // passwordController = TextEditingController();

//     // log("Post userBodyMax:  ${loginedUser.toString()}");
//     errorString.value = '';
//     isLoading.value = false;
//   }
// }
