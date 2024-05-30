// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/screens.dart';
import 'package:get/get.dart';

import '../../widgets/noti_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> notiList = [
      '1',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: notiList.length,
          itemBuilder: (context, index) {
            final item = notiList[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.to(const DailyReportScreen());
                  },
                  child: DismissCard(
                    item: item,
                    onDismissed: (direction) {
                      setState(() {});
                    },
                    dismissKey: UniqueKey(),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DismissCard extends StatelessWidget {
  DismissCard({
    Key? key,
    required this.item,
    required this.dismissKey,
    required this.onDismissed,
  }) : super(key: key);

  final String item;
  void Function(DismissDirection) onDismissed;
  final Key dismissKey;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  'Mark as read',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          )),
      key: dismissKey,
      child: const NotiCard(),
      onDismissed: onDismissed,
    );
  }
}
