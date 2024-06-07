import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/config/constants.dart';
import 'package:flutter_health_menu/config/theme.dart';
import 'package:flutter_health_menu/screens/home/empty_screen.dart';
import 'package:flutter_health_menu/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_health_menu/screens/register/rergister_info_screen.dart';
import 'package:flutter_health_menu/screens/screens.dart';
import 'package:flutter_health_menu/screens/service_package/payment_results/success_screen.dart';
import 'package:flutter_health_menu/util/initial_bindings.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..autoEstablishSocketConnection = true
          ..region = "IN" //Replace with your region
          ..appId = cometAppId //replace with your app Id
          ..authKey = cometAuthKey
          ..extensions = CometChatUIKitChatExtensions
              .getDefaultExtensions() //replace this with empty array you want to disable all extensions
        ) //replace with your auth Key
        .build();

    CometChatUIKit.init(
        uiKitSettings: uiKitSettings,
        onSuccess: (String successMessage) {
          debugPrint("Initialization completed successfully  $successMessage");
        },
        onError: (CometChatException e) {
          debugPrint("Initialization failed with exception: ${e.message}");
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialBinding: InitialBindings(),
      home: OnboardingScreen(),
      // home:   EmpTyScreen(),
    );
  }
}
