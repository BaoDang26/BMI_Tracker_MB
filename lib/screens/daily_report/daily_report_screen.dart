// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/daily_report/daily_report_complete.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class DailyReportScreen extends StatelessWidget {
  const DailyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Meals Report',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunday, January 21st',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),

                //! Dishes checkbox list
                Text(
                  'Today dishes',
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
                  child: Column(
                    children: [
                      CustomCheckbox(
                        mealName: 'Breakfast',
                      ),
                      CustomCheckbox(
                        mealName: 'Lunch',
                        // calories: '120',
                      ),
                      CustomCheckbox(
                        mealName: 'Dinner',
                        // calories: '120',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  // ListView.builder(
                  //   itemCount: 2,
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     return
                  //   },
                  // ),
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),

                //! Comments
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
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Say something here...',
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //! Save button
                CustomElevatedButton(
                  // onPressed: () {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text(
                  //         'Great you have completed today meals!',
                  //         style: TextStyle(
                  //           fontStyle: FontStyle.italic,
                  //         ),
                  //       ),
                  //     ),
                  //   );

                  //   Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const BottomNavScreen(),
                  //     ),
                  //     (route) => false,
                  //   );
                  // },
                  onPressed: () {
                    // log(fController.meals.toString());
                    Get.to(DailyReportComplete());
                  },
                  text: 'SAVE REPORT',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your report will be saved!',
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
