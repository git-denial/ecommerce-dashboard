import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Admin.dart';
import 'package:admin/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class AdminRows extends StatefulWidget {
  AdminRows({
    Key? key,
  }) : super(key: key);

  @override
  _AdminRowsState createState() => _AdminRowsState();
}

class _AdminRowsState extends State<AdminRows> {
  String colindex = "ID";
  bool _sortAsc = true;
  @override
  Widget build(BuildContext context) {
    List<Admin> admins = Admin.admins;
    print(admins);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //dropdown(colindex, (v){setState((){colindex = v;});} ),
          Text(
            "Admin List",
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
              sortAscending: true,
              showCheckboxColumn: false,
              columnSpacing: defaultPadding,
              dataRowHeight: 100,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("ID"),
                   onSort: (columnIndex, ascending) {
                    Admin.admins.sort((a, b) => a.id.compareTo(b.id));
                    
                    if (!_sortAsc) {
                      Admin.admins = admins.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Username"),
                  onSort: (columnIndex, ascending) {
                    Admin.admins.sort((a, b) => a.username.compareTo(b.username));
                    
                    if (!_sortAsc) {
                      Admin.admins = admins.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Created at"),
                   onSort: (columnIndex, ascending) {
                    Admin.admins.sort((a, b) => a.created_at.compareTo(b.created_at));
                    
                    if (!_sortAsc) {
                      Admin.admins = admins.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
                DataColumn(
                  label: Text("Modified at"),
                  onSort: (columnIndex, ascending) {
                    Admin.admins.sort((a, b) => a.modified_at == null? b.modified_at == null? 0 : 1 : b.modified_at == null? -1 : a.modified_at!.compareTo(b.modified_at!));
                    
                    if (!_sortAsc) {
                      Admin.admins = admins.reversed.toList();
                    }
                    setState(() {
                      
                    });
                  },
                ),
              ],
              rows: List.generate(
                admins.length,
                (index) => adminDataRow(admins[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow adminDataRow(Admin admin, context) {
  return DataRow(
      cells: [
        DataCell(Text(admin.id.toString())),
        DataCell(Text(admin.username)),
        DataCell(Text(admin.created_at.toString())),
        DataCell(Text(admin.modified_at.toString()))
      ],
      onSelectChanged: (bool? value) {
        Navigator.of(context)
            .pushNamed('${pageRoutes.adminDetails}', arguments: admin.id);
        Admin.currentAdmin = admin;
      });
}
Widget dropdown(dropdownValue, setState){
  print(dropdownValue);
return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        
        setState(newValue);
        
      },
      items: <String>['ID', 'Username', 'Created at', 'Modified at']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
}