import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../homeScreen.dart';


class PersonalDetailsView extends GetView {
  PersonalDetailsView({Key? key}) : super(key: key);

  TextEditingController fullName = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController location = TextEditingController();

  void sandPersonalData() async{
    await FirebaseFirestore.instance
        .collection("user app")
        .doc("user app")
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'email id': emailId.text.toString(),
      'location': location.text.toString(),
      'name': fullName.text.toString(),
      'phone number': phoneNumber.text.toString(),
    }).then((value) {
      Get.offAll(HomeScreens());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B458C),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 184,
                width: 400,
                // color: Colors.purple,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/hrit.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 170,),
                    Container(
                      width: double.infinity,
                      height: 600,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(33),topRight: Radius.circular(33))
                      ),

                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 36,),
                            Text("Personal Details",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600,color: Color(0xff0B458C)),),
                            SizedBox(height: 5,),
                            Text("Kindly add your personal details to continue",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Color(0xff588DCF)),),

                            SizedBox(height: 40,),


                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("         Full name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff0B458C)),)
                            ),
                            Container(
                              width: 315,
                              height: 34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE1EEFF),
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                controller: fullName,
                                decoration: InputDecoration(
                                    hintText: "Full name",
                                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Color(0xff838396)),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),


                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("         Email id",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff0B458C)),)
                            ),
                            Container(
                              width: 315,
                              height: 34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE1EEFF),
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                controller: emailId,
                                decoration: InputDecoration(
                                    hintText: "Userxxxxxxx@gmail.com",
                                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Color(0xff838396)),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),


                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("         Phone number",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff0B458C)),)
                            ),
                            Container(
                              width: 315,
                              height: 34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE1EEFF),
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                controller: phoneNumber,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "+91 8190XXXXXX",
                                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Color(0xff838396)),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),


                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("         Location",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff0B458C)),)
                            ),
                            Container(
                              width: 315,
                              height: 34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE1EEFF),
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 2
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                controller: location,
                                decoration: InputDecoration(
                                    hintText: "xxxxxxxxBengaluru, India",
                                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Color(0xff838396)),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),

                            SizedBox(
                              width: 300,
                              height: 42,
                              child: ElevatedButton(
                                onPressed: (){
                                  sandPersonalData();
                                  // Get.offAll(HomeScreens());
                                },
                                child: Text("Continue",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),),
                                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff0B458C)),
                              ),
                            )

                          ],
                        ),
                      ),

                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
