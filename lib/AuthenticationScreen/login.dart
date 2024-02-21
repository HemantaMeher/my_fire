import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_fire/AuthenticationScreen/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fireSearch.dart';
import '../homeScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  void check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? c = await pref.getBool('logstatus');
    if (c == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreens(),
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
                      try {
                        var login = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreens(),
                                )));
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.setBool('logstatus', true);
                        emailController.clear();
                        passController.clear();
                      } catch (e) {
                        print(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please Fill the above fields')));
                    }
                  },
                  child: Text('LogIn')),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                  child: Text("Create an account"))
            ],
          ),
        ),
      ),
    );
  }
}
