import 'dart:convert';
import 'dart:html';
import 'package:admin/models/Authentication.dart';

import '../API.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Admin extends ChangeNotifier {
  final int id;
  String username;
  final DateTime created_at;
  final DateTime? modified_at;
  static Admin? currentAdmin;
  static Admin? loggedinAdmin;
  static List<Admin> admins = [];

  Admin(
      {required this.id,
      required this.username,
      required this.created_at,
      this.modified_at});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      username: json['username'],
      created_at: DateTime.parse(json['created_at']),
      modified_at: DateTime.parse(json['modified_at']),
    );
  }

  static fromJsonString(String x) =>
      new List<Admin>.from(json.decode(x).map((j) => Admin.fromJson(j)).toList());

  static Map<String, dynamic> currentAdmintoJson() => {
        "id": currentAdmin?.id,
        "username": currentAdmin?.username,
        "created_at": currentAdmin?.created_at.toIso8601String(),
        "modified_at": currentAdmin?.modified_at?.toIso8601String(),
      };

  static Future<List<Admin>> getAll() async {
  try {
    var x = await apiRequest("v1/admin", "GET");
    print(x);
    x = Admin.fromJsonString(x);
    admins = x;
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}

Future<void> getById(id) async {
  try {
    var x = await apiRequest("v1/admin/$id", "GET");
    x = Admin.fromJsonString(x);
    return x;
  } catch (e) {
    print(e);
    return null;
  }
}

static Future<void> update(id,body) async {
  try {
    print(id);
    print(body);
    var x = await apiRequest("v1/admin/$id", "POST",body:body);
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}

static Future<bool> login(username,password,remeberme) async {
  try {
    var body = {"username":username, "password":password};
    
    var x = await apiRequest("v1/admin/login", "POST",body: body);
    x = json.decode(x);
    print(x);
    loggedinAdmin = Admin.fromJson(x);
    Authentication.token = Authentication.fromJson(x);

    if(remeberme){
      window.localStorage['token'] = Authentication.token ?? "";
    }
    
    return true;
  } catch (e) {
    print(e);
    throw e;
  }
}

static Future<bool> tokenLogin() async {
  try {
  
    var x = await apiRequest("v1/admin/tokenlogin", "POST");
    x = json.decode(x);
    print(x);
    loggedinAdmin = Admin.fromJson(x);
    return true;
  } catch (e) {
    print(e);
    throw e;
  }
}
}
