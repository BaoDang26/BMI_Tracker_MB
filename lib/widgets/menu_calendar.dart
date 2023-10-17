import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MenuCalendar extends StatelessWidget {
  const MenuCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      rangeStartDay: DateTime.utc(2023, 10, 16),
      rangeEndDay: DateTime.utc(2023, 10, 22),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Colors.white)),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          leftChevronIcon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          )),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
