import 'dart:convert';

import 'package:admin/controllers/MenuController.dart';
import 'package:admin/error.dart';
import 'package:admin/models/Authentication.dart';
import 'package:admin/models/Product.dart';
import 'package:admin/responsive.dart';
import 'package:admin/routes.dart';
import 'package:admin/screens/product/Product%20List/components/productRowList.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../side_menu.dart';
import '../../../header.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = 'ProductList';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    MenuController.index = 2;
    if(Authentication.token == null){
      Future.delayed(Duration.zero, () => Navigator.pushReplacementNamed(context, pageRoutes.login));
      return Text("");
    }
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
                                    future: Product.getAll(),
                                    builder: (ctx, snapshot) {
                                      if (snapshot.hasError) {
                                        var err = HTTPErrorType.fromJson(json
                                            .decode(snapshot.error.toString()));
                                        var errObject =
                                            err.generateAlertitleContent();
                                        String title = errObject['title']!;
                                        String content = errObject['content']!;
                                        Future.delayed(
                                            Duration.zero,
                                            () => _showDialog(
                                                context, title, content));
                                        //showDialog(context: context, builder: (BuildContext context) => errorDialog(context));
                                      }

                                      return ProductRows();
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

AlertDialog alert(context) {
  return AlertDialog(
    title: const Text('AlertDialog Title'),
    content: SingleChildScrollView(
      child: ListBody(
        children: const <Widget>[
          Text('This is a demo alert dialog.'),
          Text('Would you like to approve of this message?'),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Approve'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

void _showDialog(context, title, content) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new TextButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Dialog errorDialog(context) => Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Cool',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Awesome',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Got It!',
                  style: TextStyle(color: Colors.purple, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
