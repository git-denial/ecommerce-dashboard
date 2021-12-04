import 'package:admin/screens/User%20Details/userDetails.dart';
import './screens/dashboard/dashboard_screen.dart';
import 'screens/User List/userList.dart';
class pageRoutes{

  static String dashboard = DashboardScreen.routeName;
  static String userList = UserListScreen.routeName;
  static String userDetails = UserDetails.routeName;
  
  static Map<String,dynamic> goTo = {
    DashboardScreen.routeName: DashboardScreen(),
    UserListScreen.routeName: UserListScreen(),
    UserDetails.routeName: UserDetails()
  };
}