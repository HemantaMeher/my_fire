import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_fire/AuthenticationScreen/userDetails.dart';
import 'package:my_fire/homeScreen.dart';

class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({Key? key}) : super(key: key);

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // get the credential
        AuthCredential credential = await GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        try {
          // use the credential to verify that email to login
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          var as = await FirebaseFirestore.instance
              .collection("user app")
              .doc("user app")
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
          if (as.exists == true) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreens(),
                ));
          } else {
            await FirebaseFirestore.instance
                .collection("user app")
                .doc("user app")
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'name': googleSignInAccount.displayName.toString(),
              'email id': googleSignInAccount.email.toString(),
              'profile pic': googleSignInAccount.photoUrl.toString(),
            }).then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalDetailsView(),
                    )));
          }
        } catch (e) {
          Get.showSnackbar(GetSnackBar(title: e.toString(),));
          print(e.toString());
          // final snacbar = SnackBar(content: Text(e.toString()));
          // ScaffoldMessenger.of(context).showSnackBar(snacbar);
        }
      } else {
        Get.showSnackbar(GetSnackBar(title: 'Not able to Sign In'));
        // final snackbar = SnackBar(content: Text('Not able to Sign In'));
        // ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(title: e.toString(),));
      // final snackbar = SnackBar(content: Text(e.toString()));
      // ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              googleSignIn(context);
            },
            child: Text('SignIn')),
      ),
    );
  }
}
