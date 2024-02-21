import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocumentSnapshotTuterial extends StatefulWidget {
  const DocumentSnapshotTuterial({Key? key}) : super(key: key);

  @override
  State<DocumentSnapshotTuterial> createState() => _DocumentSnapshotTuterialState();
}

class _DocumentSnapshotTuterialState extends State<DocumentSnapshotTuterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade200,
        title: Text('Document snapshot'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await FirebaseFirestore.instance.collection("DocSnap").doc("One").set(
            {
              "name": "Mahendra",
              "Age": "-20"
            }
          );
        },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("DocSnap").doc("One").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data;
            return ListTile(
              leading: CircleAvatar(),
              title: Text(data!["name"]),
              subtitle: Text(data!["Age"]),
            );
          } else if(snapshot.hasError){
            return Text("Error");
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}
