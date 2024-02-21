import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class AddProjectView extends StatefulWidget {
  AddProjectView({Key? key}) : super(key: key);

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {

  String pId = '';

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch user data from API using BuildContext
  //   pId = DateTime.now().microsecondsSinceEpoch.toString();
  // }


  TextEditingController projectTitleController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController projectTypeController = TextEditingController();

  TextEditingController contactNumberController = TextEditingController();

  TextEditingController priceRangeController = TextEditingController();

  TextEditingController aboutPropertyController = TextEditingController();

  TextEditingController addFeaturesTitleController = TextEditingController();

  TextEditingController addFeaturesDescriptionController = TextEditingController();

  TextEditingController rearNumberController = TextEditingController();

  TextEditingController developmentSiteAreaController = TextEditingController();

  File? doc;

  String pDocUrl1 = '';
  String pDocUrl2 = '';
  String pDocUrl3 = '';

  String pDocName1 = '';
  String pDocName2 = '';
  String pDocName3 = '';

  String pBroUrl1 = '';
  String pBroUrl2 = '';
  String pBroUrl3 = '';

  String pBroName1 = '';
  String pBroName2 = '';
  String pBroName3 = '';

  TextEditingController? broController1;
  TextEditingController? broController2;
  TextEditingController? broController3;

  List images = [];


  Map amenities = {
    "Badminton Court" : "unselect",
    "Table Tennis" : "unselect",
    "Basketball Court" : "unselect",
    "Tennis Court" : "unselect",
    "Gymnasium" : "unselect",
    "O.A.T" : "unselect",
    "Health Club" : "unselect",
    "Seating Area" : "unselect",
    "Multipurpose Hall" : "unselect",
    "Convention Center" : "unselect",
    "Cricket Pitch" : "unselect",
    "Swimming Pool" : "unselect",
    "Football Court" : "unselect",
  };
  List prjt1Img = [
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt2Img = [
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt3Img = [
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg",
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png"
  ];
  List prjt4Img = [
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt5Img = [
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt6Img = [
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt7Img = [
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt8Img = [
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg",
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png"
  ];
  List prjt9Img = [
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];
  List prjt10Img = [
    "https://static.360realtors.ws/properties/photos/5201/mini/primrose67.png",
    "https://www.homznspace.com/wp-content/uploads/2020/06/Main-A-Prestige-Primrose-Hills-Banashankari.jpg",
    "https://mediacdn.99acres.com/media1/21915/2/438302890M-1691413409146.jpg"
  ];


  void addProject() async{
     await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc(pId).set(
         {
           "about property": aboutPropertyController.text,
           "amenities": amenities,
           "available status": "",
           "brochures": [
             {
               "brochure link": pBroUrl1,
               "title": pBroName1,
             },
             {
               "brochure link": pBroUrl2,
               "title": pBroName2,
             },
             {
               "brochure link": pBroUrl3,
               "title": pBroName3,
             },
           ],
           "contact number": contactNumberController.text,
           "date added": DateTime.now(),
           "documents": [
             {
               "document link": pDocUrl1,
               "title": pDocName1,
             },
             {
               "document link": pDocUrl2,
               "title": pDocName2,
             },
             {
               "document link": pDocUrl3,
               "title": pDocName3,
             }
           ],
           "favourites list": [],
           /*"features": [
             {
               "description":"",
               "title": "",
             }
           ],*/
           "features": [
             {
               "description":"RCC Structure\n\nCement blocks for walls wherever needed",
               "title": "Structure",
             },
             {
               "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
               "title": "Lobby",
             },
             {
               "description":"Lifts of suitable size and capacity will be provided in all Towers",
               "title": "Lift",
             },
             {
               "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
               "title": "Apartment Flooring",
             },
             {
               "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
               "title": "Kitchen",
             },
             {
               "description":"Toilet",
               "title": "Toilet",
             },
             {
               "description":"Internal Doors",
               "title": "Internal Doors",
             },
             {
               "description":"External Doors & Windows",
               "title": "External Doors & Windows",
             },
             {
               "description":"Painting",
               "title": "Painting",
             },
             {
               "description":"Electrical",
               "title": "Electrical",
             },
             {
               "description":"Security System",
               "title": "Security System",
             },
             {
               "description":"DG Power",
               "title": "DG Power",
             },
           ],
           "images": images,
           "interested list": [],
           "location": locationController.text,
           "map location":"",
           "price range starting": priceRangeController.text,
           "project title": projectTitleController.text,
           "project type": projectTypeController.text,
           "rera number": rearNumberController.text,
           "site area": developmentSiteAreaController.text
         }, SetOptions(merge: true)
     );
   }

  void addProject1() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc(pId).set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt1Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "Prestige Elm Park",
          "project type": "Apartments",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }

  void addProject2() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt2").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt2Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "HPrestige Elm Park",
          "project type": "Apartments",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject3() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt3").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt3Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "Prestige Elm Park",
          "project type": "Apartments",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject4() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt4").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt4Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "EPrestige Elm Park",
          "project type": "Apartments",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject5() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt5").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt5Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "Prestige Elm Park",
          "project type": "Villas",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject6() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt6").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt1Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "MPrestige Elm Park",
          "project type": "Villas",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject7() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt7").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt2Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "APrestige Elm Park",
          "project type": "Villas",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject8() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt8").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt3Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "Prestige Elm Park",
          "project type": "Plots",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject9() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt9").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt4Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "NPrestige Elm Park",
          "project type": "Plots",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }
  void addProject10() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app").collection("projects").doc("prjt10").set(
        {
          "about property": "Located in the Banashankari neighbourhood of South Bengaluru, Prestige Primose Hills is a residential community that offers a serene, high quality lifestyle which is in perfect harmony with your preferences and expectations. You have a choice of one and two bedroom homes set in 13 towers that are spread across an expansive 15 acre site. Read More",
          "amenities": amenities,
          "available status": "62",
          "brochures": [
            {
              "brochure link": "https://www.prestigeprimrosehills.newlaunch.sale/#",
              "title": "Download Prestige Primrose Hills Brochure",
            },
          ],
          "contact number": "+918144034215",
          "date added": "",
          "documents": [
            {
              "document link": "",
              "title": "",
            },
          ],
          "favourites list": [],

          "features": [
            {
              "description":"RCC Structure\n\nCement blocks for walls wherever needed",
              "title": "Structure",
            },
            {
              "description":"Elegant lobby flooring in ground floor\n\nBasement and upper floor lobby flooring in vitrified tiles\n\nLift cladding in marble / granite as per architect’s design\n\nService staircase and service lobby in KOTA Stone / cement tiles\n\nAll lobby walls will be finished with texture paint and ceilings in distemper",
              "title": "Lobby",
            },
            {
              "description":"Lifts of suitable size and capacity will be provided in all Towers",
              "title": "Lift",
            },
            {
              "description":"Vitrified tiles in the foyer, living, dining, corridors, all bedrooms, kitchen & utility\n\nCeramic tiles in the balcony",
              "title": "Apartment Flooring",
            },
            {
              "description":"Granite counter with chrome plated tap with single bowl single drain stainless steel sink\n\nCeramic tiles dado for 2 feet over the granite counter\n\nProvision for exhaust fan",
              "title": "Kitchen",
            },
            {
              "description":"Toilet",
              "title": "Toilet",
            },
            {
              "description":"Internal Doors",
              "title": "Internal Doors",
            },
            {
              "description":"External Doors & Windows",
              "title": "External Doors & Windows",
            },
            {
              "description":"Painting",
              "title": "Painting",
            },
            {
              "description":"Electrical",
              "title": "Electrical",
            },
            {
              "description":"Security System",
              "title": "Security System",
            },
            {
              "description":"DG Power",
              "title": "DG Power",
            },
          ],
          "images": prjt5Img,
          "interested list": [],
          "location": "Banashankari, 6th Stage, off Kanakapura Road,, Bengaluru , 560109.",
          "map location":"",
          "price range starting": "70L",
          "project title": "HPrestige Elm Park",
          "project type": "Plots",
          "rera number": ": PHASE 1: PRM/KA/RERA/1251/310/PR/200618/003453 ",
          "site area": "15 Acres"
        }, SetOptions(merge: true)
    );
  }

  void addBlocks() async{
    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A")
        .set({
      "booking price": "10,000",
      "built up area": "1461 sqft",
      "carpet area": "971 sqft",
      "facing": "West Facing",

      "flat details": {
        "balcony": "97 sqft",
        "bathroom": "",
        "bedrooms": "",
        "kitchen": "",
        "living room": "",
      },

      "flat price": "70L",
      "flat type": "3BHK Apartment",
      "images": [
        "https://www.a2zproperty.in/Gujarat/Rajkot/shital-flat/image-34920-2.jpg",
        "https://images.bayut.com/thumbnails/73151141-800x600.jpeg",
        "https://5.imimg.com/data5/QB/DW/MY-41827458/3-bhk-1344-sq-2ffeet-flats-500x500.jpg"
      ],
      "total units": "",
      "Units Available": "12",
      "Total Blocks": "2",
      "Total Floors": "15",
      "availability": "Available",
    },SetOptions(merge: true));
  }

  void addUnits() async{

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("101")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("102")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("103")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      // "status": "available",
      "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("104")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("105")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("106")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      // "status": "available",
      "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("107")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("108")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("109")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("110")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      // "status": "available",
      "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("111")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("112")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("113")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      // "status": "available",
      "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("114")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("115")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("116")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      // "status": "available",
      "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("117")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("118")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("119")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      "status": "available",
      // "status": "notAvailable",
    },SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("admin app").doc("admin app")
        .collection("projects")
        .doc("prjt1")
        .collection("blocks").doc("A").collection("units").doc("120")
        .set({
      "booking date": "",
      "booking id": "",
      "booking user id": "",
      // "status": "available",
      "status": "notAvailable",
    },SetOptions(merge: true));
  }

  int featureNum = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
        centerTitle: true,
        backgroundColor: Color(0xff0B458C),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              titleWithTextField("Project Title*", projectTitleController,''),
              titleWithTextField("Location*", locationController,''),
              titleWithTextField("Project Type*", projectTypeController,''),
              titleWithTextField("Contact Number*", contactNumberController,''),
              titleWithTextField("Price Range*", priceRangeController,'L'),

              //Abaut Propperty
              Text("About Property*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
              SizedBox(height: 10 ,),
              SizedBox(
                // height: 200,
                child: TextField(
                  controller: aboutPropertyController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20 ,),

              //Add Features/Description

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Features/Spec*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
                  TextButton.icon(
                      onPressed: (){
                        setState(() {
                          featureNum++;
                        });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add"))
                ],
              ),
              SizedBox(height: 10 ,),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: featureNum,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: addFeaturesTitleController,
                                decoration: InputDecoration(
                                  hintText: "Enter Title ${index+1}",
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey
                                      )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      featureNum--;
                                    });
                                  },
                                  icon: Icon(Icons.dangerous_outlined, color: Colors.red,size: 30,)
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10 ,),
                      SizedBox(
                        // height: 200,
                        child: TextField(
                          controller: addFeaturesDescriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 ,),
                    ],
                  );
                },
              ),

              titleWithTextField("RERA No*", rearNumberController,''),
              //Development site area
              titleWithTextField("Development Site Area*", developmentSiteAreaController,'Acer'),

              //Add Property Images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Property Images*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
                  TextButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.add),
                      label: Text("Upload"))
                ],
              ),
              SizedBox(height: 10 ,),
              SizedBox(
                height: 200,
                width: 300,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      child: GridView.builder(
                          itemCount: _image.length + 1,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return index == 0
                                ? Center(
                              child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () =>
                                  !uploading ? chooseImage() : null),
                            )
                                : Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image[index - 1]),
                                      fit: BoxFit.cover)),
                            );
                          }),
                    ),
                    uploading
                        ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text(
                                'uploading...',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(
                              value: val,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                            )
                          ],
                        ))
                        : Container(),
                  ],
                ),
              ),
              /*Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey.shade300
                    )
                ),
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                              color: Colors.grey
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,color: Colors.grey,),
                          Text("Image ${index+1}",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    );
                  },
                ),
              ),*/
              SizedBox(height: 10 ,),

              //Add Documents*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Documents*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
                  TextButton.icon(
                      onPressed: (){
                        // setState(() {
                        //   featureNum++;
                        // });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add"))
                ],
              ),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Masterplan"),
                    ElevatedButton(
                        onPressed: () async {
                          // pId = DateTime.now().microsecondsSinceEpoch.toString();
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
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
                                .child('projectDocuments')
                                .child(pId)
                                .child("${file.name}");
                            var uploadTask = await ref.putFile(doc!);
                            pDocUrl1 = await uploadTask.ref.getDownloadURL();
                            pDocName1 = file.name;
                            print(pDocUrl1);

                          } else {
                            //  user cancel the picker
                          }
                        },
                        child: Text("upload")),
                  ],
                ),
              ),
              SizedBox(height: 10 ,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("1 BHK Plan"),
                    ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
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
                                .child('projectDocuments')
                                .child(pId)
                                .child("${file.name}");
                            var uploadTask = await ref.putFile(doc!);
                            pDocUrl2 = await uploadTask.ref.getDownloadURL();
                            pDocName2 = file.name;
                            print(pDocUrl2);

                          } else {
                            //  user cancel the picker
                          }
                        },
                        child: Text("upload")),
                  ],
                ),
              ),
              SizedBox(height: 10 ,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("2 BHK Plan"),
                    ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
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
                                .child('projectDocuments')
                                .child(pId)
                                .child("${file.name}");
                            var uploadTask = await ref.putFile(doc!);
                            pDocUrl3 = await uploadTask.ref.getDownloadURL();
                            pDocName3 = file.name;
                            print(pDocUrl3);

                          } else {
                            //  user cancel the picker
                          }
                        },
                        child: Text("upload")),
                  ],
                ),
              ),
              SizedBox(height: 20 ,),


              //Attach Property Brochure*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Attach Property Brochure*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
                  TextButton.icon(
                      onPressed: (){
                        // setState(() {
                        //   featureNum++;
                        // });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add"))
                ],
              ),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        keyboardType: TextInputType.none,
                        controller: broController1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
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
                                .child('projectBrochure')
                                .child(pId)
                                .child("${file.name}");
                            var uploadTask = await ref.putFile(doc!);
                            pBroUrl1 = await uploadTask.ref.getDownloadURL();
                            pBroName1 = file.name;
                            print(pBroUrl1);
                            setState(() {
                              broController1 = TextEditingController(text: file.name);
                            });

                          } else {
                            //  user cancel the picker
                          }
                        },
                        child: Text("upload")),
                  ],
                ),
              ),
              SizedBox(height: 10 ,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        keyboardType: TextInputType.none,
                        controller: broController2,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
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
                                .child('projectBrochure')
                                .child(pId)
                                .child("${file.name}");
                            var uploadTask = await ref.putFile(doc!);
                            pBroUrl2 = await uploadTask.ref.getDownloadURL();
                            pBroName2 = file.name;
                            print(pBroUrl2);
                            setState(() {
                              broController2 = TextEditingController(text: file.name);
                            });

                          } else {
                            //  user cancel the picker
                          }
                        },
                        child: Text("upload")),
                  ],
                ),
              ),
              SizedBox(height: 10 ,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        keyboardType: TextInputType.none,
                        controller: broController3,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
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
                                .child('projectBrochure')
                                .child(pId)
                                .child("${file.name}");
                            var uploadTask = await ref.putFile(doc!);
                            pBroUrl3 = await uploadTask.ref.getDownloadURL();
                            pBroName3 = file.name;
                            print(pBroUrl3);
                            setState(() {
                              broController3 = TextEditingController(text: file.name);
                            });

                          } else {
                            //  user cancel the picker
                          }
                        },
                        child: Text("upload")),
                  ],
                ),
              ),
              SizedBox(height: 20 ,),

              //Add Amenities*
              Text("Add Amenities*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
              SizedBox(height: 10 ,),

              GridView.builder(
                shrinkWrap: true,
                itemCount: 13,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 30
                ),
                itemBuilder: (context, index) {
                  List mapKeys = amenities.keys.toList();
                  return SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if(amenities[mapKeys[index]] == "selected"){
                                setState(() {
                                  amenities[mapKeys[index]] = "unselect";
                                });
                              }else{
                                setState(() {
                                  amenities[mapKeys[index]] = "selected";
                                });
                              }
                            },
                            icon: amenities[mapKeys[index]] == "selected" ?
                            Icon(Icons.check_circle, color: Color(0xff0B458C),)
                                : Icon(Icons.circle_outlined, color: Color(0xff0B458C),)
                        ),
                        Text(mapKeys[index],)
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20 ,),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () async{
                        // addProject1();
                        // addProject2();
                        // addProject3();
                        // addProject4();
                        // addProject5();
                        // addProject6();
                        // addProject7();
                        // addProject8();
                        // addProject9();
                        // addProject10();

                       await uploadFile();
                       addProject();



                      },
                      child: Text("Upload Project")
                  ),
                ),
              ),

              SizedBox(height: 30 ,),

             /* Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () async{
                        addBlocks();
                      },
                      child: Text("add Block")
                  ),
                ),
              ),

              SizedBox(height: 30 ,),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () async{
                        addUnits();
                      },
                      child: Text("add Units")
                  ),
                ),
              ),
*/











              /*Text("Project Title*",style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
              SizedBox(height: 10 ,),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: projectTitlecontroller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                    ),
                  ),
                ),
              )*/


            ],
          ),
        ),
      ),
    );
  }

  Widget titleWithTextField(String title, var controller, String pri){
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(color: Color(0xff0B458C),fontSize: 20),),
          SizedBox(height: 10 ,),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixText: pri,
                suffixStyle: TextStyle(color: Colors.blue),
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey
                    )
                ),
              ),
            ),
          ),
          SizedBox(height: 20 ,),
        ],
      ),
    );
  }

//  All image upload varible and functions
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  List<File> _image = [];
  final picker = ImagePicker();

  chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("projectImages")
          .child(pId)
          .child('${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {

          images.add(value);
          // imgRef.doc("images").set(
          //     {
          //       'url':  FieldValue.arrayUnion([value])
          //     }, SetOptions(merge: true)
          // );
          // // .add({'url': value});
          // i++;
        });
      });
    }
    print("${imgRef}///////////////////////////////////////////////////");
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
    pId = DateTime.now().microsecondsSinceEpoch.toString();
  }


}
