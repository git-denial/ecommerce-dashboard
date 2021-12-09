import 'package:admin/models/User.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/User%20List/components/userRowList.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../side_menu.dart';
import '../../header.dart';

class UserListScreen extends StatefulWidget {
  static String routeName = 'User List';

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      User.users = await User.getAll();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
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
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(),
                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                SizedBox(height: defaultPadding),
                                FutureBuilder(
                                    future: User.getAll(),
                                    builder: (ctx, snapshot) {
                                      return UserRows();
                                    }),
                                if (Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding),
                                // if (Responsive.isMobile(context)) StarageDetails(),
                              ],
                            ),
                          ),
                          if (!Responsive.isMobile(context))
                            SizedBox(width: defaultPadding),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
