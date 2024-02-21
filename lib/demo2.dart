import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Demo2Screen extends StatefulWidget {
  const Demo2Screen({Key? key}) : super(key: key);

  @override
  State<Demo2Screen> createState() => _Demo2ScreenState();
}

class _Demo2ScreenState extends State<Demo2Screen> {
  List<Map<String, dynamic>> data = List.generate(20, (index) => {"id": index, "status": "available"});
  int selectedIdx = -1;

  void handleContainerTap(int index) {
    if (data[index]["status"] == "available") {
      if (selectedIdx != -1) {
        setState(() {
          data[selectedIdx]["status"] = "available";
        });
      }

      setState(() {
        data[index]["status"] = "select";
        selectedIdx = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 0,
          mainAxisExtent: 80,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          var clr = data[index]["status"] == "available" ? Color(0xffE1EEFF) : Color(0xffFF0000);
          return InkWell(
            onTap: () {
              handleContainerTap(index);
            },
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: clr,
                    border: Border.all(
                      width: 1,
                      color: Color(0xff838396),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.key,
                      color: data[index]["status"] == "available" ? Color(0xff051830) : Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "${data[index]["id"]}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff0B458C)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}