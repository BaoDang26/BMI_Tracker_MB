// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/blog_controller.dart';
import 'package:flutter_health_menu/controllers/user_controller.dart';
import 'package:flutter_health_menu/models/user_model.dart';
import 'package:flutter_health_menu/screens/trainer/blog_details_screen.dart';
import 'package:flutter_health_menu/screens/trainer/trainer_details_screen.dart';
import 'package:flutter_health_menu/widgets/blog_card.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // list user
    // check role trainer by looping and putting into a list<usermodel>
    //Put list trainer into listview builder
    // final userController = Get.put(UserController());
    final blogController = Get.put(BlogController());
    // UserModel trainer = UserModel();
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
                  'List Blog',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 15),
              //   child: CustomTextFormField(
              //     fillColor: Colors.white,
              //     borderRadius: 0,
              //     prefixicon: const Icon(Icons.search),
              //     hintTxt: 'Search a blog',
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
            blogController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: blogController.currentBlog.length,
                    // itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            // TrainerCard(
                            //   trainer: trainer,
                            //   onDetailClick: () {
                            //     Get.to(const TrainerDetailsScreen());
                            //   },
                            //   onMessageClick: () {
                            //     log('message clicked');
                            //   },
                            // ),
                            // const SizedBox(height: 10),
                            BlogCard(
                              blog: blogController.currentBlog[index],
                              // isActive: true,
                              onDetailClick: () {
                                Get.to(const BlogDetailScreen(), arguments: [
                                  blogController.currentBlog[index]
                                ]);
                              },
                              // onMessageClick: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           CometChatConversationsWithMessages(
                              //         conversationsConfiguration:
                              //             ConversationsConfiguration(
                              //           backButton: IconButton(
                              //             onPressed: () {
                              //               Get.back();
                              //             },
                              //             icon: Icon(Icons.arrow_back_ios_new),
                              //           ),
                              //         ),
                              //         user: User.fromUID(
                              //           uid: userController
                              //               .trainerList[index].userId!,
                              //           name: userController
                              //               .trainerList[index].fullName!,
                              //         ),
                              //       ),
                              //     ),
                              //   );
                              // },
                            ),
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
