import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Product.dart';
import 'package:admin/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class ProductRows extends StatefulWidget {
   ProductRows({
    Key? key,
  }) : super(key: key);

  @override
  _ProductRowsState createState() => _ProductRowsState();
}

class _ProductRowsState extends State<ProductRows> {
  String colindex = "ID";
  bool _sortAsc = true;
  @override
  Widget build(BuildContext context) {
    List<Product> products = Product.products;

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
            "Product List",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
             children: [
               Text(
                "Sort mode: ${_sortAsc? 'Ascending' : 'Descending' }",
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
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              showCheckboxColumn: false,
              columnSpacing: defaultPadding,
			        dataRowHeight:100,
              minWidth: 600,
              columns: [
				DataColumn(
                  label: Text("ID"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.id.compareTo(b.id));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Name"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.name.compareTo(b.name));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Price"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.price.compareTo(b.price));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Category"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.category == null? b.category == null? 0 : 1 : b.category == null? -1 : a.category!.compareTo(b.category!));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
               
                 DataColumn(
                  label: Text("Weight"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.weight.compareTo(b.weight));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Available"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, c) => c.available? 1 : -1);
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Created at"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.created_at.compareTo(b.created_at));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Modified at"),
                  onSort: (columnIndex, ascending) {
                    Product.products.sort((a, b) => a.modified_at == null? b.modified_at == null? 0 : 1 : b.modified_at == null? -1 : a.modified_at!.compareTo(b.modified_at!));
                    
                    if (!_sortAsc) {
                      Product.products = products.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
              ],
              rows: List.generate(products.length,(index) => productDataRow(products[index],context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productDataRow(Product product, context) {
  return DataRow(
    cells: [
      DataCell(Text(product.id.toString())),
	    DataCell(Text(product.name)),
      DataCell(Text(product.price.toString())),
      DataCell(Text(product.category ?? "")),
      DataCell(Text(product.weight.toString())),
      DataCell(Text(product.available.toString())),
      DataCell(Text(product.created_at.toString())),
      DataCell(Text(product.modified_at.toString()))
    ],
    onSelectChanged: (bool? value) {
              Navigator.of(context).pushNamed('${pageRoutes.productDetails}', arguments: product.id);
              Product.currentProduct = product;
            }
    
  );
}
