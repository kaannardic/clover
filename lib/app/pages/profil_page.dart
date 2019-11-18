import 'dart:io';
import 'package:clover/app/pages/ayarlar_page.dart';
import 'package:clover/common_widget/social_log_in_button.dart';
import 'package:clover/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _controllerUserName;
  String _controllerBiyografi;
  File _profilFoto;

  //////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName = _userModel.user.userName;
    _controllerBiyografi = _userModel.user.biyografi;

////////////////////////////////////////////////////////////////////////////////
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Icon(
              MdiIcons.clover,
              color: Colors.teal,
            ),
            Text("Clover")
          ],
        ), //
      ),
      body: SingleChildScrollView(
        //////////////////////////////////////////////////////////////    SingleChildScrollView
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        //////////////////////////////////////////////////////////////  CircleAvatar
                        radius: 60,
                        backgroundColor: Colors.amber.shade50,
                        backgroundImage: _profilFoto == null
                            ? NetworkImage(_userModel.user.profilURL)
                            : FileImage(_profilFoto),
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Post",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Takip",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Takipçi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left:4.0),
                    child: Container(
                      child: Text(
                        //////////////////////////////////////////////////////////////  KULLANICI ADI VERİTABANINDAN
                        '$_controllerUserName',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold, color: Colors.amber),

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left:4.0),
                    child: Container(
                      child: Text(
                        '$_controllerBiyografi',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SocialLoginButton(
                    //////////////////////////////////////////////////////////////  SocialLoginButton
                    radius: 5,
                    yukseklik: 40,
                    butonColor: Colors.teal,
                    butonText: "Profili Düzenle",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AyarlarPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
