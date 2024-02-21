import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_fire/widget.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController numController = TextEditingController();
  String? dropdownval;
  var items = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField(
            //   controller: nameController,
            //   decoration: InputDecoration(
            //     hintText: "name",
            //   ),
            // )
            textFormField(nameController, "Name", true),
            textFormField(emailController, "Email", true),
            Row(
              children: [
                SizedBox(
                    width: 110,
                    child: textFormField(ageController, "Age", false)),
                SizedBox(
                  width: 10,
                ),
                /*Container(
                          padding: EdgeInsets.only(left: 35),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              border: Border.all(color: Colors.cyan)),
                          child: Row(
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(color: Colors.cyan.shade200),
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Text('Male',),
                                  ),
                                  PopupMenuItem(
                                    child: Text('Male',),
                                  )
                                ],
                                // color: Colors.cyan,
                                elevation: 8,
                                shadowColor: Colors.purpleAccent,
                                shape: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purpleAccent),
                                  borderRadius: BorderRadius.circular(11)
                                ),
                              ),
                            ],
                          ),
                        )*/
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(color: Colors.cyan)),
                  child: Center(
                    child: DropdownButton(
                      value: dropdownval,
                      items: items.map((String listitems) {
                        return DropdownMenuItem(
                          value: listitems,
                          child: Center(child: Text(listitems)),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          dropdownval = newVal!;
                        });
                      },
                      hint: Text(
                        'gender',
                        style: TextStyle(color: Colors.cyan),
                      ),
                      borderRadius: BorderRadius.circular(11),
                      style: TextStyle(color: Colors.cyan),
                      isExpanded: true,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: numController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Number",
                    hintStyle: TextStyle(color: Colors.cyan.shade200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            textFormField(aboutController, "About", true),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('ProfileData')
                      .doc()
                      .set({
                    "name": nameController.text,
                    "email": emailController.text,
                    "about": aboutController.text,
                    "age": ageController.text,
                    "number": numController.text,
                    "gender": dropdownval,
                  }).then((value) {
                    Navigator.pop(context);
                    nameController.clear();
                    numController.clear();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Success')));
                  });
                },
                child: Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
