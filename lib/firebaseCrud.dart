import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({Key? key}) : super(key: key);

  @override
  State<FirebaseCrud> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection("NewOne")
                        .doc("One")
                        .set({
                      "Strin": "String",
                      "Num": '12345',
                      "Bol": true,
                      "Lst": ['Hemanta', 'Meher', '23'],
                      "Mp": {'h', 'e', 'm', 'a', 'n', 't', 'a'},
                      "LM": [
                        {"a": "apple", "b": "Ball"}
                      ],
                      "DT": DateTime.now(),
                    }).then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Succss"))));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text('Create')),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async{
              var getData = await FirebaseFirestore.instance.collection("NewOne").doc("One").get();
              print(getData["Strin"]);
              print(getData["Num"]);
              print(getData["Bol"]);
              print(getData["Lst"]);
              print(getData["Mp"]);
              print(getData["LM"]);
              print(getData["DT"]);

            }, child: Text('Read')),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {
              await FirebaseFirestore.instance.collection("NewOne").doc("One").update(
                {
                  "Strin" : "Kardola",
                  "Num" : 8144
                }
              );
            }, child: Text('Update')),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {
              await FirebaseFirestore.instance.collection("NewOne").doc("One").delete().then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted"))));
            }, child: Text('Delete'))
          ],
        ),
      ),
    );
  }
}
