import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover/model/duyuru.dart';
import 'package:clover/viewmodel/duyuru_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
class KullanicilarPage extends StatefulWidget {
  @override
  _KullanicilarPageState createState() => _KullanicilarPageState();
}

class _KullanicilarPageState extends State<KullanicilarPage> {
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: _buildMesajListesi(),
      ),
    );
  }

  Widget _buildMesajListesi() {
    return Consumer<DuyuruModel>(builder: (context, duyuruModel, child) {
      return  ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemBuilder: (context, index) {
            if (duyuruModel.hasMoreLoading &&
                duyuruModel.dmesajlarListesi.length == index) {
              return _yeniElemanlarYukleniyorIndicator();
            } else
              return _konusmaBalonuOlustur(duyuruModel.dmesajlarListesi[index]);
          },
          itemCount: duyuruModel.hasMoreLoading
              ? duyuruModel.dmesajlarListesi.length + 1
              : duyuruModel.dmesajlarListesi.length,

      );
    });
  }


  _yeniElemanlarYukleniyorIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _konusmaBalonuOlustur(Duyuru oankiMesaj) {
    Color _gidenMesajRenk = Theme
        .of(context)
        .primaryColor;
    final _duyuruModel = Provider.of<DuyuruModel>(context);
    var _saatDakikaDegeri = "";

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _gidenMesajRenk,
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(4),
                  child: Text(
                    oankiMesaj.mesajDuyuru,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Text(_saatDakikaDegeri),
            ],
          ),
        ],
      ),
    );
  }
  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      eskiMesajlariGetir();
    }
  }
  void eskiMesajlariGetir() async {
    final _duyuruModel = Provider.of<DuyuruModel>(context);
    if (_isLoading == false) {
      _isLoading = true;
      await _duyuruModel.dahaFazlaMesajGetir();
      _isLoading = false;
    }
  }
}

