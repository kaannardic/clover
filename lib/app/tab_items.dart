import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {Globalsayfa,Mesajsayfa,Profilsayfa }

class TabItemData{


  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> tumTablar = {

    TabItem.Globalsayfa : TabItemData("Global",Icons.all_inclusive),
    TabItem.Mesajsayfa : TabItemData("Mesaj",Icons.message),
    //TabItem.Ayarsayfa : TabItemData("Ayarlar",Icons.settings),
    TabItem.Profilsayfa : TabItemData("Profil",Icons.person),
  };
}