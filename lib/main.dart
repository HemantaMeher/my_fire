import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_fire/NotificationMsg/notificationServices.dart';
import 'package:my_fire/firebase_options.dart';
import 'package:my_fire/prestige/addProject.dart';

import 'AuthenticationScreen/googleSignIn.dart';
import 'AuthenticationScreen/login.dart';
import 'AuthenticationScreen/phoneAuthScreen.dart';
import 'AuthenticationScreen/signUp.dart';
import 'GoogleMapPractic/convertLatLongToAddress.dart';
import 'GoogleMapPractic/costomMarkerScreen.dart';
import 'GoogleMapPractic/customMarkerInfoWindow.dart';
import 'GoogleMapPractic/googleMapScreen.dart';
import 'GoogleMapPractic/polygoneScreen.dart';
import 'GoogleMapPractic/searchPlaceApiScreen.dart';
import 'GoogleMapPractic/userCurrentLocation.dart';
import 'NotificationMsg/awesomeLocalNotification.dart';
import 'NotificationMsg/sendNotificationPage.dart';
import 'RazorpayScreen/demoScreen.dart';
import 'arrayRemoveAndAdd.dart';
import 'demo.dart';
import 'demo2.dart';
import 'docSnapshot.dart';
import 'filterList.dart';
import 'fireSearch.dart';
import 'fireStorage.dart';
import 'fireStorageSunrule.dart';
import 'fireTodo.dart';
import 'firebaseCrud.dart';
import 'firebaseSearch.dart';
import 'formData.dart';
import 'homeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AwesomeNotifications().initialize(
      null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Channel',
        channelDescription: "Awesome Notification Example",
        importance: NotificationImportance.Max,
        enableVibration: true,
        defaultColor: Colors.redAccent,
        channelShowBadge: true,
        enableLights: true,
        // icon: 'resource://drawable/img',
        // playSound: true,
        // soundSource: 'resource://raw/nots'
    )
  ]
  );

  NotificationServices ns = NotificationServices();

  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.notification!.title);
    print(event.notification!.body);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: DemoScreensFire(),
    );
  }
}
