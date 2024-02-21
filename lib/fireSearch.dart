import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class FireSearch extends StatefulWidget {
  const FireSearch({Key? key}) : super(key: key);

  @override
  State<FireSearch> createState() => _FireSearchState();
}

String search = '';

class _FireSearchState extends State<FireSearch> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            suffix: IconButton(
                onPressed: () {
                  setState(() {
                    controller.clear();
                  });
                },
                icon: Icon(Icons.clear)
            ),
          ),
          controller: controller,
          onChanged: (value) {
            setState(() {

            });
            print(search);
          },
        ),
      ),
      body: controller.text.isEmpty?
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder: (context, snapshot) {
              int length  = snapshot.data!.docs.length;
              return ListView.builder(
                itemCount: length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.docs[index]['name']),
                    subtitle: Text(snapshot.data!.docs[index]['number'].toString()),
                  );
                },
              );
            },
          )
          : StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          int length = snapshot.data!.docs.length;
          return ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              if(snapshot.data!.docs[index]["name"]
              .toString()
              .toLowerCase()
              .contains(controller.text.toLowerCase()) || snapshot.data!.docs[index]['number']
              .toString()
              .toLowerCase()
              .contains(controller.text.toLowerCase())
              ){
                return ListTile(
                  title: Text(snapshot.data!.docs[index]['name']),
                  subtitle: Text(snapshot.data!.docs[index]['number'].toString()),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
