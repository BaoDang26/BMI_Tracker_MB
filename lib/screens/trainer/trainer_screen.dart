// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/trainer/trainer_details_screen.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Get a Trainer',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomTextFormField(
                  fillColor: Colors.white,
                  borderRadius: 0,
                  prefixicon: const Icon(Icons.search),
                  hintTxt: 'Search your trainer',
                ),
              ),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TrainerCard(
                        onDetailClick: () {
                          Get.to(const TrainerDetailsScreen());
                        },
                        onMessageClick: () {
                          log('message clicked');
                        },
                      ),
                      const SizedBox(height: 10),
                      TrainerCard(
                        isActive: true,
                        onDetailClick: () {
                          Get.to(const TrainerDetailsScreen());
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
                                    Get.back();
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new),
                                )),
                                user: User.fromUID(
                                    uid: 'superhero1', name: 'Người bàn ủi'),
                              ),
                            ),
                          );
                        },
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
