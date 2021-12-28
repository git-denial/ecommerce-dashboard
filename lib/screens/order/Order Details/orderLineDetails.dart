import 'dart:convert';
import 'dart:html';
import 'package:admin/models/Order.dart';
import 'package:admin/models/OrderLines.dart';
import 'package:admin/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';

class OrderLinesDetails extends StatefulWidget {
  static const String routeName = 'OrderLineDetails';
  const OrderLinesDetails({
    Key? key,
  }) : super(key: key);

  @override
  _OrderLinesDetailsState createState() => _OrderLinesDetailsState();
}

class _OrderLinesDetailsState extends State<OrderLinesDetails> {
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
                  Navigator.of(context).pop();
                }),
            Text(
              "OrderLines Details",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(Order.currentOrder?.order_line?.length ?? 0, (index){
                    var curorder = Order.currentOrder?.order_line?[index];
                    return tester(curorder?.product?.name, curorder?.product?.main_photo_url, curorder?.quantity,curorder?.price,curorder?.description,curorder?.customization);
                  }),
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

  const lisTile(
      {Key? key,
      required this.icon,
      required this.subtitle,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Icon(icon),
      subtitle: Text(subtitle,
          style: TextStyle(
            color: Colors.white,
          )),
      title: Text(subtitle)
    );
  }
}

Widget dropdown(dropdownValue, choices, onChanged) {
  return DropdownButton<String>(
    value: dropdownValue,
    icon: const Icon(Icons.arrow_downward),
    elevation: 16,
    style: const TextStyle(color: Colors.white),
    underline: Container(
      height: 2,
      color: Colors.white,
    ),
    onChanged: onChanged,
    items: choices.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget orderLineCard (product_name,quantity,price,customization,description){
  return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Text(product_name),
              title: Text(quantity.toString()),
              subtitle:Text(price.toString()) ,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     TextButton(
            //       child: const Text('BUY TICKETS'),
            //       onPressed: () {/* ... */},
            //     ),
            //     const SizedBox(width: 8),
            //     TextButton(
            //       child: const Text('LISTEN'),
            //       onPressed: () {/* ... */},
            //     ),
            //     const SizedBox(width: 8),
            //   ],
            // ),
          ],
        ),
      );
}

Widget tester(productName,imageUrl,quantity,price,description,customization){
  return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text(productName),
                  subtitle: Text(
                    "Quantity: " + quantity.toString(),
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Price: ${price.toString()} ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Image.network(imageUrl?? "https://martialartsplusinc.com/wp-content/uploads/2017/04/default-image-620x600.jpg",height: 300,width: 300),
                
              ],
            ),
          );
}
