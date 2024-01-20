// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/login_controller.dart';
import 'package:flutter_health_menu/screens/feedback/feedback_complete_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/feedback_controller.dart';
import '../../models/user_model.dart';
import '../../widgets/widgets.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    final feedbackController = Get.put(FeedbackController());

    Future<void> _showSimpleDialog() async {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const FeedbackDialog();
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Give feedback',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Title Feedback',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    maxLines: 1,
                    controller: feedbackController.titleController,
                    validator: (value) {
                      return feedbackController.validateTitle(value!);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Your Title',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Feedback type',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  //! type
                  child: CustomDropDownButton(
                    textValue: feedbackController.feedbackType,
                    onChange: (value) {
                      setState(() {
                        log(value!);
                        feedbackController.feedbackType = value.toString();
                      });
                    },
                  ), // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
                ),
                const SizedBox(height: 20),
                // Text(
                //   'Rate your experience',
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyLarge!
                //       .copyWith(fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 10),
                // Center(
                //   child: RatingBar.builder(
                //     initialRating: 3,
                //     itemCount: 5,
                //     wrapAlignment: WrapAlignment.spaceEvenly,
                //     itemPadding: const EdgeInsets.symmetric(horizontal: 7),
                //     itemSize: 50,
                //     itemBuilder: (context, index) {
                //       switch (index) {
                //         case 0:
                //           return const Icon(
                //             Icons.sentiment_very_dissatisfied,
                //             color: Colors.amber,
                //           );
                //         case 1:
                //           return const Icon(
                //             Icons.sentiment_dissatisfied,
                //             color: Colors.amber,
                //           );
                //         case 2:
                //           return const Icon(
                //             Icons.sentiment_neutral,
                //             color: Colors.amber,
                //           );
                //         case 3:
                //           return const Icon(
                //             Icons.sentiment_satisfied,
                //             color: Colors.amber,
                //           );
                //         case 4:
                //           return const Icon(
                //             Icons.sentiment_very_satisfied,
                //             color: Colors.amber,
                //           );
                //         default:
                //           return const Icon(Icons.question_mark);
                //       }
                //     },
                //     onRatingUpdate: (rating) {
                //       log('$rating');
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),
                Text(
                  'Comment, if any?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    maxLines: 10,
                    controller: feedbackController.descriptionController,
                    validator: (value) {
                      return feedbackController.validateDescription(value!);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Say something here...',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  // onPressed: _showSimpleDialog,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    // await userbodymaxController.registUserBodyMax(context,
                    //     menus: <String>['d7349d45-db29-4e6b-adac-45e00cf4d5a5']);

                    await feedbackController.registFeedback(context);

                    if (feedbackController.isLoading.value == true) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackComplete(),
                        ),
                        (route) => false,
                      );
                    }
                    log('feedback drop: ${feedbackController.feedbackType}');
                    // Get.to(FeedbackComplete());
                  },
                  text: 'SEND FEEDBACK',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your review will be posted on the product page',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
