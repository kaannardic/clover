import 'package:clover/app/tab_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyCustomBottomNavigation extends StatelessWidget {
  const MyCustomBottomNavigation(
      {Key key,
        @required this.currentTab,
        @required this.onSelectedTab,
        @required this.navigatorKeys,
        @required this.sayfaOlusturucu})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        //Color(0xFF393C4F)
        activeColor: Colors.amber,
        items: [
          _navItemOlustur(TabItem.Globalsayfa),
          _navItemOlustur(TabItem.Mesajsayfa),
          _navItemOlustur(TabItem.Profilsayfa),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: navigatorKeys[gosterilecekItem],
            builder: (context) {
              return sayfaOlusturucu[gosterilecekItem];
            });
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];

    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab.icon),
      title: Text(olusturulacakTab.title), // isteğe göre sil bunu
    );
  }
}
