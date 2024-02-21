import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class AwsomeLocalNotification extends StatefulWidget {
  const AwsomeLocalNotification({Key? key}) : super(key: key);

  @override
  State<AwsomeLocalNotification> createState() => _AwsomeLocalNotificationState();
}

class _AwsomeLocalNotificationState extends State<AwsomeLocalNotification> {

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void triggernotification() async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: "basic_channel",
          title: "Awesome Notification",
          body: "Awesome notification from flutter Training",
          summary: "jdsjksa ijak afjsfakj aka jkd",
          bigPicture: "",
          roundedLargeIcon: true,
          largeIcon: "https://images.unsplash.com/photo-1586348943529-beaae6c28db9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
          // notificationLayout: NotificationLayout.Inbox,
          notificationLayout: NotificationLayout.ProgressBar,
        )
    );
  }

  void bigpicturenotification()async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: "basic_channel",
            title: "Awesome Notification",
            body: "Awesome notification for flutter traning",
            summary: "ajdhsj ad nja jan ldahui dn",
            bigPicture: "https://images.unsplash.com/photo-1586348943529-beaae6c28db9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
            notificationLayout: NotificationLayout.BigPicture,
            fullScreenIntent: true
        )
    );
  }


  void scheduleNotification() async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: "basic_channel",
          title: "Simple Notification",
          body: "Simple Notification body",
          bigPicture: "https://images.unsplash.com/photo-1586348943529-beaae6c28db9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
          notificationLayout: NotificationLayout.ProgressBar,
        ),
        schedule: NotificationCalendar.fromDate(
          date: DateTime.now().add(const Duration(seconds: 5)),
          preciseAlarm: true,
          allowWhileIdle: true,
          repeats: true,
        )
    );
  }

  void demoNotification()async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 5,
          channelKey: "basic_channel",
          title: "Awesome Notification",
          body: "Awesome notification for flutter traning",
          summary: "ajdhsj ad nja jan ldahui dn",
          bigPicture: "https://images.unsplash.com/photo-1586348943529-beaae6c28db9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
          notificationLayout: NotificationLayout.BigPicture,
          actionType: ActionType.KeepOnTop,
          // notificationLayout: NotificationLayout.Inbox,
          // notificationLayout: NotificationLayout.BigPicture,
          displayOnForeground: true,
          displayOnBackground: true,
          roundedLargeIcon: true,
          fullScreenIntent: true,
          backgroundColor: Colors.pinkAccent,
          color: Colors.yellowAccent,
          wakeUpScreen: false,
          showWhen: true,
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awsome Notification'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: triggernotification,
                child: Text('Trigger Notification')
            ),
            ElevatedButton(
                onPressed: bigpicturenotification,
                child: Text('Big picture notification')
            ),
            ElevatedButton(
                onPressed: scheduleNotification,
                child: Text('Schedule notification')
            ),
            ElevatedButton(
                onPressed: demoNotification,
                child: Text('Demo notification')
            ),
            ElevatedButton(
                onPressed: () async{
                  await FirebaseMessaging.instance.getToken().then((value) => print(value));
                },
                child: Text('Fire FCM')
            ),
          ],
        ),
      ),
    );
  }
}
