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
        backgroundColor: Colors.white,elevation: 0,
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
      body: Center(
        child: _buildYeniMesajGir(context),
      ),
    );
  }


  Widget _buildYeniMesajGir(context) {
    final _duyuruModel = Provider.of<DuyuruModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 8, left: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _duyuruMesajController,
              cursorColor: Colors.blueGrey,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Mesajınızı Yazın",
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _duyuruKonuController,
              cursorColor: Colors.blueGrey,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "konu Yazın",
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.navigation,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () async {
                /// duyuru ve mesaj kutuları sıfırdan büyükse gerekeni yap !
                if (_duyuruMesajController.text.trim().length &_duyuruKonuController.text.trim().length > 0) {
                  Duyuru _kaydedilecekMesaj = Duyuru(
                    userID: _usermodel.user.userID,
                    konutxt: _duyuruKonuController.text,
                    mesajDuyuru: _duyuruMesajController.text,

                  );

                  var sonuc = await _duyuruModel.saveDuyuru(_kaydedilecekMesaj);
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
            ),
          ),
        ],
      ),
    );
  }




}
