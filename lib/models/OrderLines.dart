import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:admin/models/Product.dart';

import '../API.dart';


class OrderLine {
  final int id;
  final int product_id;
  final int order_id;
  final int quantity;
  num price;

  String? description;
  var customization;
  Product? product;

  final DateTime created_at;

  OrderLine({
    required this.id,
    required this.order_id,
    required this.product_id,
    required this.price,
    required this.quantity,
    this.description,
    this.customization,
    required this.created_at,
    this.product
  });
  static OrderLine? currentOrderLines;
  static List<OrderLine> orderLines = [];

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    
    return OrderLine(
      id: json['id'],
      order_id: json['order_id'],
      price: json['price'],
      quantity: json['quantity'],
      product_id: json['product_id'],
      description: json['description'],
      customization: json["customization"],
      created_at: DateTime.parse(json['created_at']),
      product: Product.fromJson(json["product"])
    );
  }

  static fromJsonString(String x) => new List<OrderLine>.from(
      json.decode(x).map((j) => OrderLine.fromJson(j)).toList());

  static Map<String, dynamic> currentOrdertoJson() => {
        "id": currentOrderLines?.id,
        "order_id": currentOrderLines?.order_id,
        "price": currentOrderLines?.price,
        "quantity": currentOrderLines?.quantity,
        "product_id": currentOrderLines?.product_id,
        "description": currentOrderLines?.description,
        "customization": currentOrderLines?.customization,
        "created_at": currentOrderLines?.created_at.toIso8601String(),
      };

  static Future<List<OrderLine>> getAllFromOrderId(order_id) async {
    try {
      var x = await apiRequest("v1/order-line/order/$order_id", "GET");
      print(x);
      x = OrderLine.fromJsonString(x);
      orderLines = x;
      return x;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
