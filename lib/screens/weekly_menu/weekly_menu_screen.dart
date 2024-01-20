// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_health_menu/widgets/widgets.dart';

class WeeklyMenuScreen extends StatelessWidget {
  const WeeklyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Weekly menu',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MenuCalendar(),
              const SizedBox(height: 10),
              Container(
                height: 700,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 09),
                    ),
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 10),
                    ),
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 11),
                    ),
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 12),
                    ),
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 13),
                    ),
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 14),
                    ),
                    DailyMenuExpansion(
                      date: DateTime(2023, 10, 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
