import 'dart:io';
import 'package:clover/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:clover/common_widget/progres_widget.dart';
import 'package:clover/common_widget/social_log_in_button.dart';
import 'package:clover/viewmodel/user_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AyarlarPage extends StatefulWidget {
  @override
  _AyarlarPageState createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {
  TextEditingController _controllerUserName;
  TextEditingController _controllerBiyografi;
  File _profilFoto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerUserName = TextEditingController();
    _controllerBiyografi = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    _controllerBiyografi.dispose();
    super.dispose();
  }

  void _kameradanFotoCek() async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  void _galeridenFotoSec() async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName.text = _userModel.user.userName;
    _controllerBiyografi.text = _userModel.user.biyografi;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
              onPressed: () => _cikisIcinOnayIste(context),
              child: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.amber),
              ))
        ],
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
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 120,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.photo_camera,
                                          color: Colors.amber,
                                        ),
                                        title: Text("Kameradan Çek"),
                                        onTap: () {
                                          _kameradanFotoCek();
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.photo,
                                          color: Colors.amber,
                                        ),
                                        title: Text("Galeriden Yükle"),
                                        onTap: () {
                                          _galeridenFotoSec();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.amber.shade50,
                          backgroundImage: _profilFoto == null
                              ? NetworkImage(_userModel.user.profilURL)
                              : FileImage(_profilFoto),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                FlatButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 120,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.photo_camera,
                                      color: Colors.amber,
                                    ),
                                    title: Text("Kameradan Çek"),
                                    onTap: () {
                                      _kameradanFotoCek();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.photo,
                                      color: Colors.amber,
                                    ),
                                    title: Text("Galeriden Yükle"),
                                    onTap: () {
                                      _galeridenFotoSec();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Text(
                      "Profil Fotoğrafını Değiştir",
                      style: TextStyle(color: Colors.amber),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      style: TextStyle(color: Colors.teal.shade700),
                      maxLength: 20,
                      controller: _controllerUserName,
                      readOnly: false,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      style: TextStyle(color: Colors.teal.shade700),
                      maxLines: 1,
                      maxLength: 100,
                      cursorColor: Colors.teal,
                      controller: _controllerBiyografi,
                      readOnly: false,
                      decoration: InputDecoration(
                        labelText: "Biyografi",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      initialValue: _userModel.user.userID,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SocialLoginButton(
                    radius: 5,
                    yukseklik: 40,
                    butonColor: Colors.teal,
                    butonText: "Kaydet",
                    onPressed: () {
                      _userNameGuncelle(context);
                      _profilFotoGuncelle(context);
                      _userBiyografiGuncelle(context);
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

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await PlatformDuyarliAlertDialog(
      baslik: "Hesaptan Çık!",
      icerik: "Çıkmak istediğinizden emin misiniz?",
      anaButonYazisi: "Evet",
      iptalButonYazisi: "Vazgeç",
    ).goster(context);

    if (sonuc == true) {
      _cikisYap(context);
    }
  }

  void _userNameGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    if (_userModel.user.userName != _controllerUserName.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.user.userID, _controllerUserName.text);

      if (updateResult == true) {
        // _userModel.user.userName=_controllerUserName.text;
        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Username değiştirildi",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      } else {
        _controllerUserName.text = _userModel.user.userName;
        PlatformDuyarliAlertDialog(
          baslik: "Hata",
          icerik: "Username zaten kullanımda, farklı bir username deneyiniz",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }

  void _userBiyografiGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    if (_userModel.user.biyografi != _controllerBiyografi.text) {
      var updateResult = await _userModel.updateBiyografi(
          _userModel.user.userID, _controllerBiyografi.text);

      if (updateResult == true) {
        // _userModel.user.userName=_controllerUserName.text;
        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Biyografi değiştirildi",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      } else {
        _controllerBiyografi.text = _userModel.user.biyografi;
        PlatformDuyarliAlertDialog(
          baslik: "Hata",
          icerik: " farklı bir biyografi deneyiniz",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }

  void _profilFotoGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    if(_profilFoto == null){
      MyProgresIndicator();
      print("myprogresi geçti");
    }
    if (_profilFoto != null) {
      var url = await _userModel.uploadFile(
          _userModel.user.userID, "profil_foto", _profilFoto);
      print("gelen url:" + url);

      if (url != null){
        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Profil fotoğrafınız güncellendi",
          anaButonYazisi: 'Tamam',
        ).goster(context);
        print("alerte  geçti");
      }


    }

  }
}
