import 'package:admin/responsive.dart';
import 'package:admin/screens/admin/Admin%20Details/adminDetails.dart';
import 'package:flutter/material.dart';
import '../../../side_menu.dart';

class AdminDetailsScreen extends StatelessWidget {
  final int? id;
  AdminDetailsScreen({this.id});
  static const String routeName = 'Admin Details';
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
              child: AdminDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
