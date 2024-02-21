import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireTodo extends StatefulWidget {
  const FireTodo({Key? key}) : super(key: key);

  @override
  State<FireTodo> createState() => _FireTodoState();
}

class _FireTodoState extends State<FireTodo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fire Todo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: numController,
                    decoration: const InputDecoration(hintText: 'Num'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("FireTodo")
                            .doc()
                            .set({
                          "name": nameController.text,
                          "num": numController.text,
                          "dt": DateTime.now()
                        }).then((value) {
                          Navigator.pop(context);
                          nameController.clear();
                          numController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success')));
                        });
                      },
                      child: const Text('Add')),
                ],
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("FireTodo").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            TextEditingController enameController =
                                TextEditingController(text: data['name']);
                            TextEditingController enumController =
                                TextEditingController(text: data['num']);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: enameController,
                                      decoration: const InputDecoration(
                                          hintText: 'Name'),
                                    ),
                                    TextField(
                                      controller: enumController,
                                      decoration: const InputDecoration(
                                          hintText: 'Num'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection("FireTodo")
                                              .doc(data.id)
                                              .update({
                                            "name": enameController.text,
                                            "num": enumController.text,
                                          }).then((value) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Update Success')));
                                          });
                                        },
                                        child: const Text('Update'))
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.cyan,
                          )),
                      title: Text(data['name']),
                      subtitle: Text(data["num"]),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.dangerous_rounded,
                                      color: Colors.red,
                                      size: 100,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Are you sure?",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Do you really want to delete these records? this process cannot be undone.",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Back'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.white),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection("FireTodo")
                                                .doc(data.id)
                                                .delete()
                                                .then((value) => ScaffoldMessenger
                                                        .of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Delete Success'))));
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.hasError}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
