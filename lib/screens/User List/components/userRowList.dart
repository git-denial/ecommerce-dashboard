import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/User.dart';
import 'package:admin/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class UserRows extends StatelessWidget {
  const UserRows({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List users = User.fromJsonString(jsonUsers);
	//List xxx = List.generate(users.length,(index) => (users[index]));
	//print(xxx);
    debugPrint(users[0].email);
    // json.decode(users).forEach((element) {
    //   debugPrint(element['email']);
    //   });
    //User.fromJsonString(jsonUsers).forEach((e)=>debugPrint(e.toString()));
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
            "User List",
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
                  label: Text("Full Name"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("City"),
                ),
                DataColumn(
                  label: Text("Province"),
                ),
                DataColumn(
                  label: Text("ZIP Code"),
                ),
                DataColumn(
                  label: Text("Created at"),
                ),
                DataColumn(
                  label: Text("Modified at"),
                ),
              ],
              rows: List.generate(users.length,(index) => userDataRow(users[index],context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow userDataRow(User user, context) {
	print(user);
	print(user.email);
	print("HOI");
  return DataRow(
    cells: [
      DataCell(Text(user.id.toString())),
	    DataCell(Text(user.full_name)),
      DataCell(Text(user.email)),
      DataCell(Text(user.city ?? "")),
      DataCell(Text(user.province ?? "")),
      DataCell(Text(user.zip_code ?? "")),
      DataCell(Text(user.created_at.toString())),
      DataCell(Text(user.modified_at.toString()))
    ],
    onSelectChanged: (bool? value) {
              Navigator.of(context).pushNamed(pageRoutes.userDetails);
              User.currentUser = user;
            }
    
  );
}
