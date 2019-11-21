import 'package:clover/app/my_custom_bottom_navi.dart';
import 'package:clover/app/pages/global_page.dart';
import 'package:clover/app/pages/mesaj_page.dart';
import 'package:clover/app/pages/profil_page.dart';
import 'package:clover/app/tab_items.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Globalsayfa;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Globalsayfa: GlobalKey<NavigatorState>(),
    TabItem.Profilsayfa: GlobalKey<NavigatorState>(),
    TabItem.Mesajsayfa: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Globalsayfa: GlobalPage(),
      TabItem.Profilsayfa: ProfilPage(),
      TabItem.Mesajsayfa: MessagePage(),

    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
      !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: MyCustomBottomNavigation(
        sayfaOlusturucu: tumSayfalar(),
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }
          print("seçilen tab item" + secilenTab.toString());
        },
      ),
    );
  }
}
