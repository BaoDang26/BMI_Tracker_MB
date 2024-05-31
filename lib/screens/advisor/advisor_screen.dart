// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/member_model.dart';

import 'package:flutter_health_menu/widgets/advisor_card.dart';
import 'package:get/get.dart';

import '../../controllers/advisor_controller.dart';
import 'advisor_details_screen.dart';


class AdvisorScreen extends StatelessWidget {
  const AdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // list user
    // check role trainer by looping and putting into a list<usermodel>
    //Put list trainer into listview builder
    final advisorController = Get.put(AdvisorController());
    MemberModel advisor = MemberModel();
    // final userController =
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffe9e7f2),
          toolbarHeight: 120,
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
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xffe9e7f2),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(70),
                ),
              ),
            ),
            //TODO: Put list trainer here
            advisorController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: advisorController.advisorList.length,
                    // itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            AdvisorCard(
                              advisor: advisorController.advisorList[index],
                              // onDetailClick: () {
                              onBlogClick: () {
                                Get.to(const AdvisorDetailsScreen());
                              },
                              onMessageClick: () {
                                log('message clicked');
                              },
                            ),
                            // const SizedBox(height: 10),
                            // AdvisorCard(
                            //   advisor: advisorController.advisorList[index],
                            //   isActive: true,
                            //   onBlogClick: () {
                            //     // Get.to(const BlogScreen(), arguments: [
                            //     //   userController.trainerList[index]
                            //     // ]);
                            //   },

                            //   onMessageClick: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             CometChatConversationsWithMessages(
                            //           conversationsConfiguration:
                            //               ConversationsConfiguration(
                            //             backButton: IconButton(
                            //               onPressed: () {
                            //                 Get.back();
                            //               },
                            //               icon: Icon(Icons.arrow_back_ios_new),
                            //             ),
                            //           ),
                            //           user: User.fromUID(
                            //             uid: advisorController
                            //                 .advisorList[index].advisorID.toString(),
                            //             name: advisorController
                            //                 .advisorList[index].fullName.toString(),
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },

                            //   onBookClick: () {
                            //     // Get.to(const ServicePackageScreen());
                            //   },
                            // ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

