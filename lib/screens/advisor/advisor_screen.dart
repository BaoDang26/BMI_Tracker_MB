// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/advisor/blog_screen.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import 'package:flutter_health_menu/widgets/advisor_card.dart';
import 'package:get/get.dart';

import '../../controllers/advisor_controller.dart';
import '../plan/plan_package_screen.dart';
import 'advisor_details_screen.dart';

class AdvisorScreen extends GetView<AdvisorController> {
  const AdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffe9e7f2),
          toolbarHeight: 120.h,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Get a Advisor',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 15),
              //   child: CustomTextFormField(
              //     fillColor: Colors.white,
              //     borderRadius: 0,
              //     prefixicon: const Icon(Icons.search),
              //     hintTxt: 'Search your trainer',
              //   ),
              // ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 200.h,
              decoration: const BoxDecoration(
                color: Color(0xffe9e7f2),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(70),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.advisorList.length,
                  // itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                        children: [
                          AdvisorCard(
                            advisor: controller.advisorList[index],
                            isActive: true,
                            onBlogClick: () {
                              Get.to(const BlogScreen(),
                                  arguments: [controller.advisorList[index]]);
                            },
                            onMessageClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CometChatConversationsWithMessages(
                                    conversationsConfiguration:
                                        ConversationsConfiguration(
                                      backButton: IconButton(
                                        onPressed: () {
                                          controller.getBack();
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new),
                                      ),
                                    ),
                                    // user: User.fromUID(
                                    //   uid: controller
                                    //       .advisorList[index].advisorID
                                    //       .toString(),
                                    //   name: controller
                                    //       .advisorList[index].fullName,
                                    // ),
                                  ),
                                ),
                              );
                            },
                            onBookClick: () {
                              controller.goToChoosePlan();
                            },
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
