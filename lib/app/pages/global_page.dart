import 'dart:io';

import 'package:clover/model/duyuru.dart';
import 'package:clover/model/user.dart';
import 'package:clover/viewmodel/duyuru_model.dart';
import 'package:clover/viewmodel/user_model.dart';

import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  File _profilFoto;
  List<User> _tumkullanicilar;

  @override
  Widget build(BuildContext context) {
    DuyuruModel _duyuruModel = Provider.of<DuyuruModel>(context);
    UserModel _usermodel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
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
      body: FutureBuilder<List<Duyuru>>(
          future: _duyuruModel.getDuyuru(),
          builder: (context, sonuc) {
            if (sonuc.hasData == true) {
              var tumDuyurular = sonuc.data;

              if (tumDuyurular.length > 0) {
                return RefreshIndicator(
                  onRefresh:_duyuruListesiYenile,
                  child: ListView.builder(
                    itemCount: tumDuyurular.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        elevation: 2,
                        margin:
                            new EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.amber))),
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      sonuc.data[index].duyuruProfilURL)),
                            ),
                            title: Row(
                              children: <Widget>[
                                Text(
                                  "@" + sonuc.data[index].duyuruUserName,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "#" + sonuc.data[index].konutxt,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            subtitle: Text(sonuc.data[index].mesajDuyuru,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ))),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("Duyuru yok"),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<Null> _duyuruListesiYenile() async{

    setState(() {

    });
    return null;
  }

/*
  User listedeUserBul(String userID) {

    for (int i = 0; i < _tumkullanicilar.length; i++){
      if(_tumkullanicilar[i].userID == userID){
        return _tumkullanicilar[i];
      }
    }
    return null;
  }



  for(var oankiDuyuru in tumDuyurular){
  var userListesindekiKullanici =  listedeUserBul(oankiDuyuru.userID);


  if(userListesindekiKullanici != null){
  oankiDuyuru.duyuruUserName = userListesindekiKullanici.userName;
  oankiDuyuru.duyuruProfilURL = userListesindekiKullanici.profilURL;
  }else {

  print("aranılan user  getirilmedi");

  }


  }
  
   */

}
