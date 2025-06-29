import 'package:flutter/material.dart';
import 'package:flutter_health_menu/constants/size.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/text_strings.dart';
import '../../widgets/profile_menu.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(appTheme.green500),
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
            // leading: IconButton(
            //     onPressed: () => Get.to(() => const HomeScreen()),
            //     icon: const Icon(LineAwesomeIcons.angle_left)),
            title: Text(tProfile,
                style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              IconButton(
                  onPressed: () => {controller.goToUpdateProfileScreen()},
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
                          width: 120.h,
                          height: 120.v,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Obx(
                                () => Image(
                                    image: NetworkImage(controller
                                        .currentMember.value.accountPhoto!)),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.v),
                    Obx(
                      () => Text(controller.currentMember.value.fullName!,
                          // Text('Van Tung',
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                    Obx(() => Text('Age: ${controller.currentMember.value.age}',
                        // Text('tung10@gmail.com',
                        style: Theme.of(context).textTheme.bodyLarge)),

                    SizedBox(height: 20.v),
                    //MENU
                    ProfileMenuWidget(
                        title: "My Advisor",
                        iconimage:
                            const AssetImage('assets/images/advisor.png'),
                        onPress: () {
                          controller.goToMyAdvisor();
                        }),
                    ProfileMenuWidget(
                        title: "Subscription History",
                        iconimage: const AssetImage(
                            'assets/images/subscription_history.png'),
                        onPress: () {
                          controller.goToSubscriptionHistory();
                        }),
                    ProfileMenuWidget(
                      title: 'Change Password',
                      iconimage:
                          const AssetImage('assets/images/change_password.png'),
                      onPress: () {
                        controller.goToChangePasswordScreen();
                      },
                    ), 
                    ProfileMenuWidget(
                        title: "Support Request",
                        iconimage:
                            const AssetImage('assets/images/request.png'),
                        onPress: () {
                          controller.goToRequestScreen();
                        }),
                    const Divider(color: Colors.grey),
                    SizedBox(height: 10.v),

                    ProfileMenuWidget(
                        title: "Logout",
                        iconimage: const AssetImage('assets/images/logout.png'),
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () async {
                          controller.logout();
                        }),
                  ],
                ))),
      );
    });
  }
}
