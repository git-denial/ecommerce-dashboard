import 'package:admin/models/User.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../side_menu.dart';

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
                  Navigator.pop(context);
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
                    subtitle: const Text("Name",style: TextStyle(color: Colors.white,)),
                    title: new TextField(
                      controller: TextEditingController(
                          text: User.currentUser?.full_name),
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.email),
                    subtitle: const Text("Email",style: TextStyle(color: Colors.white,)),
                    title: new TextField(
                      controller:
                          TextEditingController(text: User.currentUser?.email),
                      decoration: new InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("City",style: TextStyle(color: Colors.white,)),
                    leading: const Icon(Icons.location_city),
                    title: new TextField(
                      controller:
                          TextEditingController(text: User.currentUser?.city),
                      decoration: new InputDecoration(
                        hintText: "City",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Province",style: TextStyle(color: Colors.white,)),
                    leading: const Icon(Icons.place),
                    title: new TextField(
                      controller: TextEditingController(
                          text: User.currentUser?.province),
                      decoration: new InputDecoration(
                        hintText: "Province",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("ZIP Code",style: TextStyle(color: Colors.white,)),
                    leading: const Icon(Icons.code),
                    title: new TextField(
                      controller: TextEditingController(
                          text: User.currentUser?.zip_code),
                      decoration: new InputDecoration(
                        hintText: "ZIP Code",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Phone Number",style: TextStyle(color: Colors.white,)),
                    leading: const Icon(Icons.phone),
                    title: new TextField(
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
                          onPressed: () {
                            User.update(User.currentUser!.id,{""});
                          }),
                      SizedBox(width: 50),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary:Colors.red),
                          child: const Text("Delete"),
                          onPressed: () {
                            Navigator.pop(context);
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
