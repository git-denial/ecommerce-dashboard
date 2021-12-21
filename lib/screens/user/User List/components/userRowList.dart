import 'dart:convert';

import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/User.dart';
import 'package:admin/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../dialogAlert.dart';
import '../../../../error.dart';

class UserRows extends StatefulWidget {
  UserRows({
    Key? key,
  }) : super(key: key);

  @override
  _UserRowsState createState() => _UserRowsState();
}

var f  =  NumberFormat.currency(symbol: "Rp ");

class _UserRowsState extends State<UserRows> {
  String colindex = "ID";
  bool _sortAsc = true;
  bool enabled_user = true;

  Widget build(BuildContext context) {
    List<User> users =
        User.users.where((element) => element.enabled == enabled_user).toList();

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User List",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
            children: [
              Text(
                "Sort mode: ${_sortAsc ? 'Ascending' : 'Descending'}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Switch(
                value: _sortAsc,
                onChanged: (value) {
                  setState(() {
                    _sortAsc = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
          DefaultTabController(
            // The number of tabs / content sections to display.
            length: 2,
            child: // TabBar(
                TabBar(
                    tabs: [
                  Tab(
                    icon: Icon(Icons.verified),
                    text: "Enaled users",
                  ),
                  Tab(
                      icon: Icon(Icons.disabled_by_default),
                      text: "Disabled users"),
                ],
                    onTap: (v) {
                      enabled_user = v == 0;
                      setState(() {});
                    }),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              showCheckboxColumn: false,
              columnSpacing: defaultPadding,
              dataRowHeight: 100,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("ID"),
                  onSort: (columnIndex, ascending) {
                    User.users.sort((a, b) => a.id.compareTo(b.id));

                    if (!_sortAsc) {
                      User.users = users.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Full Name"),
                  onSort: (columnIndex, ascending) {
                    User.users
                        .sort((a, b) => a.full_name.compareTo(b.full_name));

                    if (!_sortAsc) {
                      User.users = users.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Email"),
                  onSort: (columnIndex, ascending) {
                    User.users.sort((a, b) => a.email.compareTo(b.email));

                    if (!_sortAsc) {
                      User.users = users.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                if (enabled_user)
                  DataColumn(
                    label: Text("City"),
                    onSort: (columnIndex, ascending) {
                      User.users.sort((a, b) => a.city == null
                          ? b.city == null
                              ? 0
                              : 1
                          : b.city == null
                              ? -1
                              : a.city!.compareTo(b.city!));

                      if (!_sortAsc) {
                        User.users = users.reversed.toList();
                      }
                      setState(() {});
                    },
                  ),
                if (enabled_user)
                  DataColumn(
                    label: Text("Province"),
                    onSort: (columnIndex, ascending) {
                      User.users.sort((a, b) => a.province == null
                          ? b.province == null
                              ? 0
                              : 1
                          : b.province == null
                              ? -1
                              : a.province!.compareTo(b.province!));

                      if (!_sortAsc) {
                        User.users = users.reversed.toList();
                      }
                      setState(() {});
                    },
                  ),
                if (enabled_user)
                  DataColumn(
                    label: Text("ZIP Code"),
                    onSort: (columnIndex, ascending) {
                      User.users.sort((a, b) => a.zip_code == null
                          ? b.zip_code == null
                              ? 0
                              : 1
                          : b.zip_code == null
                              ? -1
                              : a.zip_code!.compareTo(b.zip_code!));

                      if (!_sortAsc) {
                        User.users = users.reversed.toList();
                      }
                      setState(() {});
                    },
                  ),
                DataColumn(
                  label: Text("Credit"),
                  onSort: (columnIndex, ascending) {
                    User.users.sort((a, b) => a.credit.compareTo(b.credit));

                    if (!_sortAsc) {
                      User.users = users.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Created at"),
                  onSort: (columnIndex, ascending) {
                    User.users
                        .sort((a, b) => a.created_at.compareTo(b.created_at));

                    if (!_sortAsc) {
                      User.users = users.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Modified at"),
                  onSort: (columnIndex, ascending) {
                    User.users.sort((a, b) => a.modified_at == null
                        ? b.modified_at == null
                            ? 0
                            : 1
                        : b.modified_at == null
                            ? -1
                            : a.modified_at!.compareTo(b.modified_at!));

                    if (!_sortAsc) {
                      User.users = users.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                if (!enabled_user)
                  DataColumn(
                    label: Text("Restore"),
                  ),
              ],
              rows: List.generate(
                users.length,
                (index) => userDataRow(users[index], enabled_user, context, () {
                  setState(() {});
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow userDataRow(User user, enabled, context, setState) {
  return DataRow(
      cells: [
        DataCell(Text(user.id.toString())),
        DataCell(Text(user.full_name)),
        DataCell(Text(user.email)),
        if (enabled) DataCell(Text(user.city ?? "")),
        if (enabled) DataCell(Text(user.province ?? "")),
        if (enabled) DataCell(Text(user.zip_code ?? "")),
        DataCell(Text(f.format(user.credit))),
        DataCell(Text(user.created_at.toString())),
        DataCell(Text(user.modified_at.toString())),
        if (!enabled)
          DataCell(ElevatedButton(
              onPressed: () async {
                try {
                  var res = await User.restore(user.id);

                  String title = "Success";
                  String content = "User restored successfully";
                  Navigator.popAndPushNamed(
                                  context, pageRoutes.userList);
                  showDialogAlert(context, title, content);
                } catch (e) {
                  var err = HTTPErrorType.fromJson(json.decode(e.toString()));
                  var errObject = err.generateAlertitleContent();
                  String title = errObject['title']!;
                  String content = errObject['content']!;
                  showDialogAlert(context, title, content);
                }
                
              },
              child: Text("Restore")))
      ],
      onSelectChanged: (bool? value) {
        Navigator.of(context)
            .pushNamed('${pageRoutes.userDetails}', arguments: user.id);
        User.currentUser = user;
      });
}
