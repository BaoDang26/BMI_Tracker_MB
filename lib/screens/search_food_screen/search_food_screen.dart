import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/search_food_controller.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/widgets/custom_text_form_field.dart';

class SearchFoodScreen extends GetView<SearchFoodController> {
  const SearchFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Results"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(

                ),
                Container(
                  color: Colors.amberAccent,
                  padding: EdgeInsets.only(top: 10 ),
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
