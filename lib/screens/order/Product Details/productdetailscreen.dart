import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../../../side_menu.dart';
import 'productDetails.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int? id;
  OrderDetailsScreen({this.id});
  static const String routeName = 'OrderDetails';
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
              child: OrderDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
