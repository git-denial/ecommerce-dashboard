import 'dart:async';
import 'dart:convert';
import 'package:admin/models/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://localhost:10017';


Function apiRequest = (route, method, {body}) async {
  print(body);
  final Map<String, String> header = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer ${Authentication.token}',
};
  try {
    var response;

    switch (method) {
      case "GET":
        response = await http.get(Uri.parse('${baseUrl}/${route}'));
        break;
      case "POST":
        response = await http.post(
          Uri.parse('${baseUrl}/${route}'),
          headers: header,
          body: body == null ? null : json.encode(body),
        );
        break;
      case "PUT":
        response = await http.put(
          Uri.parse('${baseUrl}/${route}'),
          headers: header,
          body: body,
        );
        break;
      case "DELETE":
        response = await http.delete(Uri.parse('${baseUrl}/${route}'));
        break;
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw response.body;
    }
  } catch (e) {
    throw e;
  }
};
