import 'package:clover/common_widget/social_log_in_button.dart';
import 'package:clover/model/duyuru.dart';
import 'package:clover/viewmodel/duyuru_model.dart';
import 'package:clover/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatelessWidget {
  var _duyuruMesajController = TextEditingController();
  var _duyuruKonuController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _duyuruModel = Provider.of<DuyuruModel>(context);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: _buildYeniMesajGir(context),
          ),
        ],
      ),
    );
  }

  Widget _buildYeniMesajGir(context) {
    final _duyuruModel = Provider.of<DuyuruModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Stack(
      children: <Widget>[
        
        SizedBox(height: 50,),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                maxLines: 1,
                maxLength: 10,
                controller: _duyuruKonuController,
                cursorColor: Colors.blueGrey,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade50),
                      borderRadius: BorderRadius.circular(1)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.shade700),
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: " #Konu ",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                maxLength: 100,
                maxLines: 3,
                controller: _duyuruMesajController,
                cursorColor: Colors.blueGrey,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade50),
                      borderRadius: BorderRadius.circular(1)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.shade700),
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Duyuru!! ",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              SizedBox(height: 10,),

              Container(


                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                ),

                child: SocialLoginButton( butonText: "Gönder",
                  textColor: Colors.white,
                  butonColor: Colors.teal.shade700,
                  radius: 16,
                  butonIcon: Icon(
                    MdiIcons.send,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    /// duyuru ve mesaj kutuları sıfırdan büyükse gerekeni yap !
                    if (_duyuruMesajController.text.trim().length &
                            _duyuruKonuController.text.trim().length >
                        0) {
                      Duyuru _kaydedilecekMesaj = Duyuru(
                        duyuruProfilURL: _usermodel.user.profilURL,
                        duyuruUserName: _usermodel.user.userName,
                        userID: _usermodel.user.userID,
                        konutxt: _duyuruKonuController.text,
                        mesajDuyuru: _duyuruMesajController.text,
                      );

                      var sonuc =
                          await _duyuruModel.saveDuyuru(_kaydedilecekMesaj);
                      if (sonuc) {
                        _duyuruMesajController.clear();
                        _duyuruKonuController.clear();
                        FocusScope.of(context).unfocus();
                        /* _scrollController.animateTo(
                        0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 10),
                      );*/
                      }
                    }
                  },
                ),/////////
              ),
            ],
          ),
        ),

      ],
    );
  }
}
