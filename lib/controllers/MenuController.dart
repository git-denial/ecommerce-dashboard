import 'package:flutter/material.dart';
import '../routes.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int index = 0;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  static int get getIndex => index;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
