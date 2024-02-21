import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_fire/AuthenticationScreen/login.dart';
import 'package:my_fire/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'),),
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
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () async{
                    if(emailController.text.isNotEmpty && passController.text.isNotEmpty){
                      try{
                        var login = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text
                        );
                        print(login.user!.uid);
                        await FirebaseFirestore.instance.collection("EmailUsers").doc(login.user!.uid).set(
                          {
                            "email": emailController.text,
                            "pass": passController.text,
                            "date": DateTime.now()
                          }
                        );
                        // SharedPreferences pref = await SharedPreferences.getInstance();
                        // await pref.setBool('logstatus', true);
                        emailController.clear();
                        passController.clear();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreens(),));
                        setState(() {

                        });
                      } catch(e){
                        print(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: Text('SignUp')
              ),
              SizedBox(height: 20,),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
                  },
                  child: Text("Already have an account")
              )
            ],
          ),
        ),
      ),
    );
  }
}
