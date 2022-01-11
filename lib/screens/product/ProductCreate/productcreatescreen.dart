import 'package:admin/responsive.dart';
import 'package:admin/screens/product/ProductCreate/productCreate.dart';
import 'package:flutter/material.dart';
import '../../../side_menu.dart';

class ProductCreateScreen extends StatelessWidget {
  final int? id;
  ProductCreateScreen({this.id});
  static const String routeName = 'ProductCreate';
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
              child: ProductCreate(),
            ),
          ],
        ),
      ),
    );
  }
}
