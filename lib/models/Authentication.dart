import 'dart:convert';
import 'dart:core';
import 'dart:html';
import 'package:admin/models/Admin.dart';

import '../API.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Authentication extends ChangeNotifier {

  static String? token = window.localStorage['token'] ?? window.sessionStorage['token'];



  static String fromJson (Map<String, dynamic> json) {
    return json['token'];
      
  }

  static void login(x,remeberme){
    Authentication.token = Authentication.fromJson(x);

    if(remeberme){
      window.localStorage['token'] = Authentication.token ?? "";
    }else{
      window.sessionStorage['token'] = Authentication.token ?? "";
    }
  }

  static void logout(){
    token = null;
    window.localStorage.remove('token');
    window.sessionStorage.remove('token');
  }

  static Future<void> initialize() async{
    try {
      await Admin.tokenLogin();  
    } catch (e) {
      logout();
    }
    
  }



}
