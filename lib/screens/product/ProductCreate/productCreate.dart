import 'dart:convert';
import 'dart:html';
import 'package:admin/models/Product.dart';
import 'package:admin/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';

class ProductCreate extends StatefulWidget {
  const ProductCreate({
    Key? key,
  }) : super(key: key);

  @override
  _ProductCreateState createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController main_photo_url = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                child: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.popAndPushNamed(context, pageRoutes.productList);
                }),
            Text(
              "Product Create",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Image.network(Product.currentProduct?.main_photo_url ??
                    "https://martialartsplusinc.com/wp-content/uploads/2017/04/default-image-620x600.jpg"),
                lisTile(
                  icon: Icons.text_format,
                  subtitle: "Name",
                  textControl:
                      name,
                  onChanged: (v) {
                    Product.currentProduct?.name = v;
                  },
                ),
                lisTile(
                  icon: Icons.local_offer,
                  subtitle: "Price",
                  textControl: price,
                  onChanged: (v) {
                    Product.currentProduct?.price = num.parse(v);
                  },
                ),
                lisTile(
                  icon: Icons.category,
                  subtitle: "Category",
                  textControl: category,
                  onChanged: (v) {
                    Product.currentProduct?.category = v;
                  },
                ),
                lisTile(
                  icon: Icons.description,
                  subtitle: "Description",
                  textControl: description,
                  onChanged: (v) {
                    Product.currentProduct?.description = v;
                  },
                ),
                lisTile(
                  icon: Icons.luggage,
                  subtitle: "Weight",
                  textControl: weight,
                  onChanged: (v) {
                    Product.currentProduct?.weight = num.parse(v);
                  },
                ),
                lisTile(
                  icon: Icons.code,
                  subtitle: "Main photo URL",
                  textControl: main_photo_url,
                  onChanged: (v) {
                    Product.currentProduct?.main_photo_url = v;
                  },
                ),
                const Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        child: const Text("Create"),
                        onPressed: () async {
                          Map<String, dynamic> x = {
                            "name": name.text,
                            "price": price.text,
                            "weight": weight.text,
                            "category": category.text,
                            "description": description.text,
                            "main_photo_url": main_photo_url.text == "" ? null : main_photo_url.text ,
                          };
                          try {
                            var res = await Product.create(x);

                            String title = "Success";
                            String content = "Product created successfully";
                            setState(() {});

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
          ],
        ),
      ),
    );
  }
}

class lisTile extends StatelessWidget {
  final IconData icon;
  final String subtitle;
  final FunctionStringCallback onChanged;
  final TextEditingController textControl;

  const lisTile(
      {Key? key,
      required this.icon,
      required this.subtitle,
      required this.onChanged,
      required this.textControl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Icon(icon),
      subtitle: Text(subtitle,
          style: TextStyle(
            color: Colors.white,
          )),
      title: new TextField(
        onChanged: onChanged,
        controller: textControl,
        decoration: new InputDecoration(
          hintText: subtitle,
        ),
      ),
    );
  }
}
