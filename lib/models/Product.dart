import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../API.dart';
import '../models/Authentication.dart';

class Product {
  
  final int id;
  String name;
  num price;
  String? category;
  String? description;
  String size;
  String? size_description;
  num weight;
  String? main_photo_url;
  List<String>? photos;
  bool available;
  bool active;
  final DateTime created_at;
  final DateTime? modified_at;
  Product({
    required this.id,
    required this.name,
    required this.price,
    this.category,
    this.description,
    required this.size,
    this.size_description,
    required this.weight,
    this.main_photo_url,
    this.photos,
    required this.available,
    required this.active,
    required this.created_at,
    this.modified_at,
  });
  static Product? currentProduct;
  static List<Product> products = [];

 

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      size: json['size'],
      weight: json['weight'],
      available: json['available'],
      active: json['active'],
      created_at: DateTime.parse(json['created_at']),
      modified_at: json['modified_at'] == null? null: DateTime.parse(json['modified_at']),
      category: json['category'] ?? null,
      description: json['description'] ?? null,
      main_photo_url: json['main_photo_url'] ?? null,
      photos: json['photos'] ?? null,
    );
  }

  static fromJsonString(String x) =>
      new List<Product>.from(json.decode(x).map((j) => Product.fromJson(j)).toList());

  static Map<String, dynamic> currentProducttoJson() => {
    "id": currentProduct?.id,
      "name": currentProduct?.name,
      "price": currentProduct?.price,
      "size": currentProduct?.size,
      "weight": currentProduct?.weight,
      "available": currentProduct?.available,
      "active": currentProduct?.active,
      "created_at": currentProduct?.created_at.toIso8601String(),
      "modified_at": currentProduct?.modified_at?.toIso8601String(),
      "category": currentProduct?.category ?? null,
      "description": currentProduct?.description ?? null,
      "main_photo_url": currentProduct?.main_photo_url ?? null,
      "photos": currentProduct?.photos ?? null,
      };

  static Future<List<Product>> getAll() async {
  try {
    var x = await apiRequest("v1/product", "GET");
    print(x);
    x = Product.fromJsonString(x);
    products = x;
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}

Future<void> getById(id) async {
  try {
    var x = await apiRequest("v1/product/$id", "GET");
    x = Product.fromJsonString(x);
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
    var x = await apiRequest("v1/product/$id", "PUT",body:body);
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}


  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, category: $category, description: $description, size: $size, size_description: $size_description, weight: $weight, main_photo_url: $main_photo_url, photos: $photos, available: $available, active: $active, created_at: $created_at, modified_at: $modified_at)';
  }
}
