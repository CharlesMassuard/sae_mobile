import 'package:flutter/material.dart';

class MesPrets extends StatefulWidget {
  const MesPrets({Key? key}) : super(key: key);

  @override
  _MesPretsState createState() => _MesPretsState();
}

class _MesPretsState extends State<MesPrets> {
  late String someValue; // Declare your late variables here

  @override
  void initState() {
    super.initState();
    someValue = 'Initial value'; // Initialize your late variables here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My StatefulWidget'),
      ),
      body: Center(
        child: Text('Some value: $someValue'),
      ),
    );
  }
}