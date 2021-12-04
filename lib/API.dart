import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://localhost';

Function getAllUser = () async {
  var response = await http.get(Uri.parse('${baseUrl}/v1/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load response');
  }
};
