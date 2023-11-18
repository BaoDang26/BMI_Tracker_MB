// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/widgets.dart';

class TrackingFormScreen extends StatelessWidget {
  const TrackingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        child: Text('Breakfast'),
        value: 'Breakfast',
      ),
      DropdownMenuItem(
        child: Text('Lunch'),
        value: 'Lunch',
      ),
      DropdownMenuItem(
        child: Text('Dinner'),
        value: 'Dinner',
      ),
      DropdownMenuItem(
        child: Text('Item 4'),
        value: 'Item 4',
      ),
    ];

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
                  'Tracking Form',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Choose the finished meal',
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
                  child: CustomDropDownButton(
                      menuItems:
                          menuItems), // nếu bị lỗi khi truyền custom list text thì thay đổi biến selectedValue trong widget này bằng 1 trong các text trong list
                ),
                const SizedBox(height: 20),
                Text(
                  'Choose the portion that completes your meal for the day',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Center(
                  child: RatingBar.builder(
                    initialRating: 1,
                    itemCount: 4,
                    wrapAlignment: WrapAlignment.spaceEvenly,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 12),
                    itemSize: 70,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Text('50%');

                        case 1:
                          return const Text('75%');

                        case 2:
                          return const Text('100%');

                        case 3:
                          return const Text('+100%');

                        // case 4:
                        //   return const Text('+100%');

                        default:
                          return const Icon(Icons.question_mark);
                      }
                    },
                    onRatingUpdate: (rating) {
                      log('$rating');
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Note, if any?',
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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Say something here...',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: _showSimpleDialog,
                  text: 'SEND THE FORM',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your tracking will be send to app',
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
