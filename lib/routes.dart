import 'dart:js';

import 'package:admin/screens/admin/Admin%20Details/admindetailscreen.dart';
import 'package:admin/screens/admin/Admin%20List/adminList.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/user/User%20Details/userdetailscreen.dart';
import 'package:flutter/material.dart';
import './screens/dashboard/dashboard_screen.dart';
import 'screens/user/User List/userList.dart';
class pageRoutes{

  static const String dashboard =   DashboardScreen.routeName;
  static const String userList =   '/' + UserListScreen.routeName;
  static const String userDetails =   '/' + UserDetailsScreen.routeName;
  static const String adminList =   '/' + AdminListScreen.routeName;
  static const String adminDetails =  '/' + AdminDetailsScreen.routeName;
  static const String login =   Login.routeName;
  static  String home = '/';

  static Map<String, WidgetBuilder> routes = {
        home: (context)=> UserListScreen(),
        login:(context)=> Login(),
        //dashboard:(context)=> MainScreen(),
        userList:(context)=> UserListScreen(),
        userDetails:(context)=> UserDetailsScreen(),
        adminList:(context)=> AdminListScreen(),
        adminDetails:(context)=> AdminDetailsScreen(),
      };
  



}