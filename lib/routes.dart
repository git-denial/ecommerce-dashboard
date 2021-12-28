import 'dart:js';

import 'package:admin/screens/admin/Admin%20Details/admindetailscreen.dart';
import 'package:admin/screens/admin/Admin%20List/adminList.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/order/Order%20Details/orderLineDetails.dart';
import 'package:admin/screens/order/orderList/orderList.dart';
import 'package:admin/screens/product/Product%20Details/productdetailscreen.dart';
import 'package:admin/screens/product/Product%20List/productList.dart';
import 'package:admin/screens/product/Product%20Details/productDetails.dart';
import 'package:admin/screens/user/User%20Details/userdetailscreen.dart';
import 'package:flutter/material.dart';
import './screens/dashboard/dashboard_screen.dart';
import 'screens/order/Order Details/orderdetailscreen.dart';
import 'screens/user/User List/userList.dart';
class pageRoutes{

  static const String dashboard =   '/' + DashboardScreen.routeName;
  static const String userList =   '/' + UserListScreen.routeName;
  static const String userDetails =   '/' + UserDetailsScreen.routeName;
  static const String adminList =   '/' + AdminListScreen.routeName;
  static const String adminDetails =  '/' + AdminDetailsScreen.routeName;
  static const String productList =   '/' + ProductListScreen.routeName;
  static const String productDetails =  '/' + ProductDetailsScreen.routeName;
  static const String orderList =   '/' + OrderListScreen.routeName;
  static const String orderDetails =  '/' + OrderDetailsScreen.routeName;
  static const String orderLineDetails =  '/' + OrderLinesDetails.routeName;
  
  static const String login =   '/' + Login.routeName;
  static  String home = UserListScreen.routeName;

  static Map<String, WidgetBuilder> routes = {
        home: (context)=> UserListScreen(),
        login:(context)=> Login(),
        userList:(context)=> UserListScreen(),
        userDetails:(context)=> UserDetailsScreen(),
        adminList:(context)=> AdminListScreen(),
        adminDetails:(context)=> AdminDetailsScreen(),
        productList:(context)=> ProductListScreen(),
        productDetails:(context)=> ProductDetailsScreen(),
        orderList:(context)=> OrderListScreen(),
        orderDetails:(context)=> OrderDetailsScreen(),
        orderLineDetails:(context)=> OrderLinesDetails(),
        //dashboard:(context)=> MainScreen(),
      };
  



}