import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../API.dart';
import '../models/Authentication.dart';

enum ShipmentState {
    WAITING_CONFIRMATION,
    PROCESSING,
    DELIVERING,
    ARRIVED
}

class Order {
  
  final int id;
  String code;
  num price_sum;
  String shipment_status;
  String address_info;
  num user_id;
  String city_code;
  String delivery_method;
  String delivery_service;
  num delivery_fee;
  String? delivery_receipt;
  String? zip_code;

  final DateTime? paid_at;
  final DateTime created_at;
  final DateTime? modified_at;
  Order({
    required this.id,
    required this.code,
    required this.user_id,
    required this.price_sum,
    required this.shipment_status,
    required this.address_info,
    required this.city_code,
    required this.delivery_method,
    required this.delivery_service,
    required this.delivery_fee,
    required this.delivery_receipt,
    this.paid_at,
    this.zip_code,
    
    required this.created_at,
    this.modified_at,
  });
  static Order? currentOrder;
  static List<Order> orders = [];

   

 

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      code: json['code'],
      price_sum: json['price_sum'],
      user_id: json['user_id'],
      shipment_status: json['shipment_status'],
      address_info: json['address_info'],
      city_code: json['city_code'],
      delivery_service: json["delivery_service"],
      delivery_method: json["delivery_method"],
      delivery_fee: json["delivery_fee"],
      delivery_receipt: json["delivery_receipt"],

      created_at: DateTime.parse(json['created_at']),
      modified_at: json['modified_at'] == null? null: DateTime.parse(json['modified_at']),
      paid_at: json['paid_at'] == null? null: DateTime.parse(json['paid_at']),
      
      
      
    );
  }

  static fromJsonString(String x) =>
      new List<Order>.from(json.decode(x).map((j) => Order.fromJson(j)).toList());

  static Map<String, dynamic> currentOrdertoJson() => {
    "id": currentOrder?.id,
      "code": currentOrder?.code,
      "price_sum": currentOrder?.price_sum,
      "user_id": currentOrder?.user_id,
      "shipment_status": currentOrder?.shipment_status,
      "address_info": currentOrder?.address_info,
      "city_code": currentOrder?.city_code,
      "delivery_service": currentOrder?.delivery_service,
      "delivery_method": currentOrder?.delivery_method,
      "delivery_fee": currentOrder?.delivery_fee,
      "delivery_receipt": currentOrder?.delivery_receipt,  
      "paid_at": currentOrder?.paid_at?.toIso8601String(),
      "created_at": currentOrder?.created_at.toIso8601String(),
      "modified_at": currentOrder?.modified_at?.toIso8601String(),

      };

  static Future<List<Order>> getAll() async {
  try {
    var x = await apiRequest("v1/orders", "GET");
    print(x);
    x = Order.fromJsonString(x);
    orders = x;
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}

Future<void> getById(id) async {
  try {
    var x = await apiRequest("v1/order/$id", "GET");
    x = Order.fromJsonString(x);
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
    var x = await apiRequest("v1/order/$id", "PUT",body:body);
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}


}
