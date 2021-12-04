import 'package:admin/models/User.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../side_menu.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  static String routeName = 'User Details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
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
              onPressed: () {Navigator.pop(context);}
            )
            ,
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
      ),
    );
  }
}

