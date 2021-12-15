import 'dart:convert';

import 'package:admin/models/Admin.dart';
import 'package:admin/routes.dart';
import 'package:admin/screens/admin/Admin%20List/adminList.dart';
import 'package:flutter/material.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';
import '../../../side_menu.dart';

class AdminDetails extends StatelessWidget {
  const AdminDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                child: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.popAndPushNamed(
                                  context, pageRoutes.adminList);
                }),
            Text(
              "Admin Details",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.person),
                    subtitle: const Text("Username",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    title: new TextField(
                      onChanged: (v){Admin.currentAdmin?.username = v;},
                      controller: TextEditingController(
                          text: Admin.currentAdmin?.username),
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                 
                  const Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          child: const Text("Update"),
                          onPressed: () async {
                            try {
                              var res =
                                  await Admin.update(Admin.currentAdmin?.id, Admin.currentAdmintoJson());

                              String title = "Success";
                              String content = "Admin updated successfully";

                              showDialogAlert(context, title, content);
                            } catch (e) {
                              var err = HTTPErrorType.fromJson(
                                  json.decode(e.toString()));
                              var errObject = err.generateAlertitleContent();
                              String title = errObject['title']!;
                              String content = errObject['content']!;
                              showDialogAlert(context, title, content);
                            }
                          }),
                      SizedBox(width: 50),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
