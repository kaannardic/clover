import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SocialListe extends StatelessWidget {
  final List hastagListe;
  final List globalListe;
  final List takipListe;

  final Color hastagAdiColor;
  final Color yorumColor;
  final Color kullaniciAdiColor;

  final double avatarSize;
  final double hastagSize;
  final double yorumSize;
  final double kullaniciAdiSize;

  final Widget butonIcon;

  final VoidCallback onPressed;

  const SocialListe({Key key, this.hastagListe,
    this.globalListe,
    this.takipListe,
    this.hastagAdiColor: Colors.blue,
    this.yorumColor: Colors.teal,
    this.kullaniciAdiColor: Colors.amber,
    this.avatarSize: 45,
    this.hastagSize: 16,
    this.yorumSize: 16,
    this.kullaniciAdiSize: 16,
    this.butonIcon,
    this.onPressed})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(child: ListView.builder(itemBuilder: (context, iposition) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      globalListe[iposition],
                      style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                    child: Text(
                      hastagListe[iposition],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "5m",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_border,
                        size: 35.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 2.0,
            color: Colors.grey,
          )
        ],
      );
    }));
  }
}