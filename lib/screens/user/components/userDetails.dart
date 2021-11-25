import 'dart:convert';

import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/User.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_back),
          Text(
            "User Details",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.person),
                  title: new TextField(
                    controller: TextEditingController(text: User.currentUser?.full_name ),
                    decoration: new InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.email),
                  title: new TextField(
                    controller: TextEditingController(text: User.currentUser?.email ),
                    decoration: new InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_city),
                  title: new TextField(
                    controller: TextEditingController(text: User.currentUser?.city ),
                    decoration: new InputDecoration(
                      hintText: "City",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.place),
                  title: new TextField(
                    controller: TextEditingController(text: User.currentUser?.province ),
                    decoration: new InputDecoration(
                      hintText: "Province",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.code),
                  title: new TextField(
                    controller: TextEditingController(text: User.currentUser?.zip_code ),
                    decoration: new InputDecoration(
                      hintText: "ZIP Code",
                    ),
                  ),
                ),
                
                const Divider(
                  height: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(User user, context) {
  print(user);
  print(user.email);
  print("HOI");
  return DataRow(
      cells: [
        DataCell(Text(user.id.toString())),
        DataCell(Text(user.full_name)),
        DataCell(Text(user.email)),
        DataCell(Text(user.city ?? "")),
        DataCell(Text(user.province ?? "")),
        DataCell(Text(user.created_at.toString())),
        DataCell(Text(user.modified_at.toString()))
      ],
      onSelectChanged: (bool? value) {
        Provider.of<MenuController>(context, listen: false)
            .changePage(DashboardScreen.routeName);
      });
}
