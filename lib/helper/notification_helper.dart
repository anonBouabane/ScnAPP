import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../util/app_constants.dart';
import 'route_helper.dart';

class NotificationHelper {
  @pragma('vm:entry-point')
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        new AndroidInitializationSettings('notification_icon');
    var iOSInitialize = new DarwinInitializationSettings();
    var initializationsSettings = new InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (NotificationResponse load) async {
      try {
        // Get.toNamed(RouteHelper.getNotificationRoute());
      } catch (e) {
        Logger().d("Notification Error:: ${e.toString()}");
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().d("json notification::: ${message.toMap()}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger().d(
          "onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        Get.toNamed(RouteHelper.getInitialRoute());
      } catch (e) {
        Logger().d("error-- : ${message.toMap()}");
      }
    });
  }

  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    if (!GetPlatform.isIOS) {
      String? title;
      String? body;
      String? image;

      title = message.notification!.title;
      body = message.notification!.body;

      if (GetPlatform.isAndroid) {
        image = (message.notification!.android!.imageUrl != null &&
                message.notification!.android!.imageUrl!.isNotEmpty)
            ? message.notification!.android!.imageUrl!.startsWith('http')
                ? message.notification!.android!.imageUrl
                : '${AppConstants.BASE_URL}/${message.notification!.android!.imageUrl}'
            : null;
      } else if (GetPlatform.isIOS) {
        image = (message.notification!.apple!.imageUrl != null &&
                message.notification!.apple!.imageUrl!.isNotEmpty)
            ? message.notification!.apple!.imageUrl!.startsWith('http')
                ? message.notification!.apple!.imageUrl
                : '${AppConstants.BASE_URL}/${message.notification!.apple!.imageUrl}'
            : null;
      }

      if (kDebugMode) {
        Logger().d("image fetch::: $image");
      }

      if (image != null && image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              title.toString(), body.toString(), image, fln);
        } catch (e) {
          await showBigTextNotification(title.toString(), body!, fln);
        }
      } else {
        await showBigTextNotification(title.toString(), body!, fln);
      }
    }
  }

  static Future<void> showTextNotification(
    String title,
    String body,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'null',
      'null',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics);
  }

  static Future<void> showBigTextNotification(
    String title,
    String body,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'null',
      'null',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
    String title,
    String body,
    String image,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    if (kDebugMode) {
      Logger().d("show image :: $image");
    }

    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    if (kDebugMode) {
      Logger().d("show image path :: $largeIconPath");
    }

    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'null',
      'null',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics);
  }

  static Future<String> _downloadAndSaveFile(
    String url,
    String fileName,
  ) async {
    if (kDebugMode) {
      Logger().d("image ob download:: $fileName");
    }

    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

@pragma('vm:entry-point')
Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    Logger().d(
        "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.android!.imageUrl}");
  }
}
