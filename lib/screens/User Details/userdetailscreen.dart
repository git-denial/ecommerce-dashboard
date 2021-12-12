import 'package:admin/responsive.dart';
import 'package:admin/screens/User%20Details/userDetails.dart';
import 'package:flutter/material.dart';
import '../../side_menu.dart';

class UserDetailsScreen extends StatelessWidget {
  final int? id;
  UserDetailsScreen({this.id});
  static const String routeName = 'User Details';
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
              child: UserDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
