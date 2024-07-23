import 'package:flutter_health_menu/models/tag_model.dart';
import 'package:flutter_health_menu/models/tag_type_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';

class FilterExerciseController extends GetxController{
  RxList<TagTypeModel> tagTypeModels = RxList.empty();
  RxList<TagModel> tagChecked = RxList.empty();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void toFilterTagFood() {}
}