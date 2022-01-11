import 'package:admin/responsive.dart';
import 'package:admin/screens/admin/AdminCreate/adminCreate.dart';
import 'package:flutter/material.dart';
import '../../../side_menu.dart';

class AdminCreatesScreen extends StatelessWidget {
  final int? id;
  AdminCreatesScreen({this.id});
  static const String routeName = 'AdminCreate';
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
              child: AdminCreate(),
            ),
          ],
        ),
      ),
    );
  }
}
