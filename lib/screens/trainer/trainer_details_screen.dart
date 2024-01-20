import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/blog_controller.dart';
import 'package:flutter_health_menu/controllers/user_controller.dart';
import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
import '../feedback/feedback_screen.dart';
import '../service_package/service_package_screen.dart';

class TrainerDetailsScreen extends StatelessWidget {
  const TrainerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogController = Get.put(BlogController());
    // final BlogModel viewBlog = Get.arguments[0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            width: double.infinity,
            decoration: const BoxDecoration(
              // color: Colors.amber,
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.avatarfitness.co.uk/wp-content/uploads/Jacob-pdf.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // '${blogController.currentBlog[0].users?.fullName}',
                          'Jase Ramsey',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Fitness Instructor',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    FilledButton(
                      onPressed: () {
                        Get.to(ServicePackageScreen());
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Book Now'),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TrainerInfoCard(),
                ),
                Text(
                  'Gallery',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: blogController.currentBlog.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${blogController.currentBlog[index].blogPhoto}'),
                                  // '${viewBlog.blogPhoto}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Review',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CommentBox(
                      userImage:
                          'https://images.unsplash.com/photo-1546961329-78bef0414d7c?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      commentText:
                          'This is a really loooooooooooooooooooooooong instructions that is used as a placeholder!'),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const FeedbackScreen());
                  },
                  child: Text(
                    'Write Review',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TrainerInfoCard extends StatelessWidget {
  const TrainerInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).primaryColor.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('08', style: Theme.of(context).textTheme.titleLarge),
                  const Text(
                    'Work\n Experience',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 55,
              color: Colors.black,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '40',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    'Completed\n Workout',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 55,
              color: Colors.black,
            ),
            Expanded(
              child: Column(
                children: [
                  Text('100', style: Theme.of(context).textTheme.titleLarge),
                  const Text(
                    'Completed\n Workout',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
