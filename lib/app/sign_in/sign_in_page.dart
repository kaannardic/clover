import 'package:clover/common_widget/social_log_in_button.dart';
import 'package:clover/model/user.dart';
import 'package:clover/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignInPage extends StatelessWidget {
  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    User _user = await _userModel.signInWithGoogle();
    if (_user != null) print("oturun açan user" + _user.userID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

        /// STACKLER  ALTTAN ÜSTE DOĞRU SIRALANMIŞ ŞEKİLDE
        children: <Widget>[
          /*LiquidLinearProgressIndicator(
            value: 0.3, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors.teal), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.amber, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.white,
            borderWidth: 0.0,
            borderRadius: 0.0,
            direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
            center: Text(""),
          ), */
          /// DALGALI ANİMASYON
          LiquidLinearProgressIndicator(
            value: 0.6, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors.amber), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.teal, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.white,
            borderWidth: 0.0,
            borderRadius: 0.0,
            direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
            center: Text(""),
          ),

          /// UYGULAMA LOGOSU  , GOOGLE GİRİŞ VE İSİM PNG Sİ BURADA
          Container(

            color: Colors.transparent,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[



                Container(
                  child: Image.asset(
                    "images/catspawlogo1.png",
                    width: 400,
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      MdiIcons.clover,
                      size: 250,
                      color: Colors.white,
                    ) //Image.asset("images/catspaw.png",width: 200,alignment:Alignment.center ,),
                ),
                /*Text(
              "Cat'sPaw",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),

            ),*/

                SizedBox(
                  height: 50,
                ),
                SocialLoginButton(
                  butonText: "Google ile giriş yap",
                  textColor: Colors.white,
                  radius: 16,
                  butonIcon: Icon(
                    MdiIcons.google,
                    color: Colors.white,
                  ),
                  onPressed: () => _googleIleGiris(context),
                  butonColor: Colors.teal.shade600,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}








