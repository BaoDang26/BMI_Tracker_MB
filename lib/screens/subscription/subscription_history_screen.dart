import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/subscription_history_controller.dart';
import 'package:flutter_health_menu/screens/subscription/widget/subscription_item_widget.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class SubscriptionHistoryScreen extends GetView<SubscriptionHistoryController> {
  const SubscriptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the loading state
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(1),
          body: const Center(
            child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.lightGreenAccent),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Subscription History',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Obx(() {
          if (controller.subscriptionModels.isEmpty) {
            return const Center(
              child: Text('No subscription found.'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  left: 15.h, top: 10.v, right: 15.h, bottom: 20.v),
              child: Obx(
                () => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.v);
                  },
                  itemCount: controller.subscriptionModels.length,
                  itemBuilder: (context, index) {
                    return SubscriptionItemWidget(index);
                  },
                ),
              ),
            );
          }
        }),
      );
    });
  }
}
