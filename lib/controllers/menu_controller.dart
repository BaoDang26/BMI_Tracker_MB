import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/models/menu_model.dart';
import 'package:flutter_health_menu/models/memberbodymass_model.dart';
import 'package:get/get.dart';

class MenuFController extends GetxController {
  var menuList = <MenuModel>[].obs;
  // var mealList = <MealModel>[].obs;
  // final loginController = Get.put(LoginController());
  late MemberBodyMassModel currentMember;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    // fetchMenuByMenuId(menu);
  }

  Future<void> fetchMenuByMenuId(String menuId) async {
    // currentUser = loginController.userinfo.value;
    // var data = await MenuReporitory.getMenuByMenuId(
    //     'menu/foodByMenuId/${currentUser.');
    // if (data != null) {
    //   menuList.value = menuModelFromJson(data);
    // }
    // isLoading.value = false;
    // update();
  }
}
