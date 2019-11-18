
import 'package:clover/common_widget/social_log_in_button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class YayinPage  extends StatefulWidget {


  @override
  _YayinPageState createState() => _YayinPageState();
}

class _YayinPageState extends State<YayinPage > {

  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// UserModel _userModel = Provider.of<UserModel>(context);
    return  Scaffold(
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
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(0.0),
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                child: TextFormField(

                  style: TextStyle(color: Colors.teal.shade700),
                  maxLength: 10,
                  ///controller: _duyuruController,
                  readOnly: false,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        MdiIcons.poundBox,
                        color: Colors.amber,
                      ), // icon is 48px widget.
                    ),
                    labelText: "#hastag",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8,bottom: 2,top: 2),
              child: Container(
                child: TextFormField(


                  style: TextStyle(color: Colors.teal.shade700),
                  maxLines: 1,
                  maxLength: 100,
                  cursorColor: Colors.teal,
                  //controller: ,
                  readOnly: false,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        MdiIcons.messageOutline,
                        color: Colors.amber,
                      ), // icon is 48px widget.
                    ),
                    labelText: "Duyuru",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 120 , right:  10),
                  child: SocialLoginButton(
                    radius: 5,
                    yukseklik: 40,
                    butonColor: Colors.teal,
                    butonText: " Gönder ",
                    onPressed: () {



                    },

                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );

  }

}
