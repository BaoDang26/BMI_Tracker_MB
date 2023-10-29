import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/service_package/service_package_screen.dart';
import '../../screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/size.dart';
import '../../constants/text_strings.dart';
import '../../constants/image_strings.dart';
import '../../screens/profile/update_profile_screen.dart';
import '../../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              'https://scontent.fsgn8-4.fna.fbcdn.net/v/t1.6435-9/149694643_1773509462819136_6906009321502091505_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=pzzakZfvVk0AX_bIEpR&_nc_ht=scontent.fsgn8-4.fna&oh=00_AfBH1FJ-dh7Skk9paUOaku3QXY6_HvUqZXIxNTEEZ1wNtw&oe=654C4A28',
                            ))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(tProfileHeading,
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(tProfileSubHeading,
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
                      onPress: () {}),
                ],
              )),
        ));
  }
}
