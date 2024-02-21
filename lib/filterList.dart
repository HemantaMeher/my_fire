import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fModel.dart';
class FilterList extends StatefulWidget {
  const FilterList({Key? key}) : super(key: key);

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Fetch"),
        bottom: PreferredSize(
          child: TextField(controller: searchcontroller,onChanged: (n){

            searchcontroller.text = n;

          },),
          preferredSize: Size(MediaQuery.of(context).size.width * 1, 40),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var data = {"Name":"sdffsf"};
          await FirebaseFirestore.instance.collection("Users").doc().set(
            {
              "dateTime": DateTime.now(),
            "name": "Hiiiiii",
            "number": 1234567890,
            "lists": ["d", 'd', 'n', 'o', 'p'],
            "maps": {'name': "sdfdsf", "d": "dsfsdf"}
            }
          ).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success"))));
        },
      ),

      body: StreamBuilder(
        //Order By date
        // stream: FirebaseFirestore.instance.collection("Users").orderBy("DateTime",descending: true,).snapshots(),
        //Filter By Field
        // stream: FirebaseFirestore.instance.collection("Users").where("Number",isEqualTo: 123,).snapshots(),
        //Filters by list
        // stream: FirebaseFirestore.instance.collection("Users").where("Lists",arrayContains: 'Z',).snapshots(),
        // stream: FirebaseFirestore.instance.collection("Users").where("Lists", arrayContainsAny: ['d', 'o'],).snapshots(),
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            Widget n;
            if (snapshot.hasData) {
              n = ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    var data = snapshot.data!.docs[index];
                    DateTime date =
                    DateTime.parse(data['dateTime'].toDate().toString());
                    DateTime time = DateTime.now();
                    DataTypes type = DataTypes.fromFirestore(data);
                    print(date);
                    if (type.name
                        .toString()
                        .toLowerCase()
                        .contains(searchcontroller.text.toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(data.id)
                                  .delete()
                                  .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  SnackBar(content: Text("Deleted"))));
                            },
                          ),
                          title: Text(type.name!),
                          subtitle: Text(
                              "${type.lists!.toString()} ${date.day}-${date.month}-${date.year} ${type.number!}"),
                          tileColor: Colors.green.shade100,
                          onTap: () async {
                            TextEditingController controller =
                            TextEditingController(
                                text: type.name!.toString());
                            showAboutDialog(context: context, children: [
                              TextField(
                                controller: controller,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(data.id)
                                        .update({
                                      'Name': controller.text,
                                      "Lists": FieldValue.arrayUnion(["One"]),
                                    }).then((value) => Navigator.pop(context));
                                  },
                                  child: Text("update"))
                            ]);
                          },
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(data.id)
                                .delete()
                                .then((value) => ScaffoldMessenger.of(context)
                                .showSnackBar(
                                SnackBar(content: Text("Deleted"))));
                          },
                        ),
                        title: Text(type.name!),
                        subtitle: Text(
                            "${type.lists!.toString()} ${date.day}-${date.month}-${date.year} ${type.number!}"),
                        tileColor: Colors.green.shade100,
                        onTap: () async {
                          TextEditingController controller =
                          TextEditingController(
                              text: type.name!.toString());
                          showAboutDialog(context: context, children: [
                            TextField(
                              controller: controller,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(data.id)
                                      .update({
                                    'Name': controller.text,
                                    "Lists": FieldValue.arrayUnion(["One"]),
                                  }).then((value) => Navigator.pop(context));
                                },
                                child: Text("update"))
                          ]);
                        },
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              n = Text("${snapshot.hasError}");
            } else {
              n = CircularProgressIndicator();
            }
            return n;
          }),

    );
  }


}
