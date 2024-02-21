import 'package:flutter/material.dart';
class SafeAreaScreen extends StatefulWidget {
  const SafeAreaScreen({Key? key}) : super(key: key);

  @override
  State<SafeAreaScreen> createState() => _SafeAreaScreenState();
}

class _SafeAreaScreenState extends State<SafeAreaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SafeAreaScreen'),),
    );
  }
}
