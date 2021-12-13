import 'package:flutter/material.dart';
import '../routes.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget page = pageRoutes.goTo[pageRoutes.userList];
  String pageName = pageRoutes.userList;
  static int index = 0;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  Widget get getPage => page;
  String get getPageName => pageName;
  static int get getIndex => index;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
  void changePage(String x){
    page = pageRoutes.goTo[x];
    pageName = x;
    notifyListeners();
  }
}
