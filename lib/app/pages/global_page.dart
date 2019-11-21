
import 'package:clover/model/duyuru.dart';
import 'package:clover/viewmodel/duyuru_model.dart';

import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  Widget build(BuildContext context) {
    DuyuruModel _duyuruModel = Provider.of<DuyuruModel>(context);
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

              if (tumDuyurular.length-1 > 0) {

                return ListView.builder(
                  itemCount: tumDuyurular.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(sonuc.data[index].userID),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("Kayıtlı kullanıcı yok"),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator()
              );

            }
          }
        ),);
  }
}
