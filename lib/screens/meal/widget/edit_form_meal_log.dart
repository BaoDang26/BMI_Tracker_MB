import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:numberpicker/numberpicker.dart';

class EditFormMealLog extends StatefulWidget {
  @override
  _EditFormMealLogState createState() => _EditFormMealLogState();
}

class _EditFormMealLogState extends State<EditFormMealLog> {
  int _currentValue = 1;
  String _selectedUnit = 'Serving (30 g)';
  List<String> _units = [
    'Serving (30 g)',
    'Cup (150 g)',
    'Package (150 g)',
    'Gram'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Entry'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: NumberPicker(
                    value: _currentValue,
                    minValue: 1,
                    maxValue: 100,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedUnit,
                    items: _units.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedUnit = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle "Add" button press
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
