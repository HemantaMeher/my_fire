import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ArrayRemoveAndAdd extends StatefulWidget {
  const ArrayRemoveAndAdd({Key? key}) : super(key: key);

  @override
  State<ArrayRemoveAndAdd> createState() => _ArrayRemoveAndAddState();
}

class _ArrayRemoveAndAddState extends State<ArrayRemoveAndAdd> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Array Operation',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          /*await FirebaseFirestore.instance.collection('ArrayOpe').doc("FirstOpe").set(
              {
                "name": "Hemanta",
                "roll": "21Mca07"
              },
          );*/
          /*await FirebaseFirestore.instance.collection('ArrayOpe').doc("FirstOpe").set(
            {
              "age": 23,
              "Village": "Kardola"
            },SetOptions(merge: true)
          );*/
          /*await FirebaseFirestore.instance.collection('ArrayOpe').doc("List").set(
              {
                "list": FieldValue.arrayUnion([5])
              },SetOptions(merge: true)
          );*/
          /*await FirebaseFirestore.instance.collection('ArrayOpe').doc("List").set(
              {
                "list": FieldValue.arrayRemove([3])
              },SetOptions(merge: true)
          );*/
          /*var get = await FirebaseFirestore.instance.collection('ArrayOpe').doc("List").get();
          var el = [];
          el = get["list"];
          el.removeLast();
          el.removeAt(0);
          el.add(10);
          el.add(20);
          el.add(30);
          await FirebaseFirestore.instance.collection('ArrayOpe').doc("List").set(
              {
                "list": el
              },SetOptions(merge: true)
          );
          print(el);*/


        },
        child: Icon(Icons.send_and_archive_outlined),
      ),
    );
  }
}
