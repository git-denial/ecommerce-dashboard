import 'package:admin/responsive.dart';
import 'package:admin/screens/product/Product%20Details/productDetails.dart';
import 'package:flutter/material.dart';
import '../../../side_menu.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int? id;
  ProductDetailsScreen({this.id});
  static const String routeName = 'ProductDetails';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: ProductDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
