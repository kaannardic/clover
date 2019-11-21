import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum TabItem { Globalsayfa, Mesajsayfa, Profilsayfa }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.Globalsayfa: TabItemData(
      "",
      MdiIcons.clover,
    ),
    TabItem.Mesajsayfa: TabItemData("", MdiIcons.messageText),
    //TabItem.Ayarsayfa : TabItemData("Ayarlar",Icons.settings),
    TabItem.Profilsayfa: TabItemData("", Icons.person),
  };
}
