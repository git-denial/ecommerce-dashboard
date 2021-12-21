import 'dart:convert';
import 'dart:html';
import 'package:admin/models/Order.dart';
import 'package:admin/routes.dart';
import 'package:admin/screens/admin/Admin%20List/components/adminRowList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../dialogAlert.dart';
import '../../../constants.dart';
import '../../../error.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
                  Navigator.popAndPushNamed(context, pageRoutes.orderList);
                }),
            Text(
              "Order Details",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                lisTile(
                  icon: Icons.local_offer,
                  subtitle: "Price sum",
                  textControl: TextEditingController(
                      text: Order.currentOrder?.price_sum.toString()),
                  onChanged: (v) {
                    Order.currentOrder?.price_sum = num.parse(v);
                  },
                ),
                lisTile(
                  icon: Icons.location_history,
                  subtitle: "Address Info",
                  textControl: TextEditingController(
                      text: Order.currentOrder?.address_info),
                  onChanged: (v) {
                    Order.currentOrder?.address_info = v;
                  },
                ),
                lisTile(
                  icon: Icons.description,
                  subtitle: "City code",
                  textControl: TextEditingController(
                      text: Order.currentOrder?.city_code),
                  onChanged: (v) {
                    Order.currentOrder?.city_code = v;
                  },
                ),
                lisTile(
                  icon: Icons.description,
                  subtitle: "Zip code",
                  textControl:
                      TextEditingController(text: Order.currentOrder?.zip_code),
                  onChanged: (v) {
                    Order.currentOrder?.zip_code = v;
                  },
                ),
                ListTile(
                    leading: new Icon(Icons.star_outline_sharp),
                    subtitle: Text("Shipment status",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    title: dropdown(Order.currentOrder?.shipment_status,
                        ShipmentStateStrings, (newValue) {
                      Order.currentOrder?.shipment_status = newValue ?? "";
                      setState(() {});
                    })),
                ListTile(
                    leading: new Icon(Icons.star_outline_sharp),
                    subtitle: Text("Delivery method",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    title: dropdown(Order.currentOrder?.delivery_method,
                        delivery_methodStrings, (newValue) {
                      Order.currentOrder?.delivery_method = newValue ?? "";
                      setState(() {});
                    })),
                lisTile(
                  icon: Icons.description,
                  subtitle: "Delivery service",
                  textControl: TextEditingController(
                      text: Order.currentOrder?.delivery_service),
                  onChanged: (v) {
                    Order.currentOrder?.delivery_service = v;
                  },
                ),
                lisTile(
                  icon: Icons.description,
                  subtitle: "Delivery fee",
                  textControl: TextEditingController(
                      text: Order.currentOrder?.delivery_fee.toString()),
                  onChanged: (v) {
                    Order.currentOrder?.delivery_fee = num.parse(v);
                  },
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
                            var res = await Order.update(Order.currentOrder?.id,
                                Order.currentOrdertoJson());

                            String title = "Success";
                            String content = "Order updated successfully";
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
