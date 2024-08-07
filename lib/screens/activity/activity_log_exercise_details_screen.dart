import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_health_menu/controllers/activity_log_controller.dart';
import 'package:flutter_health_menu/controllers/activity_log_exercise_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityLogExerciseDetailsScreen
    extends GetView<ActivityLogExerciseController> {
  const ActivityLogExerciseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(appTheme.green500),
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Exercise Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(() {
          // Check the loading state
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 400.v,
                    margin: EdgeInsets.symmetric(vertical: 10.v),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //! photo
                      image: DecorationImage(
                        image: NetworkImage(controller
                                .exerciseModel.value.exercisePhoto ??
                            'https://i.ytimg.com/vi/XowvxiGYsRI/maxresdefault.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //! Name
                  Text(
                    '${controller.exerciseModel.value.exerciseName}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Met: ${controller.exerciseModel.value.met}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://www.healthline.com/health/what-are-mets'));
                        },
                        child: Text(
                          'Concept',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    // fontSize: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Chip(
                        label: Text(controller.exerciseModel.value.tagName ??
                            'Unknown'),
                        backgroundColor: Colors.lightGreenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.v),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        controller.exerciseModel.value.exerciseDescription ??
                            'This is the notes!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Link processing video',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              controller.exerciseModel.value.exerciseVideo!));
                        },
                        child: Text(
                          'Video Link',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    // fontSize: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
