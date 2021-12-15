import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Admin.dart';
import 'package:admin/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class AdminRows extends StatelessWidget {
   AdminRows({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<Admin> admins = Admin.admins;
    print(admins);
	//List xxx = List.generate(admins.length,(index) => (admins[index]));
	//print(xxx);
    // json.decode(admins).forEach((element) {
    //   debugPrint(element['email']);
    //   });
    //Admin.fromJsonString(jsonAdmins).forEach((e)=>debugPrint(e.toString()));
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
            "Admin List",
            style: Theme.of(context).textTheme.subtitle1,
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
                ),
                DataColumn(
                  label: Text("Username"),
                ),
              
                DataColumn(
                  label: Text("Created at"),
                ),
                DataColumn(
                  label: Text("Modified at"),
                ),
              ],
              rows: List.generate(admins.length,(index) => adminDataRow(admins[index],context),
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
              Navigator.of(context).pushNamed('${pageRoutes.adminDetails}',arguments: admin.id);
              Admin.currentAdmin = admin;
            }
    
  );
}
