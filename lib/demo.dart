
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_fire/videoApp.dart';


class DemoScreensFire extends StatefulWidget {
  const DemoScreensFire({Key? key}) : super(key: key);

  @override
  State<DemoScreensFire> createState() => _DemoScreensFireState();
}

class _DemoScreensFireState extends State<DemoScreensFire> {

  File? doc;
  String docUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    PlatformFile file = result.files.first;
                    doc = File(file.path!);
                    print(file.name);
                    print(file.bytes);
                    print(file.size);
                    print(file.extension);
                    print(file.path);
                    var ref = FirebaseStorage.instance
                        .ref()
                        .child('images')
                        .child("document/${file.name}");
                    var uploadTask = await ref.putFile(doc!);
                    docUrl = await uploadTask.ref.getDownloadURL();
                    print(docUrl);
                  } else {
                    //  user cancel the picker
                  }
                },
                child: Text('DocUpload')),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () {
                  Get.to(VideoApp(url: docUrl,));
                },
                child: Text("Show Vdo")
            )
          ],
        ),
      ),
    );
  }
}
