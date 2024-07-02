import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/advisor_booking_details_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';

import '../../widgets/widgets.dart';

class AdvisorBookingDetailsScreen
    extends GetView<AdvisorBookingDetailsController> {
  AdvisorBookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return const Center(
          child:
              CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
        );
      }
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.getBack();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: Column(
          children: [
            Obx(
              () => Container(
                height: 260.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  image: DecorationImage(
                    image: NetworkImage(
                      "${controller.advisorDetailsModel.value.accountPhoto}",
                      // 'https://www.avatarfitness.co.uk/wp-content/uploads/Jacob-pdf.jpg'
                    ),
                    fit: BoxFit.cover,
                  ),
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
                          Obx(
                            () => Text(
                              "${controller.advisorDetailsModel.value.fullName}",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          // Text(
                          //   'Fitness Instructor',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .bodyMedium!
                          //       .copyWith(color: Colors.grey),
                          // )
                        ],
                      ),
                      // book now button
                      FilledButton(
                        onPressed: () {
                          controller.goToMessaging();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Messaging'),
                      )
                    ],
                  ),
                  // advisor information
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.v),
                    child: const AdvisorInfoCard(),
                  ),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: SizedBox(
                  //     height: 100,
                  //     child: ListView.builder(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: blogController.currentBlog.length,
                  //       itemBuilder: (context, index) {
                  //         return Row(
                  //           children: [
                  //             Container(
                  //               width: 90,
                  //               decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                   image: NetworkImage(
                  //                       '${blogController.currentBlog[index].blogPhoto}'),
                  //                   // '${viewBlog.blogPhoto}'),
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //             ),
                  //             const SizedBox(width: 10),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
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
                      // Get.to(const FeedbackScreen());
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
    });
  }
}

class AdvisorInfoCard extends StatefulWidget {
  const AdvisorInfoCard({
    super.key,
  });

  @override
  State<AdvisorInfoCard> createState() => _AdvisorInfoCardState();
}

class _AdvisorInfoCardState extends State<AdvisorInfoCard> {
  var controller = Get.find<AdvisorBookingDetailsController>();

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
                  Text("${controller.advisorDetailsModel.value.totalBooking}",
                      style: Theme.of(context).textTheme.titleLarge),
                  const Text(
                    'Total Bookings',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 1.h,
              height: 55.v,
              color: Colors.black,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${controller.advisorDetailsModel.value.totalMenuCreated}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    'Menus Created',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 1.h,
              height: 55.v,
              color: Colors.black,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                      "${controller.advisorDetailsModel.value.totalMenuCreated}",
                      style: Theme.of(context).textTheme.titleLarge),
                  const Text(
                    'Workouts Created',
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
