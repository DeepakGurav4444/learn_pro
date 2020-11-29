import 'package:flutter/material.dart';
import 'package:learn_pro/pages/home/home_main.dart';
import 'package:learn_pro/pages/my_course.dart';
import 'package:learn_pro/pages/search.dart';
import 'package:learn_pro/pages/settings/settings.dart';
import 'package:learn_pro/pages/wishlist.dart';

class BottomNavModel extends ChangeNotifier {
  int _currentTab = 0;
  List<Widget> _pages = [
    HomeMain(),
    Wishlist(),
    Search(),
    MyCourse(),
    Settings()
  ];

  set currentTab(int tab) {
    this._currentTab = tab;
    notifyListeners();
  }

  get currentTab => this._currentTab;
  get currentPage => this._pages[this._currentTab];
}
