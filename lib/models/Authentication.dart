import 'dart:convert';
import 'dart:core';
import 'dart:html';
import '../API.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Authentication extends ChangeNotifier {

  static String? token = window.localStorage['token'];



  static String fromJson (Map<String, dynamic> json) {
    return json['token'];
      
  }

  static void logout(){
    token = null;
    window.localStorage.remove('token');
  }



}
