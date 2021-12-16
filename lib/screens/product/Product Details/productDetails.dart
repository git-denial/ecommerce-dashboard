import 'dart:convert';

import 'package:admin/models/Product.dart';
import 'package:admin/routes.dart';
import 'package:admin/screens/product/Product%20List/productList.dart';
import 'package:flutter/material.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';
import '../../../side_menu.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
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
                                  context, pageRoutes.productList);
                }),
            Text(
              "Product Details",
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
                      onChanged: (v){Product.currentProduct?.name = v;},
                      controller: TextEditingController(
                          text: Product.currentProduct?.name),
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.email),
                    subtitle: const Text("Price",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    title: new TextField(
                      onChanged: (v){Product.currentProduct?.price =  num.parse(v);},
                      controller:
                          TextEditingController(text: Product.currentProduct?.price.toString()),
                      decoration: new InputDecoration(
                        hintText: "Price",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Category",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.location_city),
                    title: new TextField(
                      onChanged: (v){Product.currentProduct?.category = v;},
                      controller:
                          TextEditingController(text: Product.currentProduct?.category),
                      decoration: new InputDecoration(
                        hintText: "Category",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Description",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.place),
                    title: new TextField(
                      onChanged: (v){Product.currentProduct?.description = v;},
                      controller: TextEditingController(
                          text: Product.currentProduct?.description),
                      decoration: new InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Weight",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.phone),
                    title: new TextField(
                      onChanged: (v){Product.currentProduct?.weight = num.parse(v);},
                      controller: TextEditingController(
                          text: Product.currentProduct?.weight.toString()),
                      decoration: new InputDecoration(
                        hintText: "Weight",
                      ),
                    ),
                  ),
                  new ListTile(
                    subtitle: const Text("Main photo URL",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    leading: const Icon(Icons.phone),
                    title: new TextField(
                      onChanged: (v){Product.currentProduct?.main_photo_url = v;},
                      controller: TextEditingController(
                          text: Product.currentProduct?.main_photo_url),
                      decoration: new InputDecoration(
                        hintText: "Main photo URL",
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
                                  await Product.update(Product.currentProduct?.id, Product.currentProducttoJson());

                              String title = "Success";
                              String content = "Product updated successfully";

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
                              var res = await Product.delete(Product.currentProduct?.id);

                              String title = "Success";
                              String content = "Product deleted successfully";

                              Navigator.popAndPushNamed(
                                  context, pageRoutes.productList);
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
