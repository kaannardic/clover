import 'package:clover/app/home_page.dart';
import 'package:clover/app/sign_in/sign_in_page.dart';
import 'package:clover/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return HomePage(user: _userModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child:  LiquidLinearProgressIndicator(

            /// BEKLEME EKRANINDAKİ DALGALI ANİMASYON
            value: 0.6, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors.amber), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.teal, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.white,
            borderWidth: 0.0,
            borderRadius: 0.0,
            direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
            center: Text(""),
          ),
          ///CircularProgressIndicator(),
        ),
      );
    }
  }
}
