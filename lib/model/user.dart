import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String userID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  DateTime updatedAt;
  int seviye;
  String biyografi;

  User({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName':
      userName ?? email.substring(0, email.indexOf("@")) + ramdomSayiUret(),
      // maildeki kısmı @ e kadar alıp username yapacağız
      'profilURL': profilURL ??
          'https://pbs.twimg.com/profile_images/707968846880227328/ylFJEqxn.jpg',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
      'biyografi': biyografi ?? 'Newbie',
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        seviye = map['seviye'],
        biyografi = map['biyografi'];

  User.idveResim({@required this.userID, @required this.profilURL});

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye, biyografi: $biyografi}';
  }

  String ramdomSayiUret() {
    int rastgeleSayi = Random().nextInt(9999999);
    return rastgeleSayi.toString();
  }
}
