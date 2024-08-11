// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import 'package:flutter_health_menu/widgets/advisor_card.dart';

import '../../controllers/advisor_controller.dart';

class AdvisorScreen extends GetView<AdvisorController> {
  const AdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.transparent),
        );
      }
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
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Text(
                    'Get a Advisor',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
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
              RefreshIndicator(
                onRefresh: () async {
                  // Call your refresh function here
                  await controller.refreshData();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.advisorList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Column(
                        children: [
                          AdvisorCard(
                            advisor: controller.advisorList[index],
                            isActive: true,
                            isSubscription: controller.isSubscription.value,
                            onBlogClick: () {
                              controller.goToBlogScreen(index);
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
                                  ),
                                ),
                              );
                            },
                            onBookClick: () {
                              controller.goToChoosePlan(index);
                            },
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
