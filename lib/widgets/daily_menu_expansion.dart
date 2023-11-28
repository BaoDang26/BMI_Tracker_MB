import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets.dart';

class DailyMenuExpansion extends StatefulWidget {
  final DateTime date;

  const DailyMenuExpansion({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<DailyMenuExpansion> createState() => _DailyMenuExpansionState();
}

class _DailyMenuExpansionState extends State<DailyMenuExpansion> {
  @override
  Widget build(BuildContext context) {
    String convertedDate = DateFormat('EEEE, MMMM d').format(widget.date);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          convertedDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: const [
          RecipesRow(foods: []),
        ],
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
