import 'package:admin/screens/user/components/userDetails.dart';

import './screens/dashboard/dashboard_screen.dart';
import './screens/user/userList.dart';
class pageRoutes{

  static String dashboard = DashboardScreen.routeName;
  static String userList = UserListScreen.routeName;
  static String userDetails = 'User Details';
  
  static Map<String,dynamic> goTo = {
    DashboardScreen.routeName: DashboardScreen(),
    UserListScreen.routeName: UserListScreen(),
    'User Details': UserDetails()
  };
}