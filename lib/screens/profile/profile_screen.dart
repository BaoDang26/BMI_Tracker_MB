import 'package:flutter/material.dart';
import 'package:flutter_health_menu/constants/size.dart';
import 'package:flutter_health_menu/controllers/profile_controller.dart';
import 'package:flutter_health_menu/screens/plan/plan_package_screen.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/text_strings.dart';
import '../update_profile_screen/update_profile_screen.dart';
import '../../widgets/profile_menu.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const CircularProgressIndicator();
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
                    Obx(() => Text(
                        'BMI: ${controller.currentMember.value.bmi?.round()}',
                        // Text('tung10@gmail.com',
                        style: Theme.of(context).textTheme.bodyLarge)),

                    //const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    //const Divider(),
                    //const SizedBox(height: 10),

                    //MENU
                    ProfileMenuWidget(
                        title: "My Advisor",
                        icon: Icons.person,
                        onPress: () {
                          controller.goToMyAdvisor();
                        }),
                    ProfileMenuWidget(
                        title: "Subscription History",
                        icon: LineAwesomeIcons.clipboard,
                        onPress: () {
                          controller.goToSubscriptionHistory();
                        }),
                    // ProfileMenuWidget(
                    //     title: "Weight Statistics",
                    //     icon: LineAwesomeIcons.weight,
                    //     onPress: () {
                    //       controller.goToAnalysis();
                    //     }),
                    // ProfileMenuWidget(
                    //     title: "Calories Statistics",
                    //     icon: LineAwesomeIcons.bread_slice,
                    //     onPress: () {
                    //       controller.goToAnalysis();
                    //     }),
                    ProfileMenuWidget(
                        title: "Feedback",
                        icon: LineAwesomeIcons.sticky_note,
                        onPress: () {
                          controller.goToFeedback();
                        }),
                    const Divider(color: Colors.grey),
                    SizedBox(height: 10.v),

                    ProfileMenuWidget(
                        title: "Logout",
                        icon: LineAwesomeIcons.alternate_sign_out,
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
