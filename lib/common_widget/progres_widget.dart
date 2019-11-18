

import 'package:flutter/material.dart';




class MyProgresIndicator extends StatefulWidget {
  @override
  _MyProgresIndicatorState createState() => _MyProgresIndicatorState();
}

class _MyProgresIndicatorState extends State<MyProgresIndicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: CircularProgressIndicator(
          ///valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}
