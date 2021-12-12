import 'package:admin/screens/User%20Details/userdetailscreen.dart';
import 'package:flutter/material.dart';
import './screens/dashboard/dashboard_screen.dart';
import 'screens/User List/userList.dart';
class pageRoutes{

  static const String dashboard = DashboardScreen.routeName;
  static const String userList = UserListScreen.routeName;
  static const String userDetails = UserDetailsScreen.routeName;
  
  static Map<String,dynamic> goTo = {
    DashboardScreen.routeName: DashboardScreen(),
    UserListScreen.routeName: UserListScreen(),
    UserDetailsScreen.routeName: UserDetailsScreen()
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
  List<String> pathComponents = settings.name!.split('/');
  final Object? arguments = settings.arguments;
  print(settings.name);
  switch (pathComponents[0]) {
    case userDetails:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => UserDetailsScreen()
        );
    default:
      return MaterialPageRoute(builder: (context) => DashboardScreen());
  }
}
}