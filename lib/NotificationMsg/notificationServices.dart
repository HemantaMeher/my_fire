//localnot
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../DemoScreens/appbarscreen.dart';
import '../DemoScreens/containerscreen.dart';
import '../DemoScreens/safeareascreen.dart';

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onBackgroundMessage((message) => showNotification(message));
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        showNotification(message);
      }
    });
  }
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }
  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    final FlutterLocalNotificationsPlugin _localNotifications =
    FlutterLocalNotificationsPlugin();
    print(message.data['image']);
    final largeIconPath =
    await getdownloadFile(message.data['image'], "largeIcon");
    final bigPicturePath =
    await getdownloadFile(message.data['image'], "bigPicturePath");

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('not'));

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id.toString(), channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      sound: channel.sound,
      actions: [
        AndroidNotificationAction(
          message.data['channelid'],
          "Read More",
        ),  AndroidNotificationAction(
          message.data['channelid'],
          "Subscribe",
        ),
      ],
      fullScreenIntent: true,
      styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath)),
      category: AndroidNotificationCategory.event,
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          print("OnTap Dunctions");
          print(notificationResponse.id);
          print(notificationResponse.payload);
          print(notificationResponse.actionId);
          print(notificationResponse.input);

          if (notificationResponse.id == 0) {
            print("Select 1");
            var details = await FirebaseFirestore.instance
                .collection("Jobs")
                .doc(message.data['idofpost'])
                .get();
            Get.to(() => SafeAreaScreen());
          } else if (notificationResponse.id == 1) {
            print("Select 2");
            var details = await FirebaseFirestore.instance
                .collection("News")
                .doc(message.data['idofpost'])
                .get();
            Get.to(() => AppBarScreen(), arguments: details);
            print("Remove");
          } else if (notificationResponse.id == 2) {
            Get.to(
                  () => ContainerScreen(),
            );
          } else {
            print("None");
          }
        });
    if (message.data['channelid'] == "0") {
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      });
    } else if (message.data['channelid'] == "1") {
           Get.snackbar("Hiiiiiii", "Notification Showing");
      // Get.dialog(Dialog(child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Text("Hiiiii"),
      //     FlutterLogo(size: 39,),
      //   ],
      // ),));
      // Get.bottomSheet(Container(
      //   height: 200,
      //   width: 200,
      //   color: Colors.green.shade50,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text("Hiiiii"),
      //       FlutterLogo(size: 39,),
      //     ],
      //   ),
      // ),);
/*      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      });*/
    } else if (message.data['channelid'] == "2") {
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          2,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      });
    }
  }
  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }
  void updateToken() async {
    messaging.getToken().then((value) async {
      await FirebaseFirestore.instance
          .collection("USERS")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"fcmToken": value});
    });
  }
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }
  static Future<String> getdownloadFile(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filepath = "${directory.path}/$filename";
    final response = await http.get(Uri.parse(url));
    final file = File(filepath);
    await file.writeAsBytes(response.bodyBytes);
    return filepath;
  }
}

