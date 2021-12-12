import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://localhost:10017';


Function apiRequest = (route,method,[token,body]) async {

  var response;

  switch (method) {
    case "GET":
      response =  await http.get(Uri.parse('${baseUrl}/${route}'));
      break;
    case "POST":
      response =  await http.post(Uri.parse('${baseUrl}/${route}',body));
      break;
      case "PUT":
      response =  await http.put(Uri.parse('${baseUrl}/${route}', body));
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
};

