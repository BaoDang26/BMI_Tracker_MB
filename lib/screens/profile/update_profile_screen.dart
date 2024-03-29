// import 'package:bmi_tracker_mobile/screens/profile/profile_screen.dart';
// import 'package:bmi_tracker_mobile/widgets/custom_elevated_button.dart';
// import 'package:bmi_tracker_mobile/widgets/custom_text_form_field.dart';

// import 'package:bmi_tracker_mobile/constants/image_strings.dart';
// import 'package:bmi_tracker_mobile/constants/size.dart';
// import 'package:bmi_tracker_mobile/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/food_controller.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/controllers/userbodymax_controller.dart';
import 'package:flutter_health_menu/models/userBodyMax_model.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/screens/profile/update_profile_complete_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/size.dart';
import '../../constants/text_strings.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'profile_screen.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodController = Get.put(FoodController());
    final menuController = Get.put(MenuController());
    final userbodymaxController = Get.put(UserBodyMaxController());
    final loginController = Get.put(LoginController());
    UserModel currentUser = loginController.loginedUser.value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tEditProfile,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
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
                        ))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xff27b761),
                      ),
                      child: const Icon(LineAwesomeIcons.camera,
                          size: 20.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    hintTxt: '${currentUser.email}',
                    suffixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Full name',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    hintTxt: '${currentUser.fullName}',
                    suffixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Phone number',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    hintTxt: '${currentUser.phoneNumber}',
                    suffixIcon: const Icon(Icons.phone),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Gender',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    hintTxt: 'Male',
                    suffixIcon: const Icon(Icons.group_remove_outlined),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Age',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    hintTxt: '${currentUser.userbodymaxs?.age}',
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
              SizedBox(
                // flex: 2,
                child: Column(
                  children: [
                    CustomElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UpdateProfileComplete(),
                            ),
                            (route) => false,
                          );
                        },
                        text: 'Edit Profile'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
