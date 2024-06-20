import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_health_menu/util/preUtils.dart';
import 'package:get/get.dart';

import '../firebase_options.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(PrefUtils());
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
