import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class FireStorage extends StatefulWidget {
  const FireStorage({Key? key}) : super(key: key);

  @override
  State<FireStorage> createState() => _FireStorageState();
}

class _FireStorageState extends State<FireStorage> {
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Storage'),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            IconButton(
                onPressed: () async{

                  /*
                  * Step 1. Pick/Capture an inage   (image_picker)
                  * Step 2. Upload the image to the Firebase Storage
                  * Step 3. Get the URL of the uploded image
                  * Step 4. Store the image URL inside the corrosponding document of the database
                  * Step 5, Display the image on the list
                  * */

                //  Step 1: Pick Image
                  ImagePicker imagePiecker = ImagePicker();
                  XFile? file = await imagePiecker.pickImage(source: ImageSource.camera);
                  print('${file?.path}');

                  if(file==null) return;

                  String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

                //  Step 2. Upload to Firebase Storage
                //  Get a reference to storage root
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');

                //  Create a reference for the image to be stored
                  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                //  Handle error/Success
                  try{
                    //  Store the file
                    await referenceImageToUpload.putFile((File(file!.path)));
                  //  Success: get the download url
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    print(imageUrl);
                  }catch(error){
                  //  Some error occurred
                  }



                },
                icon: Icon(Icons.camera_alt,size: 50,color: Colors.cyan,)
            )
          ],
        ),
      ),
    );
  }
}
