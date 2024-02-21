//Send Not Ui
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_fire/NotificationMsg/sendNotificationServices.dart';

import 'notificationServices.dart';

class SendNotificatioPage extends StatefulWidget {
  const SendNotificatioPage({Key? key}) : super(key: key);

  @override
  State<SendNotificatioPage> createState() => _SendNotificatioPageState();
}

class _SendNotificatioPageState extends State<SendNotificatioPage> {
  SendNotificationServices sendNotificationServices =
  SendNotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ns.requestNotificationPermission();
    ns.firebaseInit(context);
  }

  NotificationServices ns = NotificationServices();
  void initnot(BuildContext context) {
    // ns.showNotification(message)
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              child: Text("Send Notification"),
              onPressed: () async {
                String image =
                    "https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
                sendNotificationServices.sendNotification(
                    "HM", "Hiii Hello", image, "0", [], "news", "1", "Test");
              },
            ),
            FilledButton(
              child: Text("Get Fcm"),
              onPressed: () async {
                FirebaseMessaging.instance
                    .getToken()
                    .then((value) => print(value));
              },
            ),
            FilledButton(
              child: Text("Subcribe"),
              onPressed: () async {
                FirebaseMessaging.instance
                    .subscribeToTopic("Chats")
                    .then((value) => print("Subscribed Successfully"));
              },
            ),
            FilledButton(
              child: Text("Unsubscribe"),
              onPressed: () async {
                FirebaseMessaging.instance
                    .unsubscribeFromTopic("Chats")
                    .then((value) => print("UnSubscribed Successfully"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
