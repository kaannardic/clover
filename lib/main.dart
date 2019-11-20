import 'package:clover/app/landing_page.dart';
import 'package:clover/locator.dart';
import 'package:clover/viewmodel/duyuru_model.dart';
import 'package:clover/viewmodel/user_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) =>UserModel(),
      child: ChangeNotifierProvider(
        builder: (context) => DuyuruModel(),
        child: MaterialApp(

          title: "Flutter Social",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.white,
            //Color(0xFF393C4F)
            accentColor: Colors.teal,
            backgroundColor: Colors.white,
            primarySwatch: Colors.amber,
          ),
          home: LandingPage(
          ),

        ),
      ),
    );
  }
}
