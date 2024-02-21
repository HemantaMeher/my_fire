// import 'package:flutter/material.dart';
// import 'package:my_fire/widget.dart';
// class EditScreen extends StatefulWidget {
//   const EditScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   TextEditingController enameController = TextEditingController(text: data["name"]);
//   TextEditingController eemailController = TextEditingController(text: data["email"]);
//   TextEditingController eaboutController = TextEditingController(text: data["about"]);
//   TextEditingController eageController = TextEditingController(text: data["age"]);
//   TextEditingController enumController = TextEditingController(text: data["number"]);
//   String? dropdownval;
//   var items = ['Male', 'Female'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // TextField(
//           //   controller: nameController,
//           //   decoration: InputDecoration(
//           //     hintText: "name",
//           //   ),
//           // )
//           textFormField(enameController, "Name", true),
//           textFormField(
//               eemailController, "Email", true),
//           Row(
//             children: [
//               SizedBox(
//                   width: 110,
//                   child: textFormField(
//                       eageController, "Age", false)),
//               SizedBox(
//                 width: 10,
//               ),
//               /*Container(
//                             padding: EdgeInsets.only(left: 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(21),
//                                 border: Border.all(color: Colors.cyan)),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'Gender',
//                                   style: TextStyle(color: Colors.cyan.shade200),
//                                 ),
//                                 PopupMenuButton(
//                                   itemBuilder: (context) => [
//                                     PopupMenuItem(
//                                         child: Text('Male',),
//                                     ),
//                                     PopupMenuItem(
//                                       child: Text('Male',),
//                                     )
//                                   ],
//                                   // color: Colors.cyan,
//                                   elevation: 8,
//                                   shadowColor: Colors.purpleAccent,
//                                   shape: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.purpleAccent),
//                                     borderRadius: BorderRadius.circular(11)
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )*/
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 15),
//                 width: 120,
//                 decoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(21),
//                     border: Border.all(
//                         color: Colors.cyan)),
//                 child: Center(
//                   child: DropdownButton(
//                     value: dropdownval,
//                     items:
//                     items.map((String listitems) {
//                       return DropdownMenuItem(
//                         value: listitems,
//                         child: Center(
//                             child: Text(listitems)),
//                       );
//                     }).toList(),
//                     onChanged: (String? newVal) {
//                       setState(() {
//                         dropdownval = newVal!;
//                       });
//                     },
//                     hint: Text(
//                       'gender',
//                       style: TextStyle(
//                           color: Colors.cyan),
//                     ),
//                     borderRadius:
//                     BorderRadius.circular(11),
//                     style:
//                     TextStyle(color: Colors.cyan),
//                     isExpanded: true,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 50,
//               child: TextFormField(
//                 controller: enumController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Number",
//                   hintStyle: TextStyle(
//                       color: Colors.cyan.shade200),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(21),
//                     borderSide: BorderSide(
//                       color: Colors.cyan,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(21),
//                     borderSide: BorderSide(
//                       color: Colors.cyan,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           textFormField(
//               eaboutController, "About", true),
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             width: 250,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await FirebaseFirestore.instance
//                     .collection('ProfileData')
//                     .doc(data.id)
//                     .update({
//                   "name": enameController.text,
//                   "email": eemailController.text,
//                   "about": eaboutController.text,
//                   "age": eageController.text,
//                   "number": enumController.text,
//                 }).then((value) {
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(
//                       content: Text('Success')));
//                 });
//               },
//               child: Text(
//                 'Add',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.cyan,
//                   foregroundColor: Colors.white),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
