import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scn_easy/controller/localization_controller.dart';
import 'package:scn_easy/helper/route_helper.dart';
import 'package:scn_easy/theme/dark_theme.dart';
import 'package:scn_easy/theme/light_theme.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:scn_easy/util/messages.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controller/auth_controller.dart';
import 'controller/theme_controller.dart';
import 'helper/get_di.dart' as di;
import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  if (GetPlatform.isMobile) {
    HttpOverrides.global = new MyHttpOverrides();
  }

  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  await Firebase.initializeApp();

  Map<String, Map<String, String>> _languages = await di.init();
  try {
    if (GetPlatform.isMobile) {
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}

  await GetStorage.init();

  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  MyApp({required this.languages});

  void _route() {
    /// bypass function but request token from backend
    // Get.find<AuthController>().authRepo.setUserPhone('96353425');
    // Get.find<AuthController>().authRepo.saveUserToken(
    //     'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTb21jaGF5bnVlayBMb3R0ZXJ5IiwiaWF0IjoiMTIvMjcvMjAyMyA0OjE2OjUz4oCvQU0iLCJVc2VySWQiOiIzMzE4IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQ3VzdG9tZXJzIiwiZXhwIjoxNzExNDI2NjE1LCJpc3MiOiJTVkVORy5JVC5Tb2x1dGlvbnMiLCJhdWQiOiJTb2t4YXkgSVQgRGV2In0.7T5IKe3T2zdt-rzQ8EWrk9KT41NTfZzmEy-sVF9zV4NkFLDAldB48k8bpWGovYKfmnGvCoKwxnqix867eD6iJQ');
    /// end bypass function

    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<AuthController>().updateToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    _route();
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: ScreenUtilInit(builder: (_, __) {
            return GetMaterialApp(
              title: AppConstants.APP_NAME,
              debugShowCheckedModeBanner: kDebugMode,
              navigatorKey: Get.key,
              scrollBehavior: MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
              ),
              theme: themeController.darkTheme
                  ? themeController.darkColor == null
                      ? dark()
                      : dark(color: themeController.darkColor!)
                  : themeController.lightColor == null
                      ? light()
                      : light(color: themeController.lightColor!),
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                  AppConstants.languages[0].countryCode),
              initialRoute: Get.find<AuthController>().isLoggedIn()
                  ? RouteHelper.getDashboardRoute()
                  : RouteHelper.getSplashRoute(),
              getPages: RouteHelper.routes,
              defaultTransition: Transition.topLevel,
              transitionDuration: Duration(milliseconds: 500),
            );
          }),
        );
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
