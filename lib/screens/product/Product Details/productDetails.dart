import 'dart:convert';
import 'dart:html';
import 'package:admin/models/Product.dart';
import 'package:admin/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
  }) : super(key: key);
  

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
                  Navigator.popAndPushNamed(
                                  context, pageRoutes.productList);
                }),
            Text(
              "Product Details",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Image.network(Product.currentProduct?.main_photo_url ?? "https://martialartsplusinc.com/wp-content/uploads/2017/04/default-image-620x600.jpg"),

                lisTile(icon: Icons.text_format, subtitle: "Name", 
                textControl: TextEditingController(text: Product.currentProduct?.name),
                onChanged: (v){Product.currentProduct?.name = v;},),

                lisTile(icon: Icons.local_offer, subtitle: "Price", 
                textControl:  TextEditingController(text: Product.currentProduct?.price.toString()),
                onChanged: (v){Product.currentProduct?.price =  num.parse(v);},),
                
                lisTile(icon: Icons.category, subtitle: "Category", 
                textControl: TextEditingController(text: Product.currentProduct?.category),
                onChanged: (v){Product.currentProduct?.category = v;},),

                lisTile(icon: Icons.description, subtitle: "Description", 
                textControl: TextEditingController(text: Product.currentProduct?.description),
                onChanged: (v){Product.currentProduct?.description = v;},),

                lisTile(icon: Icons.luggage, subtitle: "Weight", 
                textControl:  TextEditingController(text: Product.currentProduct?.weight.toString()),
                onChanged: (v){Product.currentProduct?.weight =  num.parse(v);},),

                lisTile(icon: Icons.code, subtitle: "Main photo URL", 
                textControl: TextEditingController(text: Product.currentProduct?.main_photo_url),
                onChanged: (v){Product.currentProduct?.main_photo_url = v;},),

                Text("Available"),
                Switch(
                value: Product.currentProduct?.available ?? false,
                onChanged: (value) {
                  setState(() {
                    Product.currentProduct?.available = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
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
                            setState(() {
                              
                            });

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
          ],
        ),
      ),
    );
  }
}

class lisTile extends StatelessWidget {
  final IconData icon;
  final  String subtitle;
  final FunctionStringCallback onChanged;
  final TextEditingController textControl;

  const lisTile({
    Key? key,
    required this.icon, required this.subtitle, required this.onChanged, required this.textControl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Icon(icon),
      subtitle:  Text(subtitle,
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
