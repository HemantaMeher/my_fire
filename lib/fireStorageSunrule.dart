//Firebase Storage and Image Picker

import 'dart:io';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fire/pdfViews.dart';
import 'package:my_fire/videoApp.dart';
import 'package:path/path.dart';

class FireStorageSunrule extends StatefulWidget {
  const FireStorageSunrule({Key? key}) : super(key: key);

  @override
  State<FireStorageSunrule> createState() => _FireStorageSunruleState();
}

class _FireStorageSunruleState extends State<FireStorageSunrule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: getImageCamera, child: Text("Camera Image Upload")),
            imageUrl.isEmpty
                ? SizedBox()
                : Image.network(
                    imageUrl,
                    height: 100,
                    width: 100,
                  ),
            FilledButton(
                onPressed: pickAadharImage, child: Text("Galary Image Upload")),
            aadhar.isEmpty
                ? SizedBox()
                : Image.network(
                    aadhar,
                    height: 100,
                    width: 100,
                  ),
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
                child: Text('Doc Upload')),
            FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => PdfViews(url: docUrl)));
                },
                child: Text("PdfView")),
          ],
        ),
      ),
    );
  }

  File? doc;
  String docUrl = "";
  File? imageFile;
  String imageUrl = "";
  Future getImageCamera() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.camera).then((xFile) async {
      if (xFile != null) {
        print(xFile.path);
        imageFile = File(xFile.path);
        var ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child("${imageFile}.jpg");
        // .child("${xFile.name}.jpg");

        var uploadTask = await ref.putFile(imageFile!);
        imageUrl = await uploadTask.ref.getDownloadURL();
        print(imageUrl);
        setState(() {});
      }
    });
  }

  String aadharFilePath = "";
  File? imageAadhar;
  String aadhar = "";
  Future pickAadharImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      // print("imageTemp ====? ${imageTemp}");
      aadharFilePath = basename(imageTemp.path);
      // print("aadharFilePath ====? ${aadharFilePath}");
      setState(() => this.imageAadhar = imageTemp);
      // Create a storage reference from our app
      final storageRef = FirebaseStorage.instance.ref();
      // Create a reference to "mountains.jpg"
      final mountainImagesRef =
          storageRef.child("AdminAadharImage/$aadharFilePath");
      await mountainImagesRef.putFile(imageTemp);
      String aadharurl = await mountainImagesRef.getDownloadURL();
      print(aadharurl);
      setState(() {
        aadhar = aadharurl;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
