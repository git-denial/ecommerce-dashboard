import 'package:admin/models/Authentication.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/user/User%20List/userList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../../../controllers/MenuController.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
           DrawerListTile(
            title: "Users",
            svgSrc:  Icon(Icons.person),
            index: 0,
            press: () {
              Navigator.of(context).pushNamed(pageRoutes.userList);
              setState(() {
                MenuController.index = 0;
              });
              },
           
          ),

          DrawerListTile(
            title: "Administrators",
            svgSrc: Icon(Icons.add_moderator_outlined),
            index: 1,
            press: () {
              Navigator.of(context).pushNamed(pageRoutes.adminList);
              setState(() {
                MenuController.index = 1;
              });
              },
            
          ),
         
          DrawerListTile(
            title: "Products",
            svgSrc: Icon(Icons.shop),
            index: 2,
            press: () {
              Navigator.of(context).pushNamed(pageRoutes.productList);
              setState(() {
                MenuController.index = 2;
              });
              },
          ),
          DrawerListTile(
            title: "Orders",
            svgSrc: Icon(Icons.inventory),
            index: 3,
            press: () {
              Navigator.of(context).pushNamed(pageRoutes.orderList);
              setState(() {
                MenuController.index = 3;
              });
              },
          ),
          ListTile(
                title: Text("Log Out"),
                trailing: Icon(Icons.logout),
                hoverColor:  Colors.red,
                onTap: () {
                  Authentication.logout();
                  Navigator.of(context).popAndPushNamed(pageRoutes.login);
                },
              ),
          
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.index,
  }) : super(key: key);

  final String title;
  final Icon svgSrc;
  final VoidCallback press;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: MenuController.getIndex == index? Colors.indigo   : Colors.transparent,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: svgSrc,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
