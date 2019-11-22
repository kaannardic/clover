import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Duyuru {
  final String userID;
  String konutxt;
  String duyuruProfilURL;
  String duyuruUserName;
  DateTime createdAt;
  DateTime updatedAt;

  String mesajDuyuru;

  Duyuru(
      {@required this.userID,
      @required this.konutxt,
      @required this.duyuruProfilURL,
      @required this.duyuruUserName,
      @required this.mesajDuyuru});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'konutxt': konutxt,
      'duyuruProfilURL': duyuruProfilURL,
      'duyuruUserName': duyuruUserName,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'mesajDuyuru': mesajDuyuru ?? 'Duyuru yapılmamış',
    };
  }

  Duyuru.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        konutxt = map['konutxt'],
        duyuruProfilURL = map['duyuruProfilURL'],
        duyuruUserName = map['duyuruUserName'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        mesajDuyuru = map['mesajDuyuru'];

  Duyuru.idveResim({@required this.userID,});

  @override
  String toString() {
    return 'User{userID: $userID,duyuruProfilURL: $duyuruProfilURL,duyuruUserName: $duyuruUserName, konutxt: $konutxt,  createdAt: $createdAt, updatedAt: $updatedAt,  mesajDuyuru: $mesajDuyuru}';
  }
}
