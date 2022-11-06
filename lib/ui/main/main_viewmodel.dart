import 'package:flutter/material.dart';

import '../feeds/create_feeds_page.dart';
import '../home/home_page.dart';
import '../map/maps_page.dart';
import '../profile/profile_page.dart';

class MainViewModel with ChangeNotifier {
  int selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MapsPage(),
    CreateFeedsPage(),
    ProfilePage(),
  ];

  Widget autoSelectPage() => _widgetOptions.elementAt(selectedIndex);

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
