import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Duyuru {
  final String userID;
  String konutxt;

  DateTime createdAt;
  DateTime updatedAt;

  String mesajDuyuru;

  Duyuru(
      {@required this.userID,
      @required this.konutxt,
      @required this.mesajDuyuru});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'konutxt': konutxt,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'mesajDuyuru': mesajDuyuru ?? 'Duyuru yapılmamış',
    };
  }

  Duyuru.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        konutxt = map['konutxt'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        mesajDuyuru = map['mesajDuyuru'];

  Duyuru.idveResim({@required this.userID,});

  @override
  String toString() {
    return 'User{userID: $userID, email: $konutxt,  createdAt: $createdAt, updatedAt: $updatedAt,  mesajDuyuru: $mesajDuyuru}';
  }
}
