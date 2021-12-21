import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Order.dart';
import 'package:admin/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

var f = NumberFormat.currency(symbol: "Rp ");

class OrderRows extends StatefulWidget {
  OrderRows({
    Key? key,
  }) : super(key: key);

  @override
  _OrderRowsState createState() => _OrderRowsState();
}

class _OrderRowsState extends State<OrderRows> {
  String colindex = "ID";
  bool _sortAsc = true;
  ShipmentState shipmentStatus = ShipmentState.WAITING_CONFIRMATION;
  List<Order> orders = Order.orders;
  @override
  Widget build(BuildContext context) {
    orders = Order.orders.where((element) => element.shipment_status == shipmentStatus.toString().split('.').last).toList();

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order List",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
            children: [
              Text(
                "Sort mode: ${_sortAsc ? 'Ascending' : 'Descending'}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Switch(
                value: _sortAsc,
                onChanged: (value) {
                  setState(() {
                    _sortAsc = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
              
            ],
          ),
          DefaultTabController(
                // The number of tabs / content sections to display.
                length: 4,
                child: // TabBar(
                    TabBar(
                        tabs: [
                      Tab(
                        icon: Icon(Icons.pending),
                        text: ShipmentState.WAITING_CONFIRMATION.toString().split('.').last,
                      ),
                      Tab(
                          icon: Icon(Icons.pending_actions),
                          text: ShipmentState.PROCESSING.toString().split('.').last),
                      Tab(
                          icon: Icon(Icons.delivery_dining),
                          text: ShipmentState.DELIVERING.toString().split('.').last),
                      Tab(
                          icon: Icon(Icons.verified),
                          text: ShipmentState.ARRIVED.toString().split('.').last),
                    ],
                        onTap: (v) {
                          shipmentStatus = ShipmentState.values[v];
                          print(shipmentStatus);
                          orders = Order.orders.where((element) => element.shipment_status == shipmentStatus.toString().split('.').last).toList();
                          setState(() {});
                        }),
              ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              showCheckboxColumn: false,
              columnSpacing: 0,
              dataRowHeight: 100,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("ID"),
                  onSort: (columnIndex, ascending) {
                    Order.orders.sort((a, b) => a.id.compareTo(b.id));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Price_sum"),
                  onSort: (columnIndex, ascending) {
                    Order.orders
                        .sort((a, b) => a.price_sum.compareTo(b.price_sum));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Delivery method"),
                  onSort: (columnIndex, ascending) {
                    Order.orders.sort((a, b) =>
                        a.delivery_method.compareTo(b.delivery_method));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("User id"),
                  onSort: (columnIndex, ascending) {
                    Order.orders.sort((a, b) => a.user_id.compareTo(b.user_id));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Paid at"),
                  onSort: (columnIndex, ascending) {
                    Order.orders.sort((a, b) => a.paid_at == null
                        ? b.paid_at == null
                            ? 0
                            : 1
                        : b.paid_at == null
                            ? -1
                            : a.paid_at!.compareTo(b.paid_at!));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Created at"),
                  onSort: (columnIndex, ascending) {
                    Order.orders
                        .sort((a, b) => a.created_at.compareTo(b.created_at));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
                DataColumn(
                  label: Text("Modified at"),
                  onSort: (columnIndex, ascending) {
                    Order.orders.sort((a, b) => a.modified_at == null
                        ? b.modified_at == null
                            ? 0
                            : 1
                        : b.modified_at == null
                            ? -1
                            : a.modified_at!.compareTo(b.modified_at!));

                    if (!_sortAsc) {
                      Order.orders = Order.orders.reversed.toList();
                    }
                    setState(() {});
                  },
                ),
              ],
              rows: List.generate(
                orders.length,
                (index) => orderDataRow(orders[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow orderDataRow(Order order, context) {
  return DataRow(
      cells: [
        DataCell(Text(order.id.toString())),
        DataCell(Text(f.format(order.price_sum))),
        DataCell(Text(order.delivery_method)),
        DataCell(Text(order.user_id.toString())),
        DataCell(Text(order.paid_at.toString())),
        DataCell(Text(order.created_at.toString())),
        DataCell(Text(order.modified_at.toString()))
      ],
      onSelectChanged: (bool? value) {
        Navigator.of(context)
            .pushNamed('${pageRoutes.orderDetails}', arguments: order.id);
        Order.currentOrder = order;
      });
}
