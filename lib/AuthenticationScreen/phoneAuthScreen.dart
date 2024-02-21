//Phone Login
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_fire/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  //verifyOtp

  _verifyPhone() async {
    // verificationCompleted: Automatic handling of the SMS code on Android devices.
    // verificationFailed: Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
    // codeSent: Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
    // codeAutoRetrievalTimeout: Handle a timeout of when automatic SMS code handling fails.
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${8144034215}',
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            print(verficationID);
            _verificationCode = verficationID;
          });
          starttimer();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          showsnackbar("Time Out", context);
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  Future<void> signinWithPhonenumber(String verificationId, String smsCode,
      BuildContext context, String name, String phonenumber) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("loginstatus", true);
      print('========================> ${userCredential.user!.uid}');
      final User? user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;
      print(uid);
      var as =
      await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      if (as.exists) {
        Get.to(() => HomeScreens());
      } else {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'number': phonenumber,
          'image': "",
          'email': "",
          'verifier': 'false',
        });
        Get.to(HomeScreens());
      }
      showsnackbar("login successfully", context);
    } catch (e) {
      showsnackbar(e.toString(), context);
    }
  }

  void showsnackbar(text, BuildContext context) {
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  String? _verificationCode;
  TextEditingController otpController = TextEditingController();
  String code = "";
  String smsCode = "";
  bool resend = false;
  int start = 60;
  bool wait = false;
  void starttimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
      onsec,
          (timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            wait = false;
            resend = true;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () {
                  _verifyPhone();
                },
                child: Text("Send Otp")),
            Text("${start}",style: TextStyle(fontSize: 30),),
            TextField(controller: otpController,),
            FilledButton(
                onPressed: () {
                  signinWithPhonenumber(_verificationCode!, otpController.text, context, "Jk", "987654321");
                },
                child: Text("Verify Otp")),
          ],
        ),
      ),
    );
  }
}
