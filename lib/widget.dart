import 'package:flutter/material.dart';

Widget textFormField(var nameController,String hintTxt,bool flag){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 50,
      child: TextFormField(
        controller: nameController,
        keyboardType: flag ? TextInputType.text : TextInputType.number,
        decoration: InputDecoration(
          hintText: hintTxt,
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
  );
}