import 'dart:convert';

import 'package:admin/models/User.dart';
import 'package:admin/screens/user/User%20List/userList.dart';
import 'package:flutter/material.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';
import '../../../side_menu.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
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
                                  context, UserListScreen.routeName);
                }),
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
                    subtitle: const Text("Name",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    title: new TextField(
                      onChanged: (v){User.currentUser?.full_name = v;},
                      controller: TextEditingController(
                          text: User.currentUser?.full_name),
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.email),
                    subtitle: const Text("Email",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    title: new TextField(
                      onChanged: (v){User.currentUser?.email = v;},
                      controller:
                          TextEditingController(text: User.currentUser?.email),
                      decoration: new InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("City",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.location_city),
                    title: new TextField(
                      onChanged: (v){User.currentUser?.city = v;},
                      controller:
                          TextEditingController(text: User.currentUser?.city),
                      decoration: new InputDecoration(
                        hintText: "City",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Province",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.place),
                    title: new TextField(
                      onChanged: (v){User.currentUser?.province = v;},
                      controller: TextEditingController(
                          text: User.currentUser?.province),
                      decoration: new InputDecoration(
                        hintText: "Province",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("ZIP Code",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.code),
                    title: new TextField(
                      onChanged: (v){User.currentUser?.zip_code = v;},
                      controller: TextEditingController(
                          text: User.currentUser?.zip_code),
                      decoration: new InputDecoration(
                        hintText: "ZIP Code",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Phone Number",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.phone),
                    title: new TextField(
                      onChanged: (v){User.currentUser?.phone_num = v;},
                      controller: TextEditingController(
                          text: User.currentUser?.phone_num),
                      decoration: new InputDecoration(
                        hintText: "Phone Number",
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
                                  await User.update(User.currentUser?.id, User.currentUsertoJson());

                              String title = "Success";
                              String content = "User updated successfully";

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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text("Delete"),
                          onPressed: () async {
                            try {
                              var res = await User.delete(User.currentUser?.id);

                              String title = "Success";
                              String content = "User deleted successfully";

                              Navigator.popAndPushNamed(
                                  context, UserListScreen.routeName);
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
