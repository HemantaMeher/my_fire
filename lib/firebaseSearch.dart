import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchPageDemo extends StatefulWidget {
  const SearchPageDemo({super.key});

  @override
  State<SearchPageDemo> createState() => _SearchPageDemoState();
}

class _SearchPageDemoState extends State<SearchPageDemo> {
  TextEditingController search = TextEditingController();
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 19),
              height: height / 15,
              width: width / 1,
              decoration: BoxDecoration(
                  // color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Color.fromRGBO(141, 192, 210, 0.5))),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                controller: search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(141, 192, 210, 0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(141, 192, 210, 0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(141, 192, 210, 0.5)),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 19),
              width: width / 1,
              child: search.text.isEmpty
                  ? SizedBox()
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                if (snapshot.data!.docs[index]["Name"]
                                    .toString()
                                    .toLowerCase()
                                    .startsWith(search.text.toLowerCase())) {
                                  if (snapshot.data!.docs[index]["Name"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(search.text.toLowerCase())) {
                                    // var facility = [];
                                    // facility =
                                    // snapshot.data!.docs[index]["Facility"];
                                    return Text(
                                      snapshot.data!.docs[index]['Name'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    );
                                  } else {
                                    return Container();
                                  }
                                } else {
                                  return SizedBox();
                                }
                              }));
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
            ),
          ],
        ),
      )),
    );
  }
}
