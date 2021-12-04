import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/User%20List/userList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../../../controllers/MenuController.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);


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
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {Navigator.of(context).pushNamed(pageRoutes.userList);},
            // press: () {Navigator.pushReplacementNamed(context, pageRoutes.goTo[UserListScreen.routeName]);},
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {Navigator.of(context).pushNamed(pageRoutes.dashboard);},
            // press: () {Navigator.pushReplacementNamed(context, pageRoutes.goTo[DashboardScreen.routeName]);},
          ),
         
          DrawerListTile(
            title: "Products",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
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
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
