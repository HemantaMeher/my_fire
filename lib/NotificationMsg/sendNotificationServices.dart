//Send Not page function
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendNotificationServices {
  Future<void> sendNotification(
      String username,
      String messages,
      String imageurl,
      String id,
      List<String> fcm,
      String channel,
      String channelid,
      String groupname,) async {
    // var oppfcmid = "eh175EVOSIWsGp4Mlfo8J3:APA91bEzI4QfpAdDAsq00ez79-8trnyYTwPONZTYHXUdPlzf131KBkUk3Uxs_Ro_cN6QinkrSLxF5R-a45dQ2Z8pOSDloK4_u8peXcoW4_zATnN8_YPLXIGTyl1Ydgkd5tn8kMpUDCRL";
    var oppfcmid = "fgQ7MkhyRe64fKbe6P4Zpq:APA91bGbSP3CN5FQRys2LnOmh8Td5L1NYN2s5bMpfgMKDD_FyUT4oa0DGrGgeYh14q84JkozfbQclDJqgKxbEXCpdLFAxeUq0jYUW_2Gcce63zVYvJIBEpbAiptlP_VGtDmBKWuVYe3R";
    var payload = {
      'data': {
        "image": imageurl,
        "channel": channel,
        "channelid": channelid,
        "idofpost": groupname
      },
      'notification': {
        'title': username,
        'body': messages,
      },
      "android": {"sound": "sound_file"},
      'to': oppfcmid,
      // 'registration_ids': [oppfcmid],
      // "to":'/topics/Chats'
    };
    // String serverToken = 'AAAADkfRNAU:APA91bGYMntIzEGFpt2dg6mzNed71tRp_lVXENpwIlQKZToE4upBlx4Z1dACa5TtaKBuRQc2Ti5V6ypsFB1i9_Gqnv6pCEqLcXCBz6xM6YnqmYpHkZeTZw-gf-Luc9Zp9NEsANBlo5-B';//Firebase server token from clound message
    String serverToken = 'AAAAN56KMhk:APA91bHZMEDw1AYLjn7KeQw3V57lsMNIDNQEDb2A3bUDuVh3w3PySGp8GfVUiAcdHRs5iBWoIHiQPQlPGmghCL8swedBnstJ7oivwMNU5th8oAji22G_MBVcjaIz8XIA_N6Byncy7eWF';//Firebase server token from clound message
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    };

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: json.encode(payload),
    ).then((value) {
      print("Notification Sended ===============================>");
      print(value.body);
      print(value.headers);
      print(value.request?.method);
      print("Notification Sended ===============================>");
    });
  }
}