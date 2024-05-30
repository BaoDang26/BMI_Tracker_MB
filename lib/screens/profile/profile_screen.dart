import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/screens/login/login_screen.dart';
import 'package:flutter_health_menu/screens/service_package/service_package_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/size.dart';
import '../../constants/text_strings.dart';
import '../../controllers/food_controller.dart';
import '../../controllers/memberbodymass_controller.dart';
import '../../models/memberbodymass_model.dart';
import '../../screens/profile/update_profile_screen.dart';
import '../../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    // final foodController = Get.put(FoodController());
    // final menuController = Get.put(MenuController());
    // final userbodymaxController = Get.put(UserBodyMaxController());
    final loginController = Get.put(LoginController());
    MemberModel currentMember = loginController.loginedMember.value;
    return Scaffold(
        appBar: AppBar(
            // leading: IconButton(
            //     onPressed: () => Get.to(() => const HomeScreen()),
            //     icon: const Icon(LineAwesomeIcons.angle_left)),
            title: Text(tProfile,
                style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              IconButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  icon: const Icon(LineAwesomeIcons.alternate_pencil)),
            ]),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            image: NetworkImage(
                              'https://res.cloudinary.com/dlipvbdwi/image/upload/v1705123226/Capstone/avatar_default_zhjqey.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('${currentMember.fullname}',
                  // Text('Van Tung',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text('${currentMember.email}',
                  // Text('tung10@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium),
                  //const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  //const Divider(),
                  //const SizedBox(height: 10),

                  //MENU
                  ProfileMenuWidget(
                      title: "Settings",
                      icon: LineAwesomeIcons.cog,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Diary plan ",
                      icon: LineAwesomeIcons.clipboard,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "My recipes",
                      icon: LineAwesomeIcons.bread_slice,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Payment method",
                      icon: LineAwesomeIcons.paypal,
                      onPress: () {
                        Get.to(const ServicePackageScreen());
                      }),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),

                  ProfileMenuWidget(
                      title: "Logout",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () async {
                        loginController.logout(context);
                      }),
                ],
              )),
        ));
  }
}
